vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

vim.cmd.highlight({ "Error", "guibg=red" })
vim.cmd.highlight({ "link", "Warning", "Error" })

vim.opt.spell = true
vim.opt.spelllang = "en_us"

vim.opt.hidden = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>w", "<cmd>write<cr>")
vim.keymap.set({ "n", "x" }, "gp", '"+p')
vim.keymap.set({ "n", "x" }, "gy", '"+y')

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
	{ "nvim-tree/nvim-web-devicons", opts = {} },
	{ "folke/tokyonight.nvim" },
	{ "tpope/vim-surround" },
	{ "windwp/nvim-autopairs", opts = { event = "InsertEnter", config = true } },
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			highlight = { enable = true },
			ensure_installed = {
				"typescript",
				"css",
				"javascript",
				"svelte",
				"cpp",
				"c",
				"latex",
				"markdown",
				"markdown_inline",
			},
		},
	},
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim", dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" } },
	{
		"neovim/nvim-lspconfig",
		dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
	},
	{ "tomasiser/vim-code-dark" },
	{ "neovim/nvim-lspconfig" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{ "hrsh7th/nvim-cmp" },
	{ "stevearc/conform.nvim" },
	{ "nvim-tree/nvim-tree.lua" },
	{ "okuuva/auto-save.nvim" },
	{
		"toppair/peek.nvim",
		event = { "VeryLazy" },
		build = "deno task --quiet build:fast",
		config = function()
			require("peek").setup()
			vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
			vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{ "nvim-telescope/telescope.nvim", tag = "0.1.8", dependencies = { "nvim-lua/plenary.nvim" } },
	{
		"numToStr/Comment.nvim",
		opts = {
			padding = true,
			sticky = true,
			toggler = { line = "gcc", block = "gbc" },
			opleader = { line = "gc", block = "gb" },
			mappings = { basic = true },
		},
	},
	{
		"lervag/vimtex",
		lazy = false,
		init = function()
			vim.g.vimtex_view_method = "zathura"
		end,
	},
	{ "akinsho/toggleterm.nvim", version = "*", opts = {} },
	{ "tpope/vim-fugitive" },
	{ "rafamadriz/friendly-snippets" },
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		-- follow latest release.
		opts = {
			version = "v2.*",
			build = "make install_jsregexp",
		},
	},
})

require("toggleterm").setup({})
require("lualine").setup({
	options = {
		theme = "codedark",
		section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
	},
})
require("nvim-tree").setup({})
require("mason").setup({})
require("mason-lspconfig").setup({ ensure_installed = { "lua_ls", "clangd", "pyright" } })
require("lspconfig").lua_ls.setup({
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})
require("lspconfig").clangd.setup({})
require("lspconfig").pyright.setup({})
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "black" },
		rust = { "ast-grep" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
		cpp = { "clang-format" },
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		async = false,
		lsp_format = "fallback",
	},
})

local cmp = require("cmp")
cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
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
		{ name = "nvim_lsp" },
		{ name = "luasnip" }, -- For luasnip users.
	}, {
		{ name = "buffer" },
	}),
})

require("peek").setup({ app = "browser" })
require("luasnip").config.setup({ enable_autosnippets = true })
require("luasnip.loaders.from_vscode").lazy_load()

vim.keymap.set("n", "<Leader>a", "<cmd>NvimTreeToggle<cr>")
vim.keymap.set("n", "<Leader>\\", "<cmd>vertical rightbelow split<cr>")
vim.keymap.set("t", "<Leader>\\", "<cmd>TermNew<cr>")
vim.keymap.set("n", "<leader>q", "<cmd>wq!<cr>")
vim.keymap.set({ "n", "t" }, "<Leader>t", "<cmd>ToggleTerm<cr>")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>p", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>F", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

vim.cmd.colorscheme("codedark")

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set("i", "<C-h>", "<C-Bslash><C-N><C-w>h")
vim.keymap.set("i", "<C-j>", "<C-Bslash><C-N><C-w>j")
vim.keymap.set("i", "<C-k>", "<C-Bslash><C-N><C-w>k")
vim.keymap.set("i", "<C-l>", "<C-Bslash><C-N><C-w>l")

vim.keymap.set("t", "<C-h>", "<C-Bslash><C-N><C-w>h")
vim.keymap.set("t", "<C-j>", "<C-Bslash><C-N><C-w>j")
vim.keymap.set("t", "<C-k>", "<C-Bslash><C-N><C-w>k")
vim.keymap.set("t", "<C-l>", "<C-Bslash><C-N><C-w>l")

local t = require("toggleterm.terminal")
local Terminal = t.Terminal
function _G.open_next_terminal()
	Terminal:new({ close_on_exit = true, direction = "horizontal" }):toggle()
end

vim.api.nvim_set_keymap("t", "<leader>\\", "<cmd>lua open_next_terminal()<CR>", { noremap = true, silent = true })
