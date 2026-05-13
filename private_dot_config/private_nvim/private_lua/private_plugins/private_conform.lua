return { -- Autoformat
  'stevearc/conform.nvim',
  enabled = true,
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>lf',
      function()
        require('conform').format({ async = true, lsp_format = 'fallback' })
        vim.defer_fn(function()
          vim.cmd([[%s/{\s\+\(.\{-}\)\s\+}/{\1}/ge]])
        end, 100)
      end,
      mode = '',
      desc = '[L]SP [F]ormat file',
    },
  },
  opts = {
    notify_on_error = true,
    format_on_save = function(bufnr)
      -- disable format on save.
      if 1 then
        return
      end

      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true, typescript = true, javascript = true, tpl = true, smarty = true, php = true }
      local lsp_format_opt
      if disable_filetypes[vim.bo[bufnr].filetype] then
        lsp_format_opt = 'never'
      else
        lsp_format_opt = 'fallback'
      end
      return {
        timeout_ms = 500,
        lsp_format = lsp_format_opt,
      }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use 'stop_after_first' to run the first available formatter from the list
      -- javascript = { "prettierd", "prettier", stop_after_first = true },
      sql = function()
        return { 'sleek' }
      end,
      -- sql = { "sqlformat" },
      -- sql = { "sqruff" },
      -- sql = { "sqlfmt fix --dialect postgres" },
    },
  },
}
