-- Set leader keys BEFORE loading lazy.nvim
-- This must be done first so plugins can use the correct leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Load lazy.nvim plugin manager
require("config.lazy")

-- Load your configuration modules
require("diesi")

