vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

vim.opt.foldcolumn = "2"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

vim.keymap.set("n", "+", 'za')
vim.keymap.set("n", "*", 'zA')
