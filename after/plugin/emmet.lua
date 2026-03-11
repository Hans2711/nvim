-- nvim-emmet configuration
local emmet = require('nvim-emmet')

-- Keymap for Emmet expansion
vim.keymap.set({ "n", "v" }, '<leader>e', emmet.wrap_with_abbreviation, { desc = "Emmet: Wrap with abbreviation" })

-- Enable Emmet for markup and frontend filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "html", "css", "javascriptreact", "typescriptreact" },
  callback = function()
    vim.b.emmet_enabled = 1
  end,
})
