-- Change theme settings
lvim.colorscheme = "catppuccin-mocha"

require("catppuccin").setup({
    flavour = "mocha",
    transparent_background = true, -- disables setting the background color.
    integrations = {
        harpoon = true,
        leap = true, -- Yes, no weird blocks, just highlight the 3rd character
        which_key = true,
    }
})
