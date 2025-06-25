vim.g.mapleader = " "
vim.g.maplocalleader = ","

local set = vim.keymap.set

set("n", "<leader>pv", vim.cmd.Ex)

-- window navigation
set("n", "<C-h>", "<Cmd>wincmd h<CR>")
set("n", "<C-j>", "<Cmd>wincmd j<CR>")
set("n", "<C-k>", "<Cmd>wincmd k<CR>")
set("n", "<C-l>", "<Cmd>wincmd l<CR>")

