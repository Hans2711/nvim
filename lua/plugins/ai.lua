-- AI-powered coding assistance
return {
  -- GitHub Copilot
  {
    "github/copilot.vim",
  },
  
  -- Avante AI assistant
  {
    "yetone/avante.nvim",
    branch = "main",
    build = "make",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "ibhagwan/fzf-lua",
      "MeanderingProgrammer/render-markdown.nvim",
    },
  },
}
