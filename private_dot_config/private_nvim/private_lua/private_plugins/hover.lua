return {
  'lewis6991/hover.nvim',
  event = 'VimEnter',
  config = function()
    require('hover').config({
      --- List of modules names to load as providers.
      --- @type (string|Hover.Config.Provider)[]
      providers = {
        -- 'hover.providers.diagnostic',
        'hover.providers.lsp',
        -- 'hover.providers.dap',
        -- 'hover.providers.man',
        'hover.providers.dictionary',
        -- Optional, disabled by default:
        'hover.providers.gh',
        -- 'hover.providers.gh_user',
        -- 'hover.providers.jira',
        -- 'hover.providers.fold_preview',
        -- 'hover.providers.highlight',
        'local.hover.providers.wr',
      },
      -- init = function()
      --   -- Require providers
      --   require('hover.providers.lsp')
      --   require('hover.providers.gh')
      --   -- require('hover.providers.gh_user')
      --   -- require('hover.providers.jira')
      --   -- require('hover.providers.man')
      --   require('hover.providers.dictionary')
      --   require('local.hover.providers.wr')
      --   -- require('local.prompts')
      -- end,
      preview_opts = {
        border = nil,
      },
      -- Whether the contents of a currently open hover window should be moved
      -- to a :h preview-window when pressing the hover keymap.
      preview_window = false,
      title = true,
      mouse_providers = {
        'hover.providers.lsp',
      },
      mouse_delay = 1000,
    })

    -- Setup keymaps
    vim.keymap.set('n', 'K', require('hover').open, { desc = 'hover.nvim' })
    vim.keymap.set('n', 'gK', require('hover').select, { desc = 'hover.nvim (select)' })
  end,
}
