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
	{ "ibhagwan/fzf-lua", dependencies = { "nvim-tree/nvim-web-devicons" }, },
	{'williamboman/mason.nvim'},
	{'williamboman/mason-lspconfig.nvim', dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig"}},
	{'neovim/nvim-lspconfig', dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim"}},
	{'tomasiser/vim-code-dark'},
 	{'neovim/nvim-lspconfig'},
 	{'hrsh7th/cmp-nvim-lsp'},
 	{'hrsh7th/cmp-buffer'},
 	{'hrsh7th/cmp-path'},
 	{'hrsh7th/cmp-cmdline'},
 	{'hrsh7th/nvim-cmp'},
});

require("mason").setup({});

require("mason-lspconfig").setup{ ensure_installed = { "lua_ls", "clangd" , "pyright"}};
require("lspconfig").lua_ls.setup({});
require("lspconfig").clangd.setup({});
require("lspconfig").pyright.setup({});

local cmp = require("cmp")
cmp.setup({
 snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
    	{ name = 'luasnip' }, -- For luasnip users.
    }, {
      { name = 'buffer' },
    })
});

vim.keymap.set('n', '<Leader>l', '<cmd>Lexplore<cr>');
vim.keymap.set('n', '<Leader>s', '<cmd>vertical rightbelow split<cr>');
vim.keymap.set('n', '<leader>q', '<cmd>wq!<cr>');
vim.keymap.set('n', '<Leader>t', '<cmd>terminal<cr>');
vim.keymap.set('n', '<Leader>f', '<cmd>Files<cr>');
vim.keymap.set('n', '<Leader>F', '<cmd>Rg<cr>');

vim.cmd.colorscheme("codedark");


vim.keymap.set('n', '<C-h>', '<C-w>h');
vim.keymap.set('n', '<C-j>', '<C-w>j');
vim.keymap.set('n', '<C-k>', '<C-w>k');
vim.keymap.set('n', '<C-l>', '<C-w>l');

vim.keymap.set({'t', 'i'}, '<C-h>', '<C-Bslash><C-N><C-w>h');
vim.keymap.set({'t', 'i'}, '<C-j>', '<C-Bslash><C-N><C-w>j');
vim.keymap.set({'t', 'i'}, '<C-k>', '<C-Bslash><C-N><C-w>k');
vim.keymap.set({'t', 'i'}, '<C-l>', '<C-Bslash><C-N><C-w>l');
