-- Navigation and motion plugins
return {
  -- Harpoon for quick file navigation
  {
    "theprimeagen/harpoon",
  },
  
  -- Hop for quick jumps
  {
    "smoka7/hop.nvim",
    version = "*", -- Use latest semver version
    config = function()
      require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
    end,
  },
  
  -- Leap for quick motion (repository moved to Codeberg)
  {
    url = "https://codeberg.org/andyg/leap.nvim",
  },
  
  -- Tmux navigation integration
  {
    "alexghergh/nvim-tmux-navigation",
  },
}
