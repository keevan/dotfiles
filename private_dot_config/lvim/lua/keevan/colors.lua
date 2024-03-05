-- Change theme settings
-- lvim.colorscheme = "catppuccin-mocha"
-- lvim.colorscheme = "gruvbox-material"
-- vim.cmd("let g:gruvbox_material_background = 'hard'")
-- vim.cmd("let g:gruvbox_material_better_performance = 1")

lvim.colorscheme = "everforest"
vim.cmd("let g:everforest_background = 'soft'")
vim.cmd("let g:everforest_better_performance = 1")
-- lvim.colorscheme = "kanagawa-dragon"

-- require("catppuccin").setup({
--     flavour = "mocha",
--     transparent_background = true, -- disables setting the background color.
--     integrations = {
--         harpoon = true,
--         leap = true, -- Yes, no weird blocks, just highlight the 3rd character
--         which_key = true,
--         cmp = true,
--     },
--     custom_highlights = function(colors)
--         return {
--             NormalFloat = { bg = colors.crust }, -- Diagnostics float window (shift+K)

--         }
--     end
-- })
