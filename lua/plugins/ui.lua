-- UI enhancement plugins
return {
  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  
  -- File tree
  {
    "nvim-tree/nvim-tree.lua",
  },
  
  -- Icons
  {
    "nvim-tree/nvim-web-devicons",
  },
  
  -- Better vim.ui interfaces
  {
    "stevearc/dressing.nvim",
  },
  
  -- Markdown rendering
  {
    "MeanderingProgrammer/render-markdown.nvim",
  },
  
  -- Diagnostics list
  {
    "folke/trouble.nvim",
  },
}
