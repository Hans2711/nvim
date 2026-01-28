-- Text editing enhancement plugins
return {
  -- Comment plugin
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
  
  -- Surround text objects
  {
    "kylechui/nvim-surround",
    version = "*", -- Use latest semver version
    config = function()
      require("nvim-surround").setup({})
    end,
  },
  
  -- Auto close brackets
  {
    "m4xshen/autoclose.nvim",
  },
  
  -- Multiple cursors
  {
    "mg979/vim-visual-multi",
  },
  
  -- Emmet for HTML/CSS
  {
    "olrtg/nvim-emmet",
  },
  
  -- Macro recording and playback
  {
    "kr40/nvim-macros",
  },
  
  -- Refactoring tools
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  
  -- Code action menu
  {
    "weilbith/nvim-code-action-menu",
  },
  
  -- Agrolens (LSP lens)
  {
    "desdic/agrolens.nvim",
  },
}
