-- detect .tksrc filetype, which looks OK in a toml format
vim.cmd("au BufRead,BufNewFile *.tksrc set filetype=toml")
