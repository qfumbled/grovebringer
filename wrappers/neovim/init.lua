vim.o.mouse = ""
vim.o.number = true
vim.o.signcolumn = "yes"
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.swapfile = false
vim.o.termguicolors = true
vim.o.winborder = "rounded"
vim.o.smartindent = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.g.mapleader = " "

vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set('n', 'U', ':redo<CR>')
vim.keymap.set('n', '<C-g>', ':LazyGit<CR>')
vim.keymap.set('n', '<C-j>', ':bn<CR>')
vim.keymap.set('n', '<C-k>', ':bp<CR>')

vim.lsp.enable({ "lua_ls", "rust_analyzer", "nixd", "jdtls" })
