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
	{'nvim-treesitter/nvim-treesitter', highlight = {enable=true }, ensure_installed = {
		"typescript", "css", "javascript", "svelte", "cpp", "c"
	}},
	{ 'junegunn/fzf.vim', dependencies = { 'junegunn/fzf' } },
	{'williamboman/mason.nvim'},
	{'williamboman/mason-lspconfig.nvim'},
	{'neovim/nvim-lspconfig'},
	{'tomasiser/vim-code-dark'},
});

require("mason").setup();
require("mason-lspconfig").setup{ ensure_installed = { "lua_ls", "clangd" , "pyright"}};
require("lspconfig").lua_ls.setup {};
require("lspconfig").clangd.setup {};
require("lspconfig").pyright.setup {};

vim.keymap.set('n', '<C-b>', '<cmd>Lexplore<cr>');
vim.keymap.set('n', '<C-Bslash>', '<cmd>vertical rightbelow split<cr>');
vim.keymap.set('n', '<leader>q', '<cmd>wq!<cr>');
vim.keymap.set('n', '<C-j>', '<cmd>terminal<cr>');
vim.keymap.set('n', '<C-p>', '<cmd>Files<cr>');


vim.cmd.colorscheme("codedark");


