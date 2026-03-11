-- nvim-emmet configuration
local emmet = require('nvim-emmet')

-- Keymap for Emmet expansion
vim.keymap.set({ "n", "v" }, '<leader>e', emmet.wrap_with_abbreviation, { desc = "Emmet: Wrap with abbreviation" })

-- Enable Emmet for Blade files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "html", "css", "blade", "javascriptreact", "typescriptreact" },
  callback = function()
    -- Ensure nvim-emmet is available for these filetypes
    vim.b.emmet_enabled = 1
  end,
})

