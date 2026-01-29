return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "black" },
				rust = { "ast-grep" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				cpp = { "clang-format" },
				c = { "clang-format" },
				json = { "clang-format", "prettier" },
			},
		},
	},
}
