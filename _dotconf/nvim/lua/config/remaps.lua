vim.g.mapleader = " "
vim.g.maplocalleader = ","

local set = vim.keymap.set

-- window navigation
set("n", "<C-h>", "<Cmd>wincmd h<CR>")
set("n", "<C-j>", "<Cmd>wincmd j<CR>")
set("n", "<C-k>", "<Cmd>wincmd k<CR>")
set("n", "<C-l>", "<Cmd>wincmd l<CR>")

-- esc in normal mode clears search results
vim.keymap.set("n", "<Esc>", "<cmd>noh<CR>")

vim.api.nvim_create_autocmd("User", {
  pattern = "OilActionsPost",
  callback = function(event)
    if event.data.actions.type == "move" then
      Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
    end
  end,
})
