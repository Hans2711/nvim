vim.g.mapleader = " "

-- Move lines up or down
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==") -- move line up(n)
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==") -- move line down(n)
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv") -- move line up(v)
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv") -- move line down(v)

-- quit
vim.keymap.set("n", "<C-q>", ":q<CR>")
vim.keymap.set("n", "<C-Q>", vim.cmd.quit)

vim.api.nvim_set_keymap('n', '<leader>r', '<cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>r', '<cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', {noremap = true})

vim.api.nvim_set_keymap('n', '<C-g>', ':nohlsearch<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>a', ':q<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('i', '<c-a>', 'copilot#accept("<cr>")', { silent = true, expr = true })
vim.api.nvim_set_keymap('i', '<c-l>', 'copilot#next()', {  noremap = true, silent = true, expr = true })
vim.api.nvim_set_keymap('i', '<c-h>', 'copilot#previous()', {  noremap = true, silent = true, expr = true })
vim.api.nvim_set_keymap('i', '<c-j>', 'copilot#dismiss()', {  noremap = true, silent = true, expr = true })

vim.api.nvim_set_keymap('n', '<leader>l', ':cnext<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>h', ':cprevious<cr>', { noremap = true, silent = true })

vim.keymap.set({'n', 'x', 'o'}, 's', '<cmd>HopWord<cr>', { noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, 'S', '<cmd>HopLine<cr>', { noremap = true, silent = true })

vim.keymap.set({'n', 'x', 'o'}, '<leader>gB', ':lua Snacks.gitbrowse()<cr>', { noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, '<leader>cH', ':lua Snacks.picker.command_history()<cr>', { noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, '<leader>b', function()
    require('packer').loader('snacks.nvim')
    require('snacks').picker.buffers()
end, { noremap = true, silent = true })

local opts = { noremap = true, silent = true }

-- horizontal (width) changes
vim.keymap.set('n', '<M-h>', ':vertical resize -3<CR>', opts) -- shrink to the left
vim.keymap.set('n', '<M-l>', ':vertical resize +3<CR>', opts) -- grow  to the right

vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-a>", "<Plug>(copilot-accept-word)", { noremap = false, silent = true })

vim.keymap.set('n', '<leader>vc', function()
  local file = vim.fn.expand('%:p')
  if file == '' then
    print('No file associated with this buffer')
  else
    vim.fn.jobstart({ 'code', file }, { detach = true })
  end
end, { noremap = true, silent = true })
