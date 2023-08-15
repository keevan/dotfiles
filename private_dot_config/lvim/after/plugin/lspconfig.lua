lvim.lsp.on_attach_callback = function(client, bufnr)
	if client.server_capabilities.inlayHintProvider then
		vim.lsp.buf.inlay_hint(bufnr, true)
	end
end

-- Docs: https://github.com/neovim/nvim-lspconfig
local lspconfig = require("lspconfig")
lspconfig.phpactor.setup({ autostart = false })
lspconfig.sqlls.setup({})
