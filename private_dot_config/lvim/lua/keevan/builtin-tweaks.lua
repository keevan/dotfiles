-- [ Disabled built-ins] --
-- List of plugins never used in vim
local builtin_plugs = {
    '2html_plugin',
    'getscript',
    'getscriptPlugin',
    'gzip',

    'matchit',
    'matchparen',
    'netrwPlugin',
    -- 'rplugin', -- Looks needed
    'shada_plugin',     -- shada
    'spellfile_plugin', -- spellfile

    'tarPlugin',
    'tohtml',
    'tutor_mode', -- tutor
    'zipPlugin',
}
for i = 1, #builtin_plugs do
    vim.g['loaded_' .. builtin_plugs[i]] = true
end

-- Disabling lunarvim core plugins
lvim.builtin.alpha.active = false     -- Actually don't need it anymore
lvim.builtin.dap.active = false

-- [ Vim options ] --
vim.opt.colorcolumn = "92"

-- PHP to include $ in word (php variables).
vim.opt.iskeyword = vim.opt.iskeyword + "$"

-- Fold settings
vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true


-- [ LunarVim options ] --
lvim.builtin.project.patterns = { ".git", ">apps", ">projects" }

lvim.builtin.which_key.setup.plugins.presets.z = true

-- Don't calculate root dir on specific directories
-- Ex: { "~/.cargo/*", ... }
-- lvim.builtin.project.exclude_dirs = { "~/apps/super-pancake/*" }
-- lvim.builtin.project.manual_mode (Call :ProjectRoot)
lvim.builtin.project.patterns = { ".git", ">apps", ">projects", ">sites" }
lvim.builtin.project.manual_mode = true -- true to make it manual
lvim.builtin.project.silent_chdir = false


-- Wait a bit longer for autoformat to kick in
lvim.builtin.which_key.mappings["l"]["f"] = {
    function()
        require("lvim.lsp.utils").format { timeout_ms = 8000 }
    end,
    "Format",
}

-- Treesiter highlighter error => :TSInstall
lvim.builtin.telescope.defaults.layout_config['center'] = { width = 120 }

vim.api.nvim_create_user_command("Cppath", function()
    local path = vim.fn.expand("%:p")
    vim.fn.setreg("+", path)
    vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})
