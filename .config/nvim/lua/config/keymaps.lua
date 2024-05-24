-- Default keymaps: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Remove unused key mappings
vim.keymap.del("n", "<leader>,")

local map = vim.keymap.set

map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save Buffer" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Close Buffer" })
