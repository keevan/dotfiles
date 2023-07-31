-- create a file at $LUNARVIM_CONFIG_DIR/after/ftplugin/c.lua
vim.cmd("setlocal tabstop=20")
vim.cmd("setlocal shiftwidth=20")
vim.cmd("setlocal noexpandtab")
-- Ensure comments start with #
vim.bo.commentstring = "# %s"
