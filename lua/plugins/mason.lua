return {
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"clangd",
				"pyright",
				"lua_ls",
			},
			automatic_installation = true,
		},
		config = function()
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})

			vim.lsp.enable("lua_ls", {
				on_attach = function(client, bufnr)
					vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
				end,
			})

			vim.lsp.config("clangd", {
				settings = {
					clangd = {
						InlayHints = {
							Designators = true,
							Enabled = true,
							ParameterNames = true,
							DeducedTypes = true,
						},
						fallbackFlags = { "-std=c++20" }, -- Example: set your C++ standard
					},
				},
				on_attach = function(client, bufnr)
					if client.server_capabilities.inlayHintProvider then
						vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
					end
				end,
			})

			vim.lsp.enable("clangd")
			vim.lsp.enable("pyright")
			vim.lsp.enable("html")
			vim.lsp.enable("cssls")
			vim.lsp.enable("ts_ls")
		end,
		dependencies = {
			{
				"williamboman/mason.nvim",
				opts = {
					ui = {
						icons = {
							package_installed = "✓",
							package_pending = "➜",
							package_uninstalled = "✗",
						},
					},
				},
			},
			"neovim/nvim-lspconfig",
		},
	},
}
