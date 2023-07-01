-- Based on bubble theme circles
lvim.builtin.lualine.style = "default"
local config = {
    options = {
        -- theme = "catppucin",
        component_separators = '|',
        section_separators = { left = '', right = '' },
    },
    sections = {
        lualine_a = {
            { 'mode', fmt = function(str) return str end, separator = { left = '' }, right_padding = 2 },
        },
        lualine_b = { 'filename', 'branch' },
        -- lualine_c = { 'fileformat' },
        -- lualine_x = {},
        -- lualine_y = { 'filetype', 'progress' },
        -- lualine_z = {
        --     { 'location', separator = { right = '' }, left_padding = 2 },
        -- },
    },
    -- inactive_sections = {
    --     lualine_a = { 'filename' },
    --     lualine_b = {},
    --     lualine_c = {},
    --     lualine_x = {},
    --     lualine_y = {},
    --     lualine_z = { 'location' },
    -- },
    -- tabline = {},
    -- extensions = {},
}
lvim.builtin.lualine.options = config.options
lvim.builtin.lualine.sections = config.sections
lvim.builtin.lualine.inactive_sections = config.inactive_sections
