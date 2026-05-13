-- Mainly used for yanking and keeping the cursor in place.
-- Huge QoL.
-- Need a way to flash on UNDO though.
return {
  'gbprod/yanky.nvim',
  event = 'BufReadPre',
  config = function()
    require('yanky').setup({
      highlight = {
        on_yank = true,
        timer = 100,
      },
    })
  end,
}
