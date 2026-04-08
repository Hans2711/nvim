vim.g.mapleader = " "

-- Always open Oil with '-'
vim.keymap.set("n", "-", "<cmd>Oil<CR>", { noremap = true, silent = true })

-- Move lines up or down
-- vim.keymap.set("n", "<A-j>", ":m .+1<CR>==") -- move line up(n)
-- vim.keymap.set("n", "<A-k>", ":m .-2<CR>==") -- move line down(n)
-- vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv") -- move line up(v)
-- vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv") -- move line down(v)

-- quit
vim.keymap.set("n", "<C-q>", ":q<CR>")
vim.keymap.set("n", "<C-Q>", vim.cmd.quit)

vim.api.nvim_set_keymap('n', '<leader>r', '<cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>r', '<cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', {noremap = true})

vim.api.nvim_set_keymap('n', '<C-g>', ':nohlsearch<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('i', '<c-a>', 'copilot#accept("<cr>")', { silent = true, expr = true })
vim.api.nvim_set_keymap('i', '<c-l>', 'copilot#next()', {  noremap = true, silent = true, expr = true })
vim.api.nvim_set_keymap('i', '<c-h>', 'copilot#previous()', {  noremap = true, silent = true, expr = true })
vim.api.nvim_set_keymap('i', '<c-j>', 'copilot#dismiss()', {  noremap = true, silent = true, expr = true })

vim.api.nvim_set_keymap('n', '<leader>l', ':cnext<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>h', ':cprevious<cr>', { noremap = true, silent = true })

vim.keymap.set({'n', 'x', 'o'}, 's', '<cmd>HopWord<cr>', { noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, 'S', '<cmd>HopLine<cr>', { noremap = true, silent = true })

vim.keymap.set({'n', 'x', 'o'}, '<leader>gB', ':lua Snacks.gitbrowse()<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>cH', ':FzfLua command_history<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>b', ':FzfLua buffers<cr>', { noremap = true, silent = true })

-- File finding / grep (fzf-lua)
-- Search from project root (git-aware)
vim.keymap.set('n', '<leader>ff', function()
  local fzf = require('fzf-lua')
  local fzf_opts = require('diesi.fzf')
  -- Resolve project root (git-aware, with safe fallback)
  local git_dir = vim.fs.find('.git', { upward = true })[1]
  local root = git_dir and vim.fs.dirname(git_dir) or vim.loop.cwd()
  fzf.files(fzf_opts.with_quickfix({ cwd = root }))
end, { noremap = true, silent = true, desc = 'Find files (project root)' })

vim.keymap.set('n', '<leader>fg', function()
  local fzf = require('fzf-lua')
  local fzf_opts = require('diesi.fzf')
  -- Resolve project root (git-aware, with safe fallback)
  local git_dir = vim.fs.find('.git', { upward = true })[1]
  local root = git_dir and vim.fs.dirname(git_dir) or vim.loop.cwd()
  fzf.live_grep(fzf_opts.with_quickfix({ cwd = root }))
end, { noremap = true, silent = true, desc = 'Grep (project root)' })

-- Search from current working directory (where nvim was opened)
vim.keymap.set('n', '<leader>cff', function()
  local fzf = require('fzf-lua')
  local fzf_opts = require('diesi.fzf')
  fzf.files(fzf_opts.with_quickfix({ cwd = vim.loop.cwd() }))
end, { noremap = true, silent = true, desc = 'Find files (cwd)' })

vim.keymap.set('n', '<leader>cfg', function()
  local fzf = require('fzf-lua')
  local fzf_opts = require('diesi.fzf')
  fzf.live_grep(fzf_opts.with_quickfix({ cwd = vim.loop.cwd() }))
end, { noremap = true, silent = true, desc = 'Grep (cwd)' })

vim.keymap.set('n', '<leader>fr', function()
    require('diesi.recent').open()
end, { noremap = true, silent = true, desc = 'Recent files (directory)' })

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

-- Copy current buffer's absolute path to clipboard
vim.keymap.set('n', '<leader>yp', function()
  local file = vim.fn.expand('%:p')
  if file == '' then
    print('No file associated with this buffer')
  else
    vim.fn.setreg('+', file)
    print('Copied: ' .. file)
  end
end, { noremap = true, silent = true, desc = 'Yank (copy) buffer path' })

-- Trouble.nvim keymaps (diagnostics and navigation)
-- Note: Plugin lazy-loads on these keys, so they're defined in lua/plugins/ui.lua
-- These are documented here for reference:
-- <leader>xx - Toggle diagnostics (workspace)
-- <leader>xb - Toggle buffer diagnostics
-- <leader>xs - Toggle document symbols
-- <leader>xd - Toggle LSP definitions/references/implementations
-- <leader>xL - Toggle location list
-- <leader>xq - Toggle quickfix list
--
-- movement
vim.keymap.set({ 'n', 'v' }, '<A-k>', '<cmd>Treewalker Up<cr>', { silent = true, noremap = true })
vim.keymap.set({ 'n', 'v' }, '<A-j>', '<cmd>Treewalker Down<cr>', { silent = true, noremap = true })
vim.keymap.set({ 'n', 'v' }, '<A-h>', '<cmd>Treewalker Left<cr>', { silent = true, noremap = true })
vim.keymap.set({ 'n', 'v' }, '<A-l>', '<cmd>Treewalker Right<cr>', { silent = true, noremap = true })

-- swapping
vim.keymap.set('n', '<A-S-k>', '<cmd>Treewalker SwapUp<cr>', { silent = true, noremap = true })
vim.keymap.set('n', '<A-S-j>', '<cmd>Treewalker SwapDown<cr>', { silent = true, noremap = true })
vim.keymap.set('n', '<A-S-h>', '<cmd>Treewalker SwapLeft<cr>', { silent = true, noremap = true })
vim.keymap.set('n', '<A-S-l>', '<cmd>Treewalker SwapRight<cr>', { silent = true, noremap = true })
