local nvim_tmux_nav = require('nvim-tmux-navigation')

nvim_tmux_nav.setup {}

vim.keymap.set({"n", "v", "i"}, "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
vim.keymap.set({"n", "v", "i"}, "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
vim.keymap.set({"n", "v", "i"}, "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
vim.keymap.set({"n", "v", "i"}, "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
vim.keymap.set({"n", "v", "i"}, "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
