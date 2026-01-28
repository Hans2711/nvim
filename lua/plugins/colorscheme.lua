-- Colorscheme configuration
return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000, -- Load before other plugins
    lazy = false,    -- Load at startup
    config = function()
      vim.cmd("colorscheme rose-pine")
    end,
  },
}
