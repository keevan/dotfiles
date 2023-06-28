-- [ Vim options ] --
vim.opt.colorcolumn = "92"


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
