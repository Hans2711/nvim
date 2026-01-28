-- LSP and completion plugins
return {
  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
  },
  
  -- Completion engine
  {
    "hrsh7th/nvim-cmp",
  },
  
  -- Completion sources
  {
    "hrsh7th/cmp-nvim-lsp",
  },
  {
    "hrsh7th/cmp-buffer",
  },
  {
    "hrsh7th/cmp-path",
  },
  {
    "hrsh7th/cmp-cmdline",
  },
  
  -- Snippet engine
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*", -- Use version for semver pattern matching
    build = "make install_jsregexp",
  },
  
  -- Highlight function arguments
  {
    "m-demare/hlargs.nvim",
  },
}
