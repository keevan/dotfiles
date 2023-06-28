-- Strip Whitespace
vim.cmd("autocmd BufWritePre * %s/\\s+$//e")

vim.cmd("au BufRead,BufNewFile *.tks set filetype=tks")
