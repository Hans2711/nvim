-- Fuzzy finder plugins
-- NOTE: Telescope is kept ONLY for the custom DAP debugging extension (lua/telescope/_extensions/dap.lua)
-- For all file/buffer/grep operations, use fzf-lua instead (configured in after/plugin/fzf.lua)
return {
  -- Primary fuzzy finder - fzf-lua
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false, -- Load immediately for all fuzzy finding operations
  },
  
  -- Telescope - kept only for DAP extension
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    lazy = true, -- Only load when DAP extension needs it
  },
}
