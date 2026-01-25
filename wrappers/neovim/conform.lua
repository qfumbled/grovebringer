require("conform").setup {
	formatters_by_ft = {
		rust = { 'rustfmt' },
		kdl = { 'kdlfmt' },
	},

	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
}
