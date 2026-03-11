-- Miscellaneous utility plugins
return {
  -- Undo tree visualizer
  {
    "mbbill/undotree",
  },
  
  -- Web development tools
  {
    "ray-x/web-tools.nvim",
  },
  
  -- Oil.nvim file explorer
  {
    "stevearc/oil.nvim",
    opts = {
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ["<C-f>"] = {
          callback = function()
            require("oil.fzf").fuzzy_filter()
          end,
          desc = "Fuzzy find files in current directory",
        },
        ["<C-g>"] = {
          callback = function()
            require("oil.fzf").grep_in_directory()
          end,
          desc = "Grep in current directory",
        },
      },
    },
    dependencies = {
      { "nvim-mini/mini.icons", opts = {} }
    },
    lazy = false,
  },
  
  -- Snacks.nvim - Collection of useful utilities
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      picker = { 
        enabled = true,
        win = {
          input = {
            keys = {
              ["<A-j>"] = { "list_down", mode = { "i", "n" } },
              ["<A-k>"] = { "list_up", mode = { "i", "n" } },
            }
          }
        }
      },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      gitbrowse = { enabled = true },
    },
  },
  
  -- Search and replace across project
  {
    "MagicDuck/grug-far.nvim",
  },
  
  -- Vim practice game
  {
    "ThePrimeagen/vim-be-good",
    cmd = "VimBeGood", -- Lazy load on command
  },
  
  -- TypoScript syntax support
  {
    "elmar-hinz/vim.typoscript",
  },
  
  
}
