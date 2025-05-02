vim.cmd.highlight({ "Error", "guibg=red" });
vim.cmd.highlight({ "link", "Warning", "Error" });

vim.opt.number = true;
vim.opt.relativenumber = true;
vim.opt.mouse = 'a';
vim.opt.ignorecase = true;
vim.opt.smartcase = true;
vim.opt.hlsearch = false;
vim.opt.wrap = true;
vim.opt.breakindent = true;
vim.opt.tabstop = 2;
vim.opt.shiftwidth = 2;
vim.opt.expandtab = false;

vim.g.mapleader = ' ';
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>');
vim.keymap.set({'n', 'x'}, 'gp', '"+p');
vim.keymap.set({'n', 'x'}, 'gy', '"+y');

local lazy = {};

function lazy.install(path) 
	if not vim.loop.fs_stat(path) then
			print("Installing lazy.nvim...")
			vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      path,
    });
	end
end

function lazy.setup(plugins)
	if vim.g.plugins_ready then
		return
	end

	lazy.install(lazy.path);

	vim.opt.rtp:prepend(lazy.path);

	require('lazy').setup(plugins, lazy.opts);
	vim.g.plugins_ready = true;
end

lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim';
lazy.opts = {};

lazy.setup({
	{'folke/tokyonight.nvim'},
	{'tpope/vim-surround'},
	{'windwp/nvim-autopairs', event="InsertEnter", config=true},
	{'nvim-treesitter/nvim-treesitter'},
	{'junegunn/fzf.vim', dependencies = { 'junegunn/fzf' }},
	{'ibhagwan/fzf-lua'},
	{'williamboman/mason.nvim'},
	{'williamboman/mason-lspconfig.nvim'},
	{'neovim/nvim-lspconfig'},
	{'tomasiser/vim-code-dark'},
	{'saghen/blink.cmp',
		-- optional: provides snippets for the snippet source
		dependencies = { 'rafamadriz/friendly-snippets' },

		-- use a release tag to download pre-built binaries
		version = '1.*',
		-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
			-- 'super-tab' for mappings similar to vscode (tab to accept)
			-- 'enter' for enter to accept
			-- 'none' for no mappings
			--
			-- All presets have the following mappings:
			-- C-space: Open menu or open docs if already open
			-- C-n/C-p or Up/Down: Select next/previous item
			-- C-e: Hide menu
			-- C-k: Toggle signature help (if signature.enabled = true)
			--
			-- See :h blink-cmp-config-keymap for defining your own keymap
			keymap = { preset = 'default' },

			appearance = {
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = 'mono'
			},

			-- (Default) Only show the documentation popup when manually triggered
			completion = { documentation = { auto_show = false } },

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { 'lsp', 'path', 'snippets', 'buffer' },
			},

			-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
			-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
			-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
			--
			-- See the fuzzy documentation for more information
			fuzzy = { implementation = "prefer_rust_with_warning" }
		},
		opts_extend = { "sources.default" }
	}
});

vim.cmd.colorscheme("codedark");
require("nvim-treesitter.configs").setup { highlight = { enable=true }, ensure_installed = {
		"typescript", "css", "javascript", "svelte", "cpp", "c", "lua", "python"
}};


require("mason").setup {
	providers = {
			"mason.providers.client",
			"mason.providers.registry-api",
	}
};
require("mason-lspconfig").setup{ ensure_installed = { "lua_ls", "clangd" , "pyright"}};
require("lspconfig").lua_ls.setup {};
require("lspconfig").clangd.setup {};
require("lspconfig").pyright.setup {};

vim.keymap.set('n', '<C-b>', '<cmd>Lexplore<cr>');
vim.keymap.set('n', '<C-Bslash>', '<cmd>vertical rightbelow split<cr>');
vim.keymap.set('n', '<leader>q', '<cmd>wq!<cr>');
vim.keymap.set('n', '<C-j>', '<cmd>rightbelow split<cr><cmd>enew<cr><cmd>terminal<cr>');
vim.keymap.set('n', '<C-p>', '<cmd>Files<cr>');

