-- [ Disabled built-ins] --
-- List of plugins never used in vim
local builtin_plugs = {
	"2html_plugin",
	"getscript",
	"getscriptPlugin",
	"gzip",

	"matchit",
	"matchparen",
	"netrwPlugin",
	-- 'rplugin', -- Looks needed
	"shada_plugin", -- shada
	"spellfile_plugin", -- spellfile

	"tarPlugin",
	"tohtml",
	"tutor_mode", -- tutor
	"zipPlugin",
}
for i = 1, #builtin_plugs do
	vim.g["loaded_" .. builtin_plugs[i]] = true
end

-- Disabling lunarvim core plugins
lvim.builtin.alpha.active = true -- Actually don't need it anymore
lvim.builtin.indentlines.active = false -- Might be causing lag?
-- lvim.builtin.project.active = false -- Actually don't need it anymore
-- lvim.builtin.dap.active = false

-- [ Vim options ] --
vim.opt.colorcolumn = "132" -- Default to limit for now, might be conditional later.
-- vim.opt.colorcolumn = "92"

-- PHP to include $ in word (php variables).
vim.opt.iskeyword = vim.opt.iskeyword + "$"

-- Fold settings
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- [ LunarVim options ] --
lvim.builtin.which_key.setup.plugins.presets.z = true

-- Don't calculate root dir on specific directories
-- Ex: { "~/.cargo/*", ... }
-- lvim.builtin.project.exclude_dirs = { "~/apps/super-pancake/*" }
-- lvim.builtin.project.manual_mode (Call :ProjectRoot)
lvim.builtin.project.patterns = {
	-- Includes
	".git",
	">apps",
	">projects",
	">sites",
	">work",
	-- Skips
	"!.local/share",
	"!~",
}
lvim.builtin.project.manual_mode = true -- true to make it manual, false for automatically adding things which fit a pattern (currently it auto changes CWDs which is annoying)
lvim.builtin.project.silent_chdir = false
lvim.builtin.project.exclude_dirs = { "~/" }
lvim.builtin.nvimtree.setup.sync_root_with_cwd = true
lvim.builtin.nvimtree.setup.respect_buf_cwd = true
lvim.builtin.nvimtree.setup.actions.change_dir.enable = false
lvim.builtin.nvimtree.setup.update_focused_file.enable = true
lvim.builtin.nvimtree.setup.update_focused_file.update_root = false -- Don't automatically switch the project root on change

-- Wait a bit longer for autoformat to kick in
lvim.builtin.which_key.mappings["l"]["f"] = {
	function()
		require("lvim.lsp.utils").format({ timeout_ms = 8000 })
	end,
	"Format",
}

-- Treesiter highlighter error => :TSInstall
lvim.builtin.telescope.defaults.layout_config["center"] = { width = 120 }

vim.api.nvim_create_user_command("Cppath", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

-- Path display of items shown.. no longer trapped by a directory and file, but can see further into the abyss.
lvim.builtin.telescope.defaults.path_display = { truncate = 3 }
lvim.builtin.telescope.defaults.file_ignore_patterns =
	{ ".git/*", "yuilib/*", "yui/build", "aws/sdk", "lib/google/src", "build/*" }

-- Project updates to display
lvim.builtin.project.transform_path = function(path)
	return vim.fn.fnamemodify(path, ":~")
end

lvim.builtin.project.transform_name = function(path)
	-- Shorten the docker-dev path to always include the site/client name before the repo name
	local name = vim.fn.fnamemodify(path, ":t")
	local prefix = "docker%-dev/sites/"
	local input_string = path

	local start_pos, end_pos = string.find(input_string, prefix .. "([%w%-]+)/")
	if start_pos then
		local extracted_word = string.sub(input_string, start_pos + #prefix - 1, end_pos - 1)
		name = extracted_word .. " -> " .. name
	end

	return name
end

-- -- Autocommands  <https://neovim.io/doc/user/autocmd.html>
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
--
-- Add new sources
-- https://github.com/LunarVim/LunarVim/issues/4204
vim.list_extend(lvim.builtin.cmp.sources, {
	{ name = "tksrc_aliases" },
	{ name = "nvim_lsp_signature_help" },
})
