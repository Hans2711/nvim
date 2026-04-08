-- Code formatting plugin
return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				php = { "pint", "php_cs_fixer", stop_after_first = true },
				blade = { "blade-formatter" },
			},
			formatters = {
				["blade-formatter"] = {
					command = "blade-formatter",
					args = { "--stdin" },
					stdin = true,
				},
			},
			format_on_save = function(bufnr)
                return nil
			end,
		},
	},
}
