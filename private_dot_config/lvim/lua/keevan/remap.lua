-- Reload this keymap file, until I figure out a better solution.
vim.keymap.set("n", "<F6>", ":so ~/.config/lvim/lua/keevan/remap.lua<CR>") -- Replace inner Word (since you might be on top of a range)

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
-- Practice here: https://gist.githubusercontent.com/keevan/dc2179f8fe5ab36fee20399c8e941d9c/raw/64fde14d44823cecfde23c4b99156f725fe982f0/vmpDemo.js
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- lvim.keys.normal_mode["<leader>q"] = ":bdelete<CR>"
lvim.keys.normal_mode["<leader>q"] = "<cmd>BufferKill<CR>"
-- lvim.builtin.which_key.mappings["q"] = { "<cmd>BufferClose!<CR>", "Close Buffer" }

lvim.keys.insert_mode["jk"] = "<Esc>"
lvim.keys.normal_mode["<CR>"] = "zt"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["gt"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["gT"] = ":BufferLineCyclePrev<CR>"
-- Open projects
lvim.keys.normal_mode["<A-S-p>"] = ":Telescope projects<CR>"
-- lvim.keys.normal_mode["<C-e>"] = ":Telescope live_grep<CR>"
lvim.keys.normal_mode["<leader>sT"] = ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>"

-- TODO: Stay mappings (affects yank and visual select)
-- Manually do it for now until a better solution shows up.. (remember operator, starting pos, and position afterwards)
vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)")
vim.keymap.set({ "n" }, "Y", "y$")

-- Toggle ___
vim.keymap.set("n", "tw", ":set wrap!<CR>", {}) -- toggle line/word wrap

-- Operator mappings
vim.keymap.set("o", "p", "ip", {}) -- inner paragraph
vim.keymap.set("o", "c", "iw", {}) -- inner word
vim.keymap.set("o", "C", "iW", {}) -- inner WORD

-- Line
vim.keymap.set({ "o", "x" }, "il", '<cmd>lua require("various-textobjs").lineCharacterwise(true)<CR>')
vim.keymap.set({ "o", "x" }, "al", '<cmd>lua require("various-textobjs").lineCharacterwise(false)<CR>')

-- Visible in window
vim.keymap.set({ "o", "x" }, "iv", '<cmd>lua require("various-textobjs").visibleInWindow()<CR>')
vim.keymap.set({ "o", "x" }, "av", '<cmd>lua require("various-textobjs").visibleInWindow()<CR>')

-- Entire buffer
vim.keymap.set({ "o", "x" }, "ie", '<cmd>lua require("various-textobjs").entireBuffer()<CR>')
vim.keymap.set({ "o", "x" }, "ae", '<cmd>lua require("various-textobjs").entireBuffer()<CR>')

-- Subword
vim.keymap.set({ "o", "x" }, "gd", '<cmd>lua require("various-textobjs").subword(true)<CR>')
vim.keymap.set({ "o", "x" }, "id", '<cmd>lua require("various-textobjs").subword(true)<CR>')
vim.keymap.set({ "o", "x" }, "ad", '<cmd>lua require("various-textobjs").subword(false)<CR>')

-- Open list of files containing the word under the cursor
vim.keymap.set(
	"n",
	"<C-e>",
	"<cmd>lua require('telescope.builtin').live_grep({ default_text = vim.fn.expand('<cword>') })<CR>"
)

-- TODO: find an equivalent to mark and replace all those VISIBLE on the page.
-- Convenience for when  you don't care about if it's in a function, block, etc
-- and you know it's in the visible area of the screen, but you don't want to
-- update anything that might be located elsewhere (thus not using entire
-- buffer textObj)

-- TODO: set TAB to something useful? Maybe a function jump? Maybe a context-level block jump?

-- Mappings from theprimeagen (mixed with those from t9md's vmp)
-- vim.keymap.set('n', "J", "mzJ`z", {})  -- Join the next line, but stay in the same pos?
vim.keymap.set("n", "<C-d>", "<C-d>zz") -- Half page up & down with cursor in middle
vim.keymap.set("n", "<C-u>", "<C-u>zz") -- Half page up & down with cursor in middle
vim.keymap.set("n", "n", "nzzzv") -- Search keeps things in the middle
vim.keymap.set("n", "N", "Nzzzv") -- Search keeps things in the middle

vim.keymap.set("x", "<leader>p", '"_dP') -- Search keeps things in the middle

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
vim.keymap.set("n", "-", "<Plug>ReplaceWithRegisterOperator") -- Search keeps things in the middle
vim.keymap.set("n", "-l", "<Plug>ReplaceWithRegisterLine") -- Search keeps things in the middle
vim.keymap.set("x", "-", "<Plug>ReplaceWithRegisterVisual") -- Search keeps things in the middle
vim.keymap.set("n", "--", "viw<Plug>ReplaceWithRegisterVisual") -- Search keeps things in the middle

-- ctrl-shift-d logic, similar to Atom
-- The column should stay at the same e.g. the duplicate needs a change in the same place, next line
-- Also, duplicating shouldn't put the content into the default clipboard (so put it in "z" register)
-- Duplicate and don't yank to default clipboard
vim.keymap.set("n", "<C-S-d>", 'mz"zyy"zp`zj')
-- Duplicate selection, avoid default clipboard, keep selection range (for more
-- duplication as required). Small bug where selection was done going up, the
-- selection after the duplication is on the first line only.
vim.keymap.set("x", "<C-S-d>", 'mz"zymx"zP`xV`z')

-- Copy relative path (ctrl+shift+x) and print path in status-line
vim.keymap.set(
	"n",
	"<C-S-x>",
	':let relpath = fnamemodify(expand("%"), ":~:.") <bar> let @+ = relpath <bar> echo relpath<CR>',
	{ silent = true }
)

-- TKS - Insert time HH:MM when pressing F5
vim.keymap.set("n", "<F5>", 'viW"=strftime("%H:%M")<CR>P') -- Replace inner Word (since you might be on top of a range)
vim.keymap.set("i", "<F5>", '<C-R>=strftime("%H:%M")<CR>') -- Insert only the time.

-- Flash remote action
-- Credits to max397574 here: https://github.com/folke/flash.nvim/discussions/24
vim.keymap.set("o", "r", function()
	local operator = vim.v.operator
	local register = vim.v.register
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, true, true), "o", true)
	vim.schedule(function()
		require("flash").jump({
			action = function(match, state)
				local op_func = vim.go.operatorfunc
				local saved_view = vim.fn.winsaveview()
				vim.api.nvim_set_current_win(match.win)
				vim.api.nvim_win_set_cursor(match.win, match.pos)
				_G.flash_op = function()
					local start = vim.api.nvim_buf_get_mark(0, "[")
					local finish = vim.api.nvim_buf_get_mark(0, "]")
					print(start[2])
					vim.api.nvim_cmd({ cmd = "normal", bang = true, args = { "v" } }, {})
					vim.api.nvim_win_set_cursor(0, { start[1], start[2] })
					vim.cmd("normal! o")
					vim.api.nvim_win_set_cursor(0, { finish[1], finish[2] })
					vim.go.operatorfunc = op_func
					vim.api.nvim_input('"' .. register .. operator)
					vim.schedule(function()
						vim.api.nvim_set_current_win(state.win)
						vim.fn.winrestview(saved_view)
					end)
					_G.flash_op = nil
				end
				vim.go.operatorfunc = "v:lua.flash_op"
				vim.api.nvim_feedkeys("g@", "n", false)
			end,
		})
	end)
end)

-- For some reason this was broken?
vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>")
vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>")

-- Start and stop the LSP (on demand via remap) -- off by default = faster edits/movements by default until some drilling required.
vim.keymap.set("n", "<leader>l1", "<cmd>LspStart<cr>")
vim.keymap.set("n", "<leader>l2", "<cmd>LspStop<cr>")

-- Quick chmod'ing
vim.keymap.set("n", "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true })

-- Toggling diagnoise-tics
local diagnostics_active = true
vim.keymap.set("n", "<leader>td", function()
	diagnostics_active = not diagnostics_active
	if diagnostics_active then
		vim.diagnostic.show()
	else
		vim.diagnostic.hide()
	end
end, { nowait = true, noremap = true })

-- TODO: go through this and set it up to match https://github.com/t9md/atom-vim-mode-plus/wiki/DifferencesFromPureVim

-- No highlight on ESC
vim.keymap.set("n", "<ESC>", ":noh<CR><ESC>", { silent = true })

-- Neotest
lvim.keys.normal_mode["<leader>tt"] = "<cmd>lua require('neotest').run.run()<CR>"
lvim.keys.normal_mode["<leader>tf"] = "<cmd>lua require('neotest').run.run()<CR>"
lvim.keys.normal_mode["<leader>te"] = '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<CR>'
lvim.keys.normal_mode["<leader>ts"] = "<cmd>lua require('neotest').summary.toggle()<CR>"
lvim.keys.normal_mode["<leader>th"] = "<cmd>Hardtime toggle<CR>"

-- NOTE: Also see "nvim-treesitter/nvim-treesitter-textobjects" settings for custom mappings
vim.keymap.set("n", "[", "<Plug>(edgemotion-k)", { nowait = true })
vim.keymap.set("n", "]", "<Plug>(edgemotion-j)", { nowait = true })
vim.keymap.set("o", "[", "<Plug>(edgemotion-k)", { nowait = true })
vim.keymap.set("o", "]", "<Plug>(edgemotion-j)", { nowait = true })

-- Buffer: delete all but current - @kshenoy https://stackoverflow.com/questions/4545275/vim-close-all-buffers-but-this-one#comment84748132_42071865
lvim.keys.normal_mode["<M-S-o>"] = "<cmd>%bd|e#|bd#<CR>"

-- Toggle symbols (outline)
lvim.keys.normal_mode["<M-o>"] = "<cmd>SymbolsOutline<CR>"

-- Substitute.nvim
-- vim.keymap.set("n", "++", function() -- testing only
-- 	require("substitute.range").operator()
-- end, { noremap = true })

-- Replace occurence with value in clipboard
vim.keymap.set("n", "-o", function()
	require("substitute.range").operator({ subject = { motion = "iw" }, register = "0" })
end, { noremap = true })
-- Change occurence
vim.keymap.set("n", "co", function()
	require("substitute.range").operator({ subject = { motion = "iw" } })
end, { noremap = true })
vim.keymap.set("x", "mc", require("substitute.range").visual, { noremap = true })
-- Mark word visually, then edit all occurences based on range / motion. (edit after)
vim.keymap.set("x", "mA", function()
	require("substitute.range").visual({ prompt_current_text = true })
end, { noremap = true })
-- Mark word visually, then edit all occurences based on range / motion. (edit before)
-- vim.keymap.set("n", "mI", function()
-- 	require("substitute.range").visual({ prompt_current_text = true })
-- end, { noremap = true })

-- cx - exchange (like in vim mode plus)
vim.keymap.set("n", "cx", function()
	require("substitute.exchange").operator({ prompt_current_text = true })
end, { noremap = true })

vim.keymap.set("x", "C", function()
	require("concise").selection()
end, { noremap = true })

-- Kill bad habits - i.e. very hard mode :-)
-- vim.keymap.set("n", "h", "<nop>")
-- vim.keymap.set("n", "j", "<nop>")
-- vim.keymap.set("n", "k", "<nop>")
-- vim.keymap.set("n", "l", "<nop>")

-- Pasting in visual mode, to NOT replace the current register/clipboard value
vim.keymap.set("x", "p", function()
	return 'pgv"' .. vim.v.register .. "y"
end, { remap = false, expr = true })

-- Treesitter unit
vim.api.nvim_set_keymap("x", "iu", ':lua require"treesitter-unit".select()<CR>', { noremap = true })
vim.api.nvim_set_keymap("x", "au", ':lua require"treesitter-unit".select(true)<CR>', { noremap = true })
vim.api.nvim_set_keymap("o", "iu", ':<c-u>lua require"treesitter-unit".select()<CR>', { noremap = true })
vim.api.nvim_set_keymap("o", "au", ':<c-u>lua require"treesitter-unit".select(true)<CR>', { noremap = true })

-- Terminal mode remaps
-- :tnoremap jk <C-\><C-N>
-- :tnoremap <C-K> <Up>
-- :tnoremap <C-J> <Down>
-- vim.keymap.set("t", "<Esc>", "<C-\\><C-N>")
vim.keymap.set("t", "<C-k>", "<Up>")
vim.keymap.set("t", "<C-j>", "<Down>")
vim.keymap.set("n", "<leader>0", ":ToggleTerm direction=horizontal<CR>")

-- Toggle through words (word switch)
vim.g.wordswitch_keymap = "<A-r>"
