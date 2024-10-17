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
	pattern = { "*.lua" },
	-- pattern = { "*.lua", "*.tks" },
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
	"rplugin", -- Neotest needs this?
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
lvim.builtin.treesitter.context_commentstring = nil -- https://github.com/LunarVim/LunarVim/issues/4468

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- always installed on startup, useful for parsers without a strict filetype
-- lvim.builtin.treesitter.ensure_installed = { "comment", "markdown_inline", "regex" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>

-- --- disable automatic installation of servers
lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
vim.list_extend(
	lvim.lsp.automatic_configuration.skipped_servers,
	{ "tsserver", "tailwindcss-language-server", "intelliphense" }
)
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "tailwindcss-language-server" })
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
		command = "yamlfmt",
		filetypes = { "yaml", "yml" },
	},
	{
		command = "prettier",
		extra_args = { "--print-width", "100" },
		filetypes = { "typescript", "typescriptreact" },
	},
	-- {
	-- 	command = "tkss",
	-- 	extra_args = { "format" },
	-- 	filetypes = { "tks" },
	-- },
	-- {
	--     command = "pint",
	--     filetypes = { "php" },
	-- },
	{
		command = "phpcbf",
		-- extra_args = { "--standard=moodle" },
	},
})

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{ command = "phpcs", filetypes = { "php" } },
	-- { name = "psalm", filetypes = { "php" } },
	{ command = "flake8", filetypes = { "python" } },
	{ command = "vale", filetypes = { "markdown", "tks", "txt" } },
	-- { command = "proselint", filetypes = { "markdown" } },
	-- { command = "prosemd-lsp", filetypes = { "markdown" } },
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

	{ "metalelf0/jellybeans-nvim" },
	{ "rose-pine/neovim", name = "rose-pine" },
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
		"David-Kunz/treesitter-unit",
		event = "BufReadPre",
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
	-- {
	-- 	"ray-x/lsp_signature.nvim",
	-- 	event = "BufRead",
	-- 	config = function()
	-- 		require("lsp_signature").on_attach()
	-- 	end,
	-- },

	--
	{
		"hrsh7th/cmp-nvim-lsp-signature-help",
		event = "BufRead",
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
	-- {
	-- 	"ThePrimeagen/harpoon",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		local mark = require("harpoon.mark")
	-- 		local ui = require("harpoon.ui")

	-- 		vim.keymap.set("n", "<leader>a", mark.add_file)
	-- 		vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

	-- 		vim.keymap.set("n", "<C-h>", function()
	-- 			ui.nav_file(1)
	-- 		end)
	-- 		vim.keymap.set("n", "<C-j>", function()
	-- 			ui.nav_file(2)
	-- 		end)
	-- 		vim.keymap.set("n", "<C-k>", function()
	-- 			ui.nav_file(3)
	-- 		end)
	-- 		vim.keymap.set("n", "<C-l>", function()
	-- 			ui.nav_file(4)
	-- 		end)
	-- 	end,
	-- },

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
			require("treesj").setup({ max_join_length = 500 })
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
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"nvim-neotest/neotest",
		enabled = false,
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
						-- phpunit_cmd = function()
						-- 	-- return os.getenv("HOME") .. "/phpunit-test.sh"
						-- 	-- return os.getenv("HOME") .. "/scripts/ctrl test"
						-- end,
						root_files = { "composer.json", "phpunit.xml", ".gitignore", "version.php" },
						-- filter_dirs = { ".git", "node_modules", "vendor", "sdk" },
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
				require("copilot").setup({
					suggestion = {
						enabled = true,
						auto_trigger = false,
						debounce = 75,
						keymap = {
							accept = "<M-;>",
							accept_word = false,
							accept_line = false,
							next = "<M-]>",
							prev = "<M-[>",
							dismiss = "<C-]>",
						},
					},
				}) -- https://github.com/zbirenbaum/copilot.lua/blob/master/README.md#setup-and-configuration
				require("copilot_cmp").setup() -- https://github.com/zbirenbaum/copilot-cmp/blob/master/README.md#configuration
			end, 100)
		end,
	},

	-- Copilot chat
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		opts = {
			debug = true, -- Enable debugging
			-- See Configuration section for rest
		},
		-- See Commands section for default commands if you want to lazy load on them
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
	-- {
	-- 	"tomiis4/Hypersonic.nvim",
	-- 	event = "CmdlineEnter",
	-- 	cmd = "Hypersonic",
	-- 	config = function()
	-- 		require("hypersonic").setup({
	-- 			-- config
	-- 		})
	-- 	end,
	-- },

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
		dir = "~/projects/concise.nvim",
		-- config = true,
		dev = true,
		config = function()
			require("concise").setup({
				withDefaultReplacements = false,
			})
		end,
	},

	-- project.nvim
	{
		-- "keevan/project.nvim",
		"ahmedkhalf/project.nvim",
		dir = os.getenv("HOME") .. "/projects/project.nvim",
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

	{
		"lewis6991/hover.nvim",
		event = "VimEnter",
		config = function()
			require("hover").setup({
				init = function()
					-- Require providers
					require("hover.providers.lsp")
					require("hover.providers.gh")
					-- require('hover.providers.gh_user')
					-- require('hover.providers.jira')
					-- require('hover.providers.man')
					require("hover.providers.dictionary")
					require("keevan.hover.provider.wr")
				end,
				preview_opts = {
					border = nil,
				},
				-- Whether the contents of a currently open hover window should be moved
				-- to a :h preview-window when pressing the hover keymap.
				preview_window = false,
				title = true,
			})

			-- Setup keymaps
			vim.keymap.set("n", "K", require("hover").hover, { desc = "hover.nvim" })
			vim.keymap.set("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })
		end,
	},

	-- Code actions in a telescopic menu? Yes.
	{ "nvim-telescope/telescope-ui-select.nvim", event = "VimEnter" },

	-- Faster typescript language server
	{
		"pmizio/typescript-tools.nvim",
		-- ft = { "typescript", "typescriptreact", "typescript.tsx" },
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
	},

	-- Bionic like reading? Sure let's try it out.
	-- { "JellyApple102/easyread.nvim", event = "VimEnter" },
	{
		"kevinhwang91/nvim-bqf",
		ft = "qf",
	},

	-- FZF (bqf fzf and probably other things)
	{ "junegunn/fzf", dir = "~/.fzf", build = "./install --all" },

	-- {
	-- 	"m4xshen/hardtime.nvim",
	-- 	dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
	-- 	opts = {
	-- 		restriction_mode = "hint",
	-- 		disable_mouse = false, -- This is fine, I use it seldomly and mainly when pairing
	-- 	},
	-- },
	{
		"m4xshen/smartcolumn.nvim",
		opts = {
			disabled_filetypes = {
				"alpha",
				"help",
				"text",
				"markdown",
				"NvimTree",
				"lazy",
				"mason",
				"help",
				"checkhealth",
				"lspinfo",
				"noice",
				"Trouble",
				"fish",
				"zsh",
			},
			colorcolumn = "92",
			custom_colorcolumn = { php = "132" },
		},
	},

	-- {
	-- 	"nvim-telescope/telescope-live-grep-args.nvim",
	-- 	config = function()
	-- 		require("telescope").load_extension("live_grep_args")
	-- 	end,
	-- },

	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-telescope/telescope-live-grep-args.nvim" },
		},
		config = function()
			-- require("telescope").load_extension("live_grep_args")
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local lga_actions = require("telescope-live-grep-args.actions")
			telescope.setup({
				-- Ensure hidden files can be filterd and selected by find_files picker.
				pickers = {
					find_files = {
						hidden = true,
						find_command = {
							"rg",
							"--files",
							"--iglob",
							"!.git",
							"--hidden",
							"--ignore-file",
							"~/.rgignore",
						},
					},
				},
				defaults = {
					mappings = {
						i = {
							["<C-n>"] = actions.move_selection_next,
							["<C-p>"] = actions.move_selection_previous,
							["<C-c>"] = actions.close,
							["<C-j>"] = actions.cycle_history_next,
							["<C-k>"] = actions.cycle_history_prev,
							["<C-q>"] = function(...)
								actions.smart_send_to_qflist(...)
								actions.open_qflist(...)
							end,
							["<CR>"] = actions.select_default,
						},
						n = {
							["<C-n>"] = actions.move_selection_next,
							["<C-p>"] = actions.move_selection_previous,
							["<C-q>"] = function(...)
								actions.smart_send_to_qflist(...)
								actions.open_qflist(...)
							end,
						},
					},
				},
				extensions = {
					live_grep_args = {
						auto_quoting = true, -- enable/disable auto-quoting
						-- define mappings, e.g.
						mappings = { -- extend mappings
							i = {
								["<C-s>"] = lga_actions.quote_prompt({ postfix = " -t" }),
								["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
								["<C-f>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
							},
							n = {
								["<leader>s"] = lga_actions.quote_prompt({ postfix = " -iglob **" }),
							},
						},
						-- ... also accepts theme settings, for example:
						-- theme = "dropdown", -- use dropdown theme
						-- theme = { }, -- use own theme spec
						-- layout_config = { mirror=true }, -- mirror preview pane
					},
				},
			})
		end,
	},

	-- Debugging
	{
		"mfussenegger/nvim-dap",
		config = function()
			lvim.builtin.dap.ui.config.element_mappings.watches = {
				remove = "d",
				edit = "c",
				repl = "y",
			}
			lvim.builtin.dap.ui.config.element_mappings.watches = {
				edit = "c",
				expand = "<CR>",
				repl = "y",
			}
			require("lvim.core.dap").setup()
		end,
		lazy = true,
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"williamboman/mason-lspconfig.nvim",
		},
		enabled = lvim.builtin.dap.active,
	},
	-- {
	-- 	"theHamsta/nvim-dap-virtual-text",
	-- 	dependencies = {
	-- 		"mfussenegger/nvim-dap",
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 	},
	-- 	opts = {},
	-- },
	--
	{ "rebelot/kanagawa.nvim" },
	-- { "ellisonleao/gruvbox.nvim" },
	{ "sainnhe/everforest" },
	{ "sainnhe/gruvbox-material" },

	-- Supercharge rust?
	-- {
	-- 	"mrcjkb/rustaceanvim",
	-- 	version = "^4", -- Recommended
	-- 	ft = { "rust" },
	-- },
	--
	{
		url = "https://gitlab.com/schrieveslaach/sonarlint.nvim",
		ft = { "php" },
		config = function()
			-- note: sudo apt install openjdk-17-jre-headless # for appropriate version
			require("sonarlint").setup({
				autostart = false,
				server = {
					cmd = {
						"sonarlint-language-server",
						-- Ensure that sonarlint-language-server uses stdio channel
						"-stdio",
						"-analyzers",
						-- paths to the analyzers you need, using those for python and java in this example
						vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarphp.jar"),
						-- vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarpython.jar"),
						-- vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarcfamily.jar"),
						-- vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjava.jar"),
					},
					settings = {
						sonarlint = {
							rules = {
								["php:S103"] = { level = "off" }, -- char count
								["php:S6600"] = { level = "off" }, -- require_once
								["php:S4833"] = { level = "off" }, -- require_once
								["php:S101"] = { level = "off" }, -- naming
								["php:S100"] = { level = "off" }, -- naming
								["php:S1793"] = { level = "off" }, -- elseif vs else if
								["php:S1192"] = { level = "off" }, -- duplicate strings to be constants (sometimes good, usually noise)
							},
						},
					},
				},
				filetypes = {
					-- Tested and working
					"php",
					-- "python",
					-- "cpp",
					-- "java",
				},
			})
		end,
	},
	{ "tandy1229/wordswitch.nvim" },

	-- Some alpha ness.
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = function()
			require("alpha")
			require("alpha.term")
			local dashboard = require("alpha.themes.dashboard")

			dashboard.section.buttons.val = {
				dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("f", "󰈞 " .. " Find file", ":Telescope find_files <CR>"),
				dashboard.button("r", "󰊄 " .. " Recent files", ":Telescope oldfiles <CR>"),
				dashboard.button("g", "󰈬 " .. " Find text", ":Telescope live_grep <CR>"),
				dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
				dashboard.button("s", " " .. " Open last session", [[:lua require("persistence").load() <cr>]]),
				dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
				dashboard.button("q", " " .. " Quit", ":qa<CR>"),
			}

			for _, button in ipairs(dashboard.section.buttons.val) do
				button.opts.hl = "AlphaButtons"
				button.opts.hl_shortcut = "AlphaShortcut"
			end

			local width = 46
			local height = 25 -- two pixels per vertical space

			dashboard.section.terminal.command = "cat | " .. os.getenv("HOME") .. "/.config/art/thisisfine.sh"
			dashboard.section.terminal.width = width
			dashboard.section.terminal.height = height
			dashboard.section.terminal.opts.redraw = true

			dashboard.section.header.val = "Today is going to be fine."

			dashboard.config.layout = {
				{ type = "padding", val = 1 },
				dashboard.section.terminal,
				{ type = "padding", val = 1 },
				dashboard.section.header,
				{ type = "padding", val = 1 },
				dashboard.section.buttons,
				{ type = "padding", val = 0 },
				dashboard.section.footer,
			}
			lvim.builtin.alpha.dashboard.config = dashboard.config
			return dashboard.config
		end,
	},
	{
		"stevearc/oil.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{ "lunarvim/bigfile.nvim" },
	{
		"folke/zen-mode.nvim",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	{
		-- "toppair/peek.nvim", -- official repo
		"keevan/peek.nvim",
		branch = "links",
		event = { "VeryLazy" },
		build = "deno task --quiet build:fast",
		config = function()
			require("peek").setup({
				app = "browser",
				theme = "light",
			})
			vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
			vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
		end,
	},
}

-- The need for speeeeeeed
if vim.loader then
	vim.loader.enable()
end

-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("ui-select")

require("keevan")
-- Slow editing experience? Try the command :TSBufDisable highlight
