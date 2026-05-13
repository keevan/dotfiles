return {
  'ruifm/gitlinker.nvim',
  event = 'BufRead',
  config = function()
    require('gitlinker').setup({
      opts = {
        -- remote = 'github', -- force the use of a specific remote
        -- adds current line nr in the url for normal mode
        add_current_line_on_normal_mode = true,
        -- callback for what to do with the url
        action_callback = function(url)
          -- Get current value in clipboard
          local cb = vim.fn.getreg('+')
          -- Check if this is already the same value as the clipboard.
          -- If yes, open in browser
          if cb == url then
            print('Opening ' .. url)
            require('gitlinker.actions').open_in_browser(url)
            return
          end

          -- Otherwise, copy only and print message
          require('gitlinker.actions').copy_to_clipboard(url)
          print('Copied ' .. url)
        end,
        -- print the url after performing the action
        print_url = false,
        -- mapping to call url generation
        -- mappings = "<leader>gy",
      },
      mappings = '<C-S-0>',
      callbacks = {
        ['git.catalyst-au.net'] = require('gitlinker.hosts').get_gitlab_type_url,
      },
    })
  end,
  dependencies = 'nvim-lua/plenary.nvim',
}
