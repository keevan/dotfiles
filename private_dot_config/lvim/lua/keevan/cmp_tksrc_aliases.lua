local ok, Job = pcall(require, "plenary.job")
if not ok then
	return
end

local source = {}

local enabled = true

source.new = function()
	local self = setmetatable({ cache = {} }, { __index = source })

	return self
end

source._trim_right = function(_, text)
	return string.gsub(text, "%s*$", "")
end

source.complete = function(self, request, callback)
	if not enabled then
		return
	end

	local bufnr = vim.api.nvim_get_current_buf()

	local input = self:_trim_right(string.sub(request.context.cursor_before_line, request.offset))

	-- The cache is so we only hit the resource once per session.
	-- Can be removed, and good for actual API calls (e.g. gh issue list)
	if not self.cache[bufnr] then
		Job:new({
			-- Fetch the list of aliases using git config:
			command = "tksrc_aliases",

			on_exit = function(job, return_val)
				local result = job:result()
				local ok, parsed = pcall(vim.json.decode, table.concat(result, ""))
				if not ok then
					enabled = false
					return
				end

				local items = {}
				for _, tks_item in ipairs(parsed) do
					local documentation = {}
					tks_item.body = string.gsub(tks_item.body or "", "\r", "")
					documentation.value = string.format("WR#%s", tks_item.number)
					table.insert(items, {
						label = string.format("%s", tks_item.title),
						tks_item = tks_item,
						textEdit = {
							-- To ensure the leading trigger character is removed
							range = {
								start = {
									line = request.context.cursor.row - 1,
									character = request.context.cursor.col - 1 - #input,
								},
								["end"] = {
									line = request.context.cursor.row - 1,
									character = request.context.cursor.col - 1,
								},
							},
							newText = tks_item.title,
							-- newText = string.format("%s", tks_item.number),
						},
						documentation = {
							kind = "markdown",
							value = documentation.value,
						},
					})
				end

				callback({ items = items, isIncomplete = false })
				-- self.cache[bufnr] = items -- disable cache
			end,
		}):start()
	else
		callback({ items = self.cache[bufnr], isIncomplete = false })
	end
end

---Resolve WR details
---Resolve completion item (optional). This is called right before the completion is about to be displayed.
---Useful for setting the text shown in the documentation window (`completion_item.documentation`).
---@param completion_item lsp.CompletionItem
---@param callback fun(completion_item: lsp.CompletionItem|nil)
function source:resolve(completion_item, callback)
	-- print(vim.inspect(completion_item))

	Job:new({
		command = "get_wr_details",
		args = { completion_item.tks_item.number },

		on_exit = function(j)
			local result = j:result()
			local ok, wr_details = pcall(vim.json.decode, table.concat(result, ""))
			if not ok then
				enabled = false
				return
			end
			-- print(vim.inspect(wr_details))

			completion_item.documentation.value = string.format(
				"%s - %s\n[%s]\n\n%s",
				completion_item.documentation.value,
				wr_details.response.request.brief,
				wr_details.response.request.status_desc,
				wr_details.response.request.detailed
			)
			callback(completion_item)
		end,
	}):start()
end

source.get_trigger_characters = function()
	return { "#" }
end

source.is_available = function()
	return vim.bo.filetype == "tks"
end

return source
