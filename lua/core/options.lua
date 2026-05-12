vim.g.mapleader = " "
vim.opt.clipboard = "unnamedplus"

vim.opt.background = "dark"

vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_better_performance = 1

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.lazygit_config = false

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
vim.opt.cursorline = true

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

local function get_current_path()
    local path = vim.fn.expand("%");
    vim.fn.setreg("+", path)
    print("Copied: " .. path)
end

vim.api.nvim_create_user_command("Path", get_current_path, {})

local function remove_all_buffers()
    local bufs = vim.api.nvim_list_bufs()
    for _, bufnr in ipairs(bufs) do
        -- Only delete valid and loaded buffers
        if vim.api.nvim_buf_is_loaded(bufnr) then
            vim.api.nvim_buf_delete(bufnr, { force = true })
        end
    end
end

vim.api.nvim_create_user_command("CleanUp", remove_all_buffers, {});

vim.api.nvim_create_user_command("Term", function()
    vim.cmd("term");
end, {})

vim.api.nvim_create_user_command("Here", function()
    local file = vim.api.nvim_buf_get_name(0)
    local line = vim.api.nvim_win_get_cursor(0)[1]
    local fileAndLine = file .. ":" .. tostring(line)
    vim.fn.setreg("+", fileAndLine)
    print("Copied: " .. fileAndLine)
end, {})

local function googleSearch()
    local start_pos = vim.api.nvim_buf_get_mark(0, "<")
    local end_pos = vim.api.nvim_buf_get_mark(0, ">")
    local lines = vim.api.nvim_buf_get_text(0, start_pos[1] - 1, start_pos[2], end_pos[1] - 1, end_pos[2] + 1, {})
    local text = table.concat(lines, " ")
    local query = text:gsub("^%s*(.-)%s*$", "%1"):gsub(" ", "+")
    if query ~= "" then
        os.execute("open 'https://google.com/search?q=" .. query .. "'")
    end
end

vim.api.nvim_create_user_command("Google", googleSearch, { range = true });

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
