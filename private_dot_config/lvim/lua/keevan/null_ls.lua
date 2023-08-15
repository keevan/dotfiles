local null_ls = require("null-ls")
local tkss_fmt = {
	method = null_ls.methods.FORMATTING,
	filetypes = { "tks" },
	generator = null_ls.formatter({
		command = "tkss",
		args = { "format" },
		to_stdin = true,
	}),
}

null_ls.setup({
	sources = {
		null_ls.builtins.diagnostics.vale,
		tkss_fmt,
	},
})
