-- Code formatting plugin
return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      formatters_by_ft = {
        blade = { "blade-formatter" },
        lua = { "stylua" },
        python = { "isort", "black" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        php = { "php_cs_fixer" },
      },
      format_on_save = function(bufnr)
        -- Disable auto-format on save for blade files (use manual = or <leader>mp instead)
        if vim.bo[bufnr].filetype == "blade" or vim.bo[bufnr].filetype == "php" then
          return nil
        end
        -- For other filetypes, format on save
        return {
          timeout_ms = 500,
          lsp_fallback = true,
        }
      end,
    },
  },
}
