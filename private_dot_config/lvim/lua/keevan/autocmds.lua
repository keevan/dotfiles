-- Strip Whitespace
-- vim.cmd("autocmd BufWritePre * %s/\\s+$//e")

-- BufWritePost (purge string/lang cache after writing to a lang file)
_ = vim.cmd([[
  augroup MDLLangFiles
    au!
    autocmd BufWritePost **/lang/en/*.php lua vim.cmd('silent !ctrl lang &')
  augroup END
]])
