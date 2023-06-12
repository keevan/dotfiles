-- [ Vim options ] --
vim.opt.colorcolumn = "92"


-- [ LunarVim options ] --
lvim.builtin.project.patterns = { ".git", ">apps", ">projects" }

-- Don't calculate root dir on specific directories
-- Ex: { "~/.cargo/*", ... }
-- lvim.builtin.project.exclude_dirs = { "~/apps/super-pancake/*" }
lvim.builtin.project.manual_mode = true
lvim.builtin.project.silent_chdir = false
