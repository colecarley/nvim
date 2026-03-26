return {
	{
		"tomasiser/vim-code-dark",
		-- config = function()
		-- 	vim.cmd.colorscheme("codedark")
		-- end,
	},
	{
		"Mofiqul/vscode.nvim",
		-- config = function()
		-- 	vim.cmd.colorscheme("vscode")
		-- end,
	},
	{
		"sainnhe/gruvbox-material",
		-- config = function()
		-- 	vim.cmd.colorscheme("gruvbox-material")
		-- end,
	},
	{
		"navarasu/onedark.nvim",
		-- config = function()
		-- 	vim.cmd.colorscheme("onedark")
		-- end,
	},
	{
		"dasupradyumna/midnight.nvim",
		-- config = function()
		-- 	vim.cmd.colorscheme("midnight")
		-- end,
	},
    {
		"webhooked/kanso.nvim",
		config = function()
            require("kanso").setup({ theme = "zen" })
			vim.cmd.colorscheme("kanso")
		end,
	},
    {
		"rebelot/kanagawa.nvim",
		-- config = function()
		-- 	vim.cmd.colorscheme("kanagawa-dragon")
		-- end,
	},
}
