
vim.keymap.set("v", "<C-c>", '"+y|y<Esc>')
vim.keymap.set("v", "<C-v>", '"+p')
vim.keymap.set("v", "<C-x>", '"+d|d')

vim.keymap.set("i", "<C-c>", '<Esc>"+ygv`gi')
vim.keymap.set("i", "<C-v>", '<C-o>"+p')
vim.keymap.set("i", "<C-x>", '<Esc>"+dgv`gi')
