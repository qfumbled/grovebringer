require("nvim-treesitter").setup {
	ensure_installed = { "rust", "lua", "java", "nix" },
	highlight = {
		enable = true,
	},
	incremental_selection = {
		enable = true,
	},
	indentation = {
		enable = true,
	},
}
