return {
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"clangd",
				"pyright",
				"lua_ls",
                "rust-analyzer",
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
                cmd = {
                    "clangd",
                    "--background-index=false",
                },
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

            vim.lsp.config("rust_analyzer", {
                settings = {
                     ["rust_analyzer"] = {
                        imports = {
                            granularity = {
                                group = "module",
                            },
                            prefix = "self",
                        },
                        cargo = {
                            buildScripts = {
                                enable = true,
                            },
                        },
                        procMacro = {
                            enable = true
                        },
                    }
                },
                on_attach = function(client, bufnr)
                    print("on attach");
                    if (client.server_capabilities.inlayHintProvider) then
                        print("inlayHintProvider");
						vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                    end
                end
            })

			vim.lsp.enable("clangd")
			vim.lsp.enable("pyright")
			vim.lsp.enable("html")
			vim.lsp.enable("cssls")
			vim.lsp.enable("ts_ls")
			vim.lsp.enable("rust_analyzer")
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
