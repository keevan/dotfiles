--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]
-- vim options
-- vim.opt.shiftwidth = 4
-- vim.opt.tabstop = 4
vim.opt.relativenumber = true

-- general
lvim.log.level = "info"
lvim.format_on_save = {
	enabled = true,
	pattern = "*.lua",
	timeout = 1000,
}

lvim.lazy.opts.performance.rtp.disabled_plugins = {
	"gzip",
	"matchit",
	"matchparen",
	"netrwPlugin",
	"tarPlugin",
	"tohtml",
	"tutor",
	"zipPlugin",
	"rplugin",
	"shada",
	"spellfile",
}
lvim.lazy.opts.dev = {
	path = "~/projects", -- directory where you store your local plugin projects
	patterns = {}, -- For example {"folke"}
	fallback = true, -- Fallback to git when local plugin doesn't exist
}

-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

require("keevan.builtin-tweaks")

lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- always installed on startup, useful for parsers without a strict filetype
-- lvim.builtin.treesitter.ensure_installed = { "comment", "markdown_inline", "regex" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>

-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ command = "stylua" },
	{
		command = "prettier",
		extra_args = { "--print-width", "100" },
		filetypes = { "typescript", "typescriptreact" },
	},
	-- {
	--     command = "pint",
	--     filetypes = { "php" },
	-- },
	{
		command = "phpcbf",
	},
})
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{ command = "phpcs", filetypes = { "php" } },
	{ command = "flake8", filetypes = { "python" } },
	{
		command = "shellcheck",
		args = { "--severity", "warning" },
	},
})

-- Additional Plugins <https://www.lunarvim.org/docs/configuration/plugins/user-plugins>
lvim.plugins = {
	{
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
	},
	{
		"jdhao/better-escape.vim",
		cmd = "InsertEnter",
	},
	{
		"vim-scripts/ReplaceWithRegister",
		event = "TextYankPost",
	},

	-- Syntax and indent files
	-- loading this on ft because that seems to work better for some reason
	-- otherwise indents for example only work after set ft=blade
	-- blade
	{
		"jwalton512/vim-blade",
		ft = "blade",
	},

	{
		"ruifm/gitlinker.nvim",
		event = "BufRead",
		config = function()
			require("gitlinker").setup({
				opts = {
					-- remote = 'github', -- force the use of a specific remote
					-- adds current line nr in the url for normal mode
					add_current_line_on_normal_mode = true,
					-- callback for what to do with the url
					action_callback = function(url)
						-- Get current value in clipboard
						local cb = vim.fn.getreg("+")
						-- Check if this is already the same value as the clipboard.
						-- If yes, open in browser
						if cb == url then
							print("Opening " .. url)
							require("gitlinker.actions").open_in_browser(url)
							return
						end

						-- Otherwise, copy only and print message
						require("gitlinker.actions").copy_to_clipboard(url)
						print("Copied " .. url)
					end,
					-- print the url after performing the action
					print_url = false,
					-- mapping to call url generation
					-- mappings = "<leader>gy",
				},
				mappings = "<C-S-0>",
				callbacks = {
					["git.catalyst-au.net"] = require("gitlinker.hosts").get_gitlab_type_url,
				},
			})
		end,
		dependencies = "nvim-lua/plenary.nvim",
	},

	-- Actually don't use it yet, but seems nice. (Does take some time to load)
	-- {
	--     "pwntester/octo.nvim",
	--     dependencies = {
	--         'nvim-lua/plenary.nvim',
	--         'nvim-telescope/telescope.nvim',
	--         'nvim-tree/nvim-web-devicons',
	--     },
	--     config = function()
	--         require("octo").setup()
	--     end,
	-- },

	-- { "metalelf0/jellybeans-nvim" },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				transparent_background = true, -- disables setting the background color.
				integrations = {
					harpoon = true,
					leap = true, -- Yes, no weird blocks, just highlight the 3rd character
					which_key = true,
					cmp = true,
				},
				custom_highlights = function(colors)
					return {
						NormalFloat = { bg = colors.crust }, -- Diagnostics float window (shift+K)
					}
				end,
			})
		end,
	},

	-- Real time colorscheme helper
	-- { "rktjmp/lush.nvim" },

	{
		"folke/flash.nvim",
		event = "BufReadPre",
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					-- default options: exact mode, multi window, all directions, with a backdrop
					require("flash").jump()
				end,
			},
			{
				"S",
				mode = { "n", "o", "x" },
				function()
					require("flash").treesitter()
				end,
			},
		},
	},

	{
		"chrisgrieser/nvim-various-textobjs",
		event = "BufReadPre",
		config = function()
			require("various-textobjs").setup({
				useDefaultKeymaps = true,
				-- disable some default keymaps, e.g. { "ai", "ii" }
				disabledKeymaps = { "r" },
			})
		end,
	},

	-- autoclose and autorename html tag
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		config = function()
			require("nvim-ts-autotag").setup({
				filetypes = {
					"html",
					"javascript",
					"typescript",
					"javascriptreact",
					"typescriptreact",
					"svelte",
					"vue",
					"tsx",
					"jsx",
					"rescript",
					"xml",
					"php",
					"blade",
					"markdown",
					"astro",
					"glimmer",
					"handlebars",
					"hbs",
				},
			})
		end,
	},

	-- Hint as you type
	{
		"ray-x/lsp_signature.nvim",
		event = "BufRead",
		config = function()
			require("lsp_signature").on_attach()
		end,
	},

	-- Session management
	{
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		config = function()
			require("persistence").setup({
				dir = vim.fn.expand(vim.fn.stdpath("config") .. "/session/"),
				options = { "buffers", "curdir", "tabpages", "winsize" },
			})
		end,
	},

	-- Hey, check it out, it's pretty cool!
	{
		"ThePrimeagen/harpoon",
		event = "VeryLazy",
		config = function()
			local mark = require("harpoon.mark")
			local ui = require("harpoon.ui")

			vim.keymap.set("n", "<leader>a", mark.add_file)
			vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

			vim.keymap.set("n", "<C-h>", function()
				ui.nav_file(1)
			end)
			vim.keymap.set("n", "<C-j>", function()
				ui.nav_file(2)
			end)
			vim.keymap.set("n", "<C-k>", function()
				ui.nav_file(3)
			end)
			vim.keymap.set("n", "<C-l>", function()
				ui.nav_file(4)
			end)
		end,
	},

	-- HTTP rest client - useful for testing, has ability to replay previous requests :-)
	-- File would be in the typical format of tests.http
	{
		"rest-nvim/rest.nvim",
		ft = "http",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("rest-nvim").setup({
				-- Open request results in a horizontal split
				result_split_horizontal = false,
				-- Keep the http file buffer above|left when split horizontal|vertical
				result_split_in_place = false,
				-- Skip SSL verification, useful for unknown certificates
				skip_ssl_verification = true,
				-- Encode URL before making request
				encode_url = true,
				-- Highlight request on run
				highlight = {
					enabled = true,
					timeout = 150,
				},
				result = {
					-- toggle showing URL, HTTP info, headers at top the of result window
					show_url = true,
					-- show the generated curl command in case you want to launch
					-- the same request via the terminal (can be verbose)
					show_curl_command = false,
					show_http_info = true,
					show_headers = true,
					-- executables or functions for formatting response body [optional]
					-- set them to false if you want to disable them
					formatters = {
						json = "jq",
						html = function(body)
							return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
						end,
					},
				},
				-- Jump to request line on run
				jump_to_request = false,
				env_file = ".env",
				custom_dynamic_variables = {},
				yank_dry_run = true,
			})
		end,
	},

	-- Comma split join plugin
	{
		"Wansmer/treesj",
		keys = { "<space>m", "<space>j", "<space>s" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesj").setup({
				max_join_length = 500,
			})
		end,
	},

	-- UFO folds
	{
		"kevinhwang91/nvim-ufo",
		event = "BufReadPre",
		dependencies = { "kevinhwang91/promise-async" },
		config = function()
			require("ufo").setup({
				provider_selector = function(bufnr, filetype, buftype)
					return { "treesitter", "indent" }
				end,
			})
		end,
	},

	-- Trim for whitespaces
	{
		"cappyzawa/trim.nvim",
		event = "InsertLeave",
		config = function()
			require("trim").setup({})
		end,
	},

	-- Pretty good, unusual keybinds though, may remap them. (W is unfold?)
	{
		"simrat39/symbols-outline.nvim",
		event = "BufReadPre",
		config = function()
			require("symbols-outline").setup({})
		end,
	},
	{
		"tpope/vim-surround",
		event = "BufReadPre",
	},
	{
		"nvim-neotest/neotest",
		ft = "php", -- only test php things for now (lazy loaded= center)
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"olimorris/neotest-phpunit",
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-phpunit")({
						phpunit_cmd = function()
							-- return os.getenv("HOME") .. "/phpunit-test.sh"
							return os.getenv("HOME") .. "/scripts/ctrl test"
						end,
						root_files = { "composer.json", "phpunit.xml", ".gitignore", "version.php" },
						filter_dirs = { ".git", "node_modules", "vendor", "sdk" },
					}),
				},
			})
		end,
	},

	-- Copilot
	{
		"zbirenbaum/copilot-cmp",
		event = "InsertEnter",
		dependencies = { "zbirenbaum/copilot.lua" },
		config = function()
			vim.defer_fn(function()
				require("copilot").setup() -- https://github.com/zbirenbaum/copilot.lua/blob/master/README.md#setup-and-configuration
				require("copilot_cmp").setup() -- https://github.com/zbirenbaum/copilot-cmp/blob/master/README.md#configuration
			end, 100)
		end,
	},

	-- More text objects please.
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		event = "BufReadPre",
		config = function()
			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							-- Your custom capture.,
							-- ["aF"] = "@custom_capture",

							-- Built-in captures I would use
							["if"] = "@function.inner",
							["i,"] = "@parameter.inner",
							["af"] = "@function.outer",
							["a,"] = "@parameter.outer",
						},
					},
					swap = {
						-- Tbh, I'm used to parameter shifting like in Atom's VMP
						enable = true,
						swap_next = {
							["g>"] = "@parameter.inner",
						},
						swap_previous = {
							["g<"] = "@parameter.inner",
						},
					},
				},
			})
		end,
	},

	-- Livin' on the edge. Would be nice if there was a port to lua which might give some performance benefits(?)
	{
		"haya14busa/vim-edgemotion",
		event = "BufReadPre",
	},

	-- SQL completion (full dad mode)
	-- {
	--     "kristijanhusak/vim-dadbod-ui",
	--     dependencies = { "tpope/vim-dadbod" }
	-- },
	-- "kristijanhusak/vim-dadbod-completion",
	--

	-- Explains regex strings nicely (trying it out)
	{
		"tomiis4/Hypersonic.nvim",
		event = "CmdlineEnter",
		cmd = "Hypersonic",
		config = function()
			require("hypersonic").setup({
				-- config
			})
		end,
	},

	-- Mainly used for yanking and keeping the cursor in place.
	-- Huge QoL.
	-- Need a way to flash on UNDO though.
	{
		"gbprod/yanky.nvim",
		event = "BufReadPre",
		config = function()
			require("yanky").setup({
				highlight = {
					on_yank = true,
					timer = 100,
				},
			})
		end,
	},

	-- Operator motion? CX (exchange)
	{
		"gbprod/substitute.nvim",
		config = function()
			require("substitute").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	},

	-- Custom plugin (concise.nvim)
	{
		"keevan/concise.nvim",
		dir = os.getenv("HOME" .. "/projects/concise.nvim"),
		config = true,
		dev = true,
		-- config = function()
		--     require("concise").setup({
		--         withDefaultReplacements = false
		--     })
		-- end,
	},

	-- project.nvim
	{
		-- "keevan/project.nvim",
		"ahmedkhalf/project.nvim",
		dir = os.getenv("HOME" .. "/projects/project.nvim"),
		dev = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("lvim.core.project").setup()

			-- require("project_nvim").setup({
			-- 	transform_path = function(path)
			-- 		return vim.fn.fnamemodify(path, ":~")
			-- 	end,
			-- })
		end,
		enabled = lvim.builtin.project.active,
		event = "VimEnter",
		cmd = "Telescope projects",
	},
}

lvim.builtin.project.transform_path = function(path)
	return vim.fn.fnamemodify(path, ":~")
end

lvim.builtin.project.transform_name = function(path)
	return vim.fn.fnamemodify(path, ":t")
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
require("keevan")
