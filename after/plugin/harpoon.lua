local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
local term = require("harpoon.term")
local cmdUi = require("harpoon.cmd-ui")

require("harpoon").setup({
    menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
        height = vim.api.nvim_win_get_height(0) - 4,
    }
})

vim.keymap.set("n", "<C-a>", mark.add_file)
vim.keymap.set("n", "<C-b>", ui.toggle_quick_menu)

vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end)
vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end)
vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end)
vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end)
vim.keymap.set("n", "<leader>5", function() ui.nav_file(5) end)
vim.keymap.set("n", "<leader>6", function() ui.nav_file(6) end)
vim.keymap.set("n", "<leader>7", function() ui.nav_file(7) end)
vim.keymap.set("n", "<leader>8", function() ui.nav_file(8) end)
vim.keymap.set("n", "<leader>9", function() ui.nav_file(9) end)

vim.keymap.set("n", "<leader>t1", function() term.gotoTerminal(1) end)
vim.keymap.set("n", "<leader>t2", function() term.gotoTerminal(2) end)
vim.keymap.set("n", "<leader>t3", function() term.gotoTerminal(3) end)
vim.keymap.set("n", "<leader>t4", function() term.gotoTerminal(4) end)
vim.keymap.set("n", "<leader>t5", function() term.gotoTerminal(5) end)
vim.keymap.set("n", "<leader>t6", function() term.gotoTerminal(6) end)
vim.keymap.set("n", "<leader>t7", function() term.gotoTerminal(7) end)
vim.keymap.set("n", "<leader>t8", function() term.gotoTerminal(8) end)
vim.keymap.set("n", "<leader>t9", function() term.gotoTerminal(9) end)

vim.keymap.set("n", "<leader>tt", function() 
    require('harpoon.cmd-ui').toggle_quick_menu()
end)

vim.keymap.set("n", "<leader>cund", function() 
    term.gotoTerminal(1) 
    term.sendCommand(1, "ddev composer update --no-dev\n") 
end)

vim.keymap.set("n", "<leader>cda", function() 
    term.gotoTerminal(1) 
    term.sendCommand(1, "ddev composer dump-autoload\n") 
end)

vim.keymap.set("n", "<leader>cind", function() 
    term.gotoTerminal(1) 
    term.sendCommand(1, "ddev composer install --no-dev\n") 
end)
