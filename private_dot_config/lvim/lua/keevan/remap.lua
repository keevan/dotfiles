-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- lvim.keys.normal_mode["<leader>q"] = ":bdelete<CR>"
lvim.keys.normal_mode["<leader>q"] = "<cmd>BufferKill<CR>"
-- lvim.builtin.which_key.mappings["q"] = { "<cmd>BufferClose!<CR>", "Close Buffer" }

lvim.keys.insert_mode["jk"] = "<Esc>"
lvim.keys.normal_mode["<CR>"] = "zz"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["gt"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["gT"] = ":BufferLineCyclePrev<CR>"
-- Open projects
lvim.keys.normal_mode["<A-S-p>"] = ":Telescope projects<CR>"
-- lvim.keys.normal_mode["<C-e>"] = ":Telescope live_grep<CR>"

-- Operator mappings
vim.keymap.set('o', "p", "ip", {})
-- vim.keymap.set('o', "il", "il", {})
-- vim.keymap.set('o', "ie", "ip", {})
-- Mappings from theprimeagen (mixed with those from t9md's vmp)
vim.keymap.set('n', "J", "mzJ`z", {})     -- Join the next line, but stay in the same pos
vim.keymap.set('n', "<C-d>", "<C-d>zz")   -- Half page up & down with cursor in middle
vim.keymap.set('n', "<C-u>", "<C-u>zz")   -- Half page up & down with cursor in middle
vim.keymap.set('n', "n", "nzzzv")         -- Search keeps things in the middle
vim.keymap.set('n', "N", "Nzzzv")         -- Search keeps things in the middle

vim.keymap.set('x', "<leader>p", "\"_dP") -- Search keeps things in the middle

lvim.keys.normal_mode[",ht"] = "<Plug>RestNvim"

-- Quick fix list (prev/next)
-- vim.keymap.set('n', "<C-k>", "<cmd>cprev<CR>zz")
-- vim.keymap.set('n', "<leader>k", "<cmd>lprev<CR>zz")
-- vim.keymap.set('n', "<C-j>", "<cmd>cnext<CR>zz")
-- vim.keymap.set('n', "<leader>j", "<cmd>lnext<CR>zz")
-- vim.keymap.set('n', "<leader>q", "<cmd>BufferKill!<CR>")

-- -- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

-- Persistance
-- restore the session for the current directory
lvim.keys.normal_mode["<leader>O"] = '<cmd>lua require("persistence").load()<cr>'
-- restore the last session
lvim.keys.normal_mode["<leader>o"] = '<cmd>lua require("persistence").load({ last = true })<cr>'

-- Replace with register (or thing in clipboard)
vim.keymap.set('n', "-", "<Plug>ReplaceWithRegisterOperator")   -- Search keeps things in the middle
vim.keymap.set('n', "-l", "<Plug>ReplaceWithRegisterLine")      -- Search keeps things in the middle
vim.keymap.set('x', "-", "<Plug>ReplaceWithRegisterVisual")     -- Search keeps things in the middle
vim.keymap.set('n', "--", "viw<Plug>ReplaceWithRegisterVisual") -- Search keeps things in the middle

-- ctrl-shift-d logic, similar to Atom
-- The column should stay at the same e.g. the duplicate needs a change in the same place, next line
-- Also, duplicating shouldn't put the content into the default clipboard (so put it in "z" register)
-- Duplicate and don't yank to default clipboard
vim.keymap.set('n', "<C-S-d>", 'mz"zyy"zp`zj')
-- Duplicate selection, avoid default clipboard, keep selection range (for more
-- duplication as required). Small bug where selection was done going up, the
-- selection after the duplication is on the first line only.
vim.keymap.set('x', "<C-S-d>", 'mz"zymx"zP`xV`z')
