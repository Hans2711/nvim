local fl = require('fzf-lua')

fl.setup {
    winopts = {
        height = 1,
        width  = 1,
        row    = 0.5,
        col    = 0.5,
    },
    files = {
        cmd       = "rg --files --hidden --glob '!.git/*' --no-ignore --no-ignore-vcs",
        prompt = 'Files❯ ',
        git_icons = true,
    },
    grep = {
        prompt  = 'Grep❯ ',
        rg_opts = "--hidden --no-heading --line-number --column --smart-case --no-ignore --no-ignore-vcs",
    },
    dirs = {
        prompt = 'Dirs❯ ',
    },

    keymap = {
        fzf = {
            ["ctrl-q"] = "select-all+accept",
        },
    },
}

vim.api.nvim_set_keymap('n', '<leader>ff', ':FzfLua files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fr', ':FzfLua oldfiles<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap(
  'n',
  '<leader>fs',
  ':FzfLua resume<CR>',
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap('n', '<leader>qf', ':FzfLua quickfix<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ts', ':FzfLua treesitter<CR>', { noremap = true, silent = true })


vim.api.nvim_set_keymap('n', '<leader>fg', ':FzfLua live_grep<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>b', ':FzfLua buffers<CR>', { noremap = true, silent = true })


