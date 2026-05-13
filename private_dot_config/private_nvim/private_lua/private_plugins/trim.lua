-- Trim for whitespaces
return {
  'cappyzawa/trim.nvim',
  event = 'InsertLeave',
  config = function()
    require('trim').setup({})
  end,
}
