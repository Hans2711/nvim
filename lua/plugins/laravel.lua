return {
  {
    "RicardoRamirezR/blade-nav.nvim",
    commit = "742b083aa997ec7876a0891a356689d3d6a2d76b",
    ft = { "blade", "php" },
    cmd = { "BladeNavInstallArtisanCommand" },
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
    init = function()
      vim.g.loaded_blade_nav = true
      vim.g.blade_nav = vim.g.blade_nav or {}
    end,
    opts = {
      close_tag_on_complete = false,
    },
    config = function(_, opts)
      require("blade-nav").setup(opts)
      require("diesi.blade-completion").configure_cmp_sources()
      require("diesi.blade-nav").setup()
    end,
  },
  {
  "adalessa/laravel.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-neotest/nvim-nio",
  },
  ft = { "php", "blade" },
  event = {
    "BufEnter composer.json",
  },
  keys = {
    { "<leader>ll", function() Laravel.pickers.laravel() end,              desc = "Laravel: Open Laravel Picker" },
    { "<c-g>",      function() Laravel.commands.run("view:finder") end,    desc = "Laravel: Open View Finder" },
    { "<leader>la", function() Laravel.pickers.artisan() end,              desc = "Laravel: Open Artisan Picker" },
    { "<leader>lt", function() Laravel.commands.run("actions") end,        desc = "Laravel: Open Actions Picker" },
    { "<leader>lr", function() Laravel.pickers.routes() end,               desc = "Laravel: Open Routes Picker" },
    { "<leader>lh", function() Laravel.run("artisan docs") end,            desc = "Laravel: Open Documentation" },
    { "<leader>lm", function() Laravel.pickers.make() end,                 desc = "Laravel: Open Make Picker" },
    { "<leader>lc", function() Laravel.pickers.commands() end,             desc = "Laravel: Open Commands Picker" },
    { "<leader>lo", function() Laravel.pickers.resources() end,            desc = "Laravel: Open Resources Picker" },
    { "<leader>lp", function() Laravel.commands.run("command_center") end, desc = "Laravel: Open Command Center" },
    { "<leader>lu", function() Laravel.commands.run("hub") end,            desc = "Laravel Artisan hub" },
    {
      "gf",
      function()
        local ok, res = pcall(function()
          if Laravel.app("gf").cursorOnResource() then
            return "<cmd>lua Laravel.commands.run('gf')<cr>"
          end
        end)
        if not ok or not res then
          return "gf"
        end
        return res
      end,
      expr = true,
      noremap = true,
    },
  },
  opts = {
    features = {
      pickers = {
        provider = "snacks", -- "snacks | telescope | fzf-lua | ui-select"
      },
    },
    extensions = {
      diagnostic = { enable = false },
      model_info = { enable = false },
      override = { enable = false },
      route_info = { enable = false },
    },
  },
}
}
