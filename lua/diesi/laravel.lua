-- Define keybindings for Laravel Telescope functionalities
vim.keymap.set('n', '<leader>lm', ':LaravelTelescope models<CR>', { desc = 'Laravel: Related Models' })
vim.keymap.set('n', '<leader>lr', ':LaravelTelescope routes<CR>', { desc = 'Laravel: Routes' })
vim.keymap.set('n', '<leader>la', ':LaravelTelescope artisan<CR>', { desc = 'Laravel: Artisan Commands' })
