-- create a file at $LUNARVIM_CONFIG_DIR/after/ftplugin/c.lua
vim.cmd("setlocal tabstop=20")
vim.cmd("setlocal shiftwidth=20")
vim.cmd("setlocal noexpandtab")
-- Ensure comments start with #
vim.bo.commentstring = "# %s"

-- Only enable this for tks files
require("cmp").register_source("tksrc_aliases", require("keevan.cmp_tksrc_aliases").new())
