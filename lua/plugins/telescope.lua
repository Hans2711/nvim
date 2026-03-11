-- Fuzzy finder plugins
-- NOTE: Telescope is kept ONLY for the custom DAP debugging extension (lua/telescope/_extensions/dap.lua)
-- For all file/buffer/grep operations, use fzf-lua instead (configured below).
return {
  -- Primary fuzzy finder - fzf-lua
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false, -- Load immediately for all fuzzy finding operations
    config = function(_, opts)
      require("fzf-lua").setup(opts)
    end,
    opts = function(_, opts)
      opts = opts or {}
      opts.keymap = opts.keymap or {}
      opts.keymap.fzf = vim.tbl_extend("force", { true }, opts.keymap.fzf or {}, {
        ["ctrl-q"] = "select-all+accept",
      })

      return opts
    end,
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
