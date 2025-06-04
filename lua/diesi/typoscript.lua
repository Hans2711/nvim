vim.filetype.add({
  extension = {
    typoscript = "typoscript",
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "typoscript",
  callback = function()
    vim.bo.commentstring = "# %s"
  end,
})
