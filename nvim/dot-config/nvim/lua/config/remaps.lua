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

vim.keymap.set("n", "<leader>rp", function()
  vim.cmd("LspRestart pyright")
end, { desc = "Restart Pyright LSP" })

-- double escape to exit terminal mode without delaying single escape
local esc_timer
set("t", "<Esc>", function()
  esc_timer = esc_timer or (vim.uv or vim.loop).new_timer()
  if esc_timer:is_active() then
    esc_timer:stop()
    vim.cmd("stopinsert")
  else
    esc_timer:start(200, 0, function() end)
    return "<Esc>"
  end
end, { expr = true, desc = "Double escape to normal mode" })
