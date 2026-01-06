require("core.options")
require("core.keymaps")

local lazy = {}
function lazy.install(path)
	if not vim.loop.fs_stat(path) then
		print("Installing lazy.nvim...")
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable", -- latest stable release
			path,
		})
	end
end

function lazy.setup(plugins)
	if vim.g.plugins_ready then
		return
	end

	lazy.install(lazy.path)

	vim.opt.rtp:prepend(lazy.path)

	require("lazy").setup(plugins, lazy.opts)
	vim.g.plugins_ready = true
end

lazy.path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
lazy.opts = {}

lazy.setup({
    spec = {
        import = "plugins"
    }
})

require('lualine').setup()
require('bufferline').setup()

local gitsigns = require("gitsigns")
gitsigns.setup({
	current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
})
require("nvim-tree").setup({})
require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

require("mason-lspconfig")
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
	end
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
	end
})
vim.lsp.enable("clangd")
vim.lsp.enable("pyright")

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "black" },
		rust = { "ast-grep" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
		cpp = { "clang-format" },
		c = { "clang-format" },
		json = { "clang-format", "prettier" },
	}
})

local cmp = require("cmp")
cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<tab>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = "luasnip" },
		{ name = "nvim_lsp" },
	}, {
		{ name = "buffer" },
	}),
})

require("lspsaga").setup({
	definition = {
		keys = {
			edit = 'o',
			vsplit = 's'
		}
	},
	lightbulb = { enable = false },
	symbol_in_winbar = { enable = false },
	border = "single",
	devicon = true,
	title = true,
	expand = "⊞",
	collapse = "⊟",
	code_action = "💡",
	actionfix = " ",
	lines = { "┗", "┣", "┃", "━", "┏" },
	kind = {},
	imp_sign = "󰳛 ",
})

-- vim.cmd.colorscheme("codedark")
vim.cmd.colorscheme("gruvbox-material")
