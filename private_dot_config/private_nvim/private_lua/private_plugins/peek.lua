return {
  -- "toppair/peek.nvim", -- official repo
  'keevan/peek.nvim',
  branch = 'links',
  event = { 'VeryLazy' },
  build = 'deno task --quiet build:fast',
  config = function()
    require('peek').setup({
      app = 'browser',
      theme = 'light',
    })
    vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
    vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
  end,
}
