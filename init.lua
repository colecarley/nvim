vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

vim.cmd.highlight({ "Error", "guibg=red" })
vim.cmd.highlight({ "link", "Warning", "Error" })

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
		"iurimateus/luasnip-latex-snippets.nvim",
		dependencies = { "L3MON4D3/LuaSnip" },
	},
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
				"jsonc",
				"python",
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
	{
		"okuuva/auto-save.nvim",
		version = "^1.0.0", -- see https://devhints.io/semver, alternatively use '*' to use the latest tagged release
		cmd = "ASToggle", -- optional for lazy loading on command
		event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
		opts = {
			enabled = true, -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
			trigger_events = { -- See :h events
				immediate_save = { "BufLeave", "FocusLost", "QuitPre", "VimSuspend" }, -- vim events that trigger an immediate save
				defer_save = { "InsertLeave", "TextChanged" }, -- vim events that trigger a deferred save (saves after `debounce_delay`)
				cancel_deferred_save = { "InsertEnter" }, -- vim events that cancel a pending deferred save
			},
			-- function that takes the buffer handle and determines whether to save the current buffer or not
			-- return true: if buffer is ok to be saved
			-- return false: if it's not ok to be saved
			-- if set to `nil` then no specific condition is applied
			condition = nil,
			write_all_buffers = false, -- write all buffers when the current one meets `condition`
			noautocmd = false, -- do not execute autocmds when saving
			lockmarks = false, -- lock marks when saving, see `:h lockmarks` for more details
			debounce_delay = 1000, -- delay after which a pending save is executed
			-- log debug messages to 'auto-save.log' file in neovim cache directory, set to `true` to enable
			debug = false,
		},
	},
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
	{ "akinsho/toggleterm.nvim", version = "*", opts = {} },
	{ "tpope/vim-fugitive" },
	{ "rafamadriz/friendly-snippets" },
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
			"saadparwaiz1/cmp_luasnip",
		},
		-- follow latest release.
		opts = {
			version = "v2.*",
			build = "make install_jsregexp",
		},
	},
	{
		"nvimdev/lspsaga.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- optional
			"nvim-tree/nvim-web-devicons", -- optional
		},
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			bigfile = { enabled = true },
			image = { enabled = true },
			dashboard = {
				enabled = true,
				sections = {
					{ section = "header" },
					{ section = "keys", gap = 1, padding = 1 },
					{
						pane = 2,
						section = "terminal",
						cmd = "square",
						height = 5,
						padding = 1,
					},
					{
						pane = 2,
						icon = " ",
						title = "Recent Files",
						section = "recent_files",
						indent = 2,
						padding = 1,
					},
					{ pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
					{
						pane = 2,
						icon = " ",
						title = "Git Status",
						section = "terminal",
						enabled = function()
							return Snacks.git.get_root() ~= nil
						end,
						cmd = "git status --short --branch --renames",
						height = 5,
						padding = 1,
						ttl = 5 * 60,
						indent = 3,
					},
					{ section = "startup" },
				},
			},
			indent = { enabled = true },
			input = { enabled = true },
			picker = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scope = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
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
		json = { "clang-format", "prettier" },
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

require("peek").setup({ app = "browser" })
require("luasnip").config.setup({
	enable_autosnippets = true,
})
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

local group = vim.api.nvim_create_augroup("autosave", {})

vim.api.nvim_create_autocmd("User", {
	pattern = "AutoSaveWritePost",
	group = group,
	callback = function(opts)
		if opts.data.saved_buffer ~= nil then
			local filename = vim.api.nvim_buf_get_name(opts.data.saved_buffer)
			vim.notify("AutoSave: saved " .. filename .. " at " .. vim.fn.strftime("%H:%M:%S"), vim.log.levels.INFO)
		end
	end,
})

require("lspsaga").setup({
	lightbulb = {
		enable = false,
	},
	symbol_in_winbar = {
		enable = true,
		separator = " › ",
		hide_keyword = false,
		show_file = true,
		folder_level = 1,
		color_mode = true,
		delay = 300,
	},
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

require("noice").setup({
	lsp = {
		-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
		},
	},
	-- you can enable a preset for easier configuration
	presets = {
		bottom_search = true, -- use a classic bottom cmdline for search
		command_palette = true, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = false, -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = false, -- add a border to hover docs and signature help
	},
})

vim.keymap.set("n", "<leader>ki", "<cmd>Lspsaga hover_doc<cr>")
vim.keymap.set("n", "<leader>r", "<cmd>Lspsaga rename<cr>")
vim.keymap.set("n", "<leader>]", "<cmd>vertical rightbelow split<cr><cmd>Lspsaga goto_definition<cr>")

vim.api.nvim_create_autocmd("RecordingEnter", {
	callback = function()
		local reg = vim.fn.reg_recording()
		vim.notify("Recording to " .. reg)
	end,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
	callback = function()
		local reg = vim.fn.reg_recording()
		vim.notify("End recording to " .. reg)
	end,
})

require("luasnip-latex-snippets").setup({ use_treesitter = true, allow_on_markdown = true })
