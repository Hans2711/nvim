return {
	{
		"praem90/db.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("db").setup({
				connections = {
					{
						name = "Cliqster",
						host = "127.0.0.1",
						port = 3306,
						user = "root",
						password = "password",
						database = "cliqster",
					},
				},
			})
		end,
		keys = {
			{
				"<leader>dbo",
				function()
					require("db").open()
				end,
				desc = "Open DB",
			},
			{
				"<leader>dbc",
				function()
					require("db").open_active_connections()
				end,
				desc = "Open Connections",
			},
			{
				"<leader>dbt",
				function()
					require("db").open_tables()
				end,
				desc = "Open Tables",
			},
			{
				"<leader>dbh",
				function()
					require("db").open_history()
				end,
				desc = "Open History",
			},
		},
	},
}
