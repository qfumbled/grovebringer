require("mini.bufremove").setup {
	silent = true,
}

vim.keymap.set('n', '<leader>p', ':lua MiniBufremove.unshow()<CR>')
vim.keymap.set('n', '<leader>d', ':lua MiniBufremove.delete()<CR>')
