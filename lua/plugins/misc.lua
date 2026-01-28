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
  
  -- Yazi file manager integration
  {
    "mikavilpas/yazi.nvim",
    dependencies = {
      {
        "folke/snacks.nvim",
        config = function()
          local ok, snacks = pcall(require, "snacks")
          if ok then
            snacks.setup({
              config = {
                priority = 1000,
                lazy = false,
                opts = {
                  bigfile = { enabled = true },
                  dashboard = { enabled = true },
                  explorer = { enabled = true },
                  indent = { enabled = true },
                  input = { enabled = true },
                  notifier = {
                    enabled = true,
                    timeout = 3000,
                  },
                  picker = { enabled = true },
                  quickfile = { enabled = true },
                  scope = { enabled = true },
                  scroll = { enabled = true },
                  statuscolumn = { enabled = true },
                  words = { enabled = true },
                },
              },
            })
          end
        end,
      },
    },
    config = function()
      require("yazi").setup()
    end,
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
  
  -- Laravel helper utilities
  {
    "greggh/laravel-helper.nvim",
    dependencies = {
      "ColinKennedy/mega.cmdparse",
      "ColinKennedy/mega.logging",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("laravel-helper").setup()
    end,
  },
}
