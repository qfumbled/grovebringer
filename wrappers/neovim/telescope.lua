require("telescope").setup {
	pickers = {
		find_files = {
			theme = "dropdown",
		},

		buffers = {
			theme = "dropdown",
		},
	}
}

vim.keymap.set('n', '<leader>f', ':Telescope find_files<CR>')
vim.keymap.set('n', '<leader>h', ':Telescope help_tags<CR>')
vim.keymap.set('n', '<leader><leader>', ':Telescope buffers<CR>')
vim.keymap.set('n', '<leader>g', ':Telescope live_grep<CR>')
