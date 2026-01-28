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
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Trouble",
    opts = {
      auto_close = false,
      auto_open = false,
      auto_preview = true,
      auto_refresh = true,
      focus = false,
      follow = true,
      indent_guides = true,
      modes = {
        symbols = {
          desc = "document symbols",
          mode = "lsp_document_symbols",
          focus = false,
          win = { position = "right" },
          filter = {
            any = {
              ft = { "help", "markdown" },
              kind = {
                "Class",
                "Constructor",
                "Enum",
                "Field",
                "Function",
                "Interface",
                "Method",
                "Module",
                "Namespace",
                "Package",
                "Property",
                "Struct",
                "Trait",
              },
            },
          },
        },
      },
    },
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xb",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>xs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>xd",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xq",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
}
