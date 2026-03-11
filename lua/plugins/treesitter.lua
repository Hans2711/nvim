-- Treesitter syntax highlighting and related plugins
local parsers = {
  "bash",
  "blade",
  "c",
  "c_sharp",
  "cpp",
  "css",
  "csv",
  "dockerfile",
  "gitignore",
  "html",
  "javascript",
  "json",
  "lua",
  "passwd",
  "php",
  "po",
  "python",
  "query",
  "regex",
  "scss",
  "tmux",
  "twig",
  "typoscript",
  "vim",
  "vimdoc",
  "xml",
  "yaml",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      require("nvim-treesitter").install(parsers):wait(300000)
    end,
  },
  {
    "windwp/nvim-ts-autotag",
  },
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
}
