vim.keymap.set("n", "<leader>w", "<cmd>write<cr>")

vim.keymap.set({ "n", "x" }, "gt", "<cmd>bnext<cr>")
vim.keymap.set({ "n", "x" }, "gT", "<cmd>bprev<cr>")

vim.keymap.set("n", "<Leader>-", "<C-w>s")
vim.keymap.set("n", "<Leader>\\", "<C-w>v")
vim.keymap.set("n", "<Leader>wc", "<C-w><C-q>")


vim.keymap.set("n", "<leader>q", "<cmd>q!<cr>")
vim.keymap.set("n", "<leader>Q", "<cmd>qall!<cr>")

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set({"i", "t"}, "<C-h>", "<C-Bslash><C-N><C-w>h")
vim.keymap.set({"i", "t"}, "<C-l>", "<C-Bslash><C-N><C-w>l")
vim.keymap.set({"i", "t"}, "<C-k>", "<C-Bslash><C-N><C-w>k")
vim.keymap.set({"i", "t"}, "<C-j>", "<C-Bslash><C-N><C-w>j")
