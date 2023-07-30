local WR_PATTERN = "%d%d%d%d%d+"
local async = require("hover.async")

-- Enabled if:
--
-- Matches the WR request pattern
-- Or is an request alias mapped in .tksrc
local function enabled()
	if vim.fn.executable("tksrc_aliases") ~= 1 then
		return false
	end

	local matches_wr_pattern = vim.fn.expand("<cWORD>"):match(WR_PATTERN) ~= nil
	if matches_wr_pattern then
		return true
	end

	-- Blocking call as method doesn't support async.
	local handle = io.popen("tksrc_aliases")
	if not handle then
		return false
	end

	local result = handle:read("*a")
	handle:close()

	-- Decode results
	local ok, parsed = pcall(vim.json.decode, result)
	if not ok or not parsed then
		return false
	end

	-- Check if any of the aliases match the word, if yes, return true. Otherwise return false.
	local word = vim.fn.expand("<cword>")
	for _, tks_item in ipairs(parsed) do
		if tks_item.title == word then
			return true
		end
	end

	-- Otherwise leave this as disabled.
	return false
end

local function process(result)
	local ok, res = pcall(vim.json.decode, result)
	if not ok or not res or res.response == nil then
		return
	end

	---@type string[]
	local lines = {
		"__WR-" .. res.response.request.request_id .. "__ " .. res.response.request.brief,
		res.response.request.status_desc,
		"",
	}
	for s in res.response.request.detailed:gmatch("[^\r\n]+") do
		table.insert(lines, s)
	end

	return lines
end

local execute = async.void(function(done)
	local word = vim.fn.expand("<cword>")

	local job = require("hover.async.job").job

	---@type string[]
	local output = job({
		"get_wr_details",
		word,
	})

	local results = process(output)
	if not results then
		results = { "no request returned for " .. word }
	end
	done(results and { lines = results, filetype = "markdown" })
end)

require("hover").register({
	name = "WR",
	priority = 1001,
	enabled = enabled,
	execute = execute,
})
