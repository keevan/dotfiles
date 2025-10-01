-- Copilot chat
return {
  'CopilotC-Nvim/CopilotChat.nvim',
  branch = 'main',
  dependencies = {
    { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
    { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
  },
  opts = {
    debug = true, -- Enable debugging
    -- See Configuration section for rest
    prompts = require('local.prompts'), -- Load prompts from the external file,
  },
  -- See Commands section for default commands if you want to lazy load on them
}
