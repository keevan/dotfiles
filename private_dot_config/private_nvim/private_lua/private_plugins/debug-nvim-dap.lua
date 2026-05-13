return {
  'mfussenegger/nvim-dap',
  enabled = true,
  event = 'VeryLazy',
  keys = {
    {
      '<leader>db',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Toggle Breakpoint',
    },

    {
      '<leader>dc',
      function()
        require('dap').continue()
      end,
      desc = 'Continue',
    },

    {
      '<leader>dC',
      function()
        require('dap').run_to_cursor()
      end,
      desc = 'Run to Cursor',
    },

    {
      '<leader>dT',
      function()
        require('dap').terminate()
      end,
      desc = 'Terminate',
    },
  },
  -- config = function()
  --   -- lvim.builtin.dap.ui.config.element_mappings.watches = {
  --   --   remove = 'd',
  --   --   edit = 'c',
  --   --   repl = 'y',
  --   -- }
  --   -- lvim.builtin.dap.ui.config.element_mappings.watches = {
  --   --   edit = 'c',
  --   --   expand = '<CR>',
  --   --   repl = 'y',
  --   -- }
  --   -- require('lvim.core.dap').setup()
  -- end,
  lazy = true,
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'jay-babu/mason-nvim-dap.nvim',
    'theHamsta/nvim-dap-virtual-text',
  },
}
