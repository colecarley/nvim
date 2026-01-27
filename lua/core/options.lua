vim.g.mapleader = " "
vim.opt.clipboard = "unnamedplus"

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
vim.opt.hlsearch = true
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.diagnostic.config({
	virtual_text = true,
	virtual_lines = { current_line = true },
	underline = true,
	update_in_insert = false,
})


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

local function outgoing_calls()
	vim.cmd('FzfLua lsp_outgoing_calls')
end

local function incoming_calls()
	vim.cmd('FzfLua lsp_incoming_calls')
end

local function git_status()
	vim.cmd('FzfLua git_status')
end

vim.api.nvim_create_user_command("Outcalls", outgoing_calls, {})
vim.api.nvim_create_user_command("Incalls", incoming_calls, {})
vim.api.nvim_create_user_command("Status", git_status, {})

vim.api.nvim_create_user_command("Format", function(args)
    require("conform").format({
        async = true,
        timeout_ms = 500,
        lsp_fallback = true,
        range = {
            ["start"] = vim.api.nvim_buf_get_mark(0, "<"),
            ["end"] = vim.api.nvim_buf_get_mark(0, ">"),
        },
    })
end, { range = true })

vim.api.nvim_create_user_command("FormatBuffer", function(args)
    require("conform").format({
        async = true,
        timeout_ms = 500,
        lsp_fallback = true,
    })
end, { range = false })
