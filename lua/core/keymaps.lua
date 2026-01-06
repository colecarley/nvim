vim.keymap.set("n", "<leader>w", "<cmd>write<cr>")
vim.keymap.set({ "n", "x" }, "gp", '"+p')
vim.keymap.set({ "n", "x" }, "gy", '"+y')
vim.keymap.set({ "n", "x" }, "gyy", '"+yy')

vim.keymap.set({ "n", "x" }, "gt", "<cmd>bnext<cr>")
vim.keymap.set({ "n", "x" }, "gT", "<cmd>bprev<cr>")

vim.keymap.set("n", "<Leader>a", "<cmd>NvimTreeToggle<cr>")
vim.keymap.set("n", "<Leader>\\", "<cmd>vertical rightbelow split<cr>")
vim.keymap.set("t", "<Leader>\\", "<cmd>TermNew<cr>")

vim.keymap.set("n", "<leader>q", "<cmd>q<cr>")
vim.keymap.set("n", "<leader>Q", "<cmd>qall<cr>")

vim.keymap.set("n", "<leader>p", "<cmd>FzfLua files<cr>")
vim.keymap.set("n", "<leader>F", "<cmd>FzfLua live_grep<cr>")
vim.keymap.set("n", "<leader>c", "<cmd>FzfLua buffers<cr>")

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("i", "<C-h>", "<C-Bslash><C-N><C-w>h")
vim.keymap.set("i", "<C-l>", "<C-Bslash><C-N><C-w>l")
vim.keymap.set("t", "<C-h>", "<C-Bslash><C-N><C-w>h")
vim.keymap.set("t", "<C-l>", "<C-Bslash><C-N><C-w>l")

vim.keymap.set("n", "<leader>ki", "<cmd>Lspsaga peek_definition<cr>")
