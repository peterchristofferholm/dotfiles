local augroup = vim.api.nvim_create_augroup("peho", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "markdown", "python", "lua", "pkl", "templ", "go" },
  callback = function()
    vim.treesitter.start()
  end,
})
--
-- vim.api.nvim_create_autocmd("FileType", {
--   group = augroup,
--   pattern = { "yaml", "yml" },
--   callback = function()
--     vim.opt_local.tabstop = 2
--     vim.opt_local.shiftwidth = 2
--     vim.opt_local.softtabstop = 2
--     vim.opt_local.expandtab = true
--   end,
-- })
--
--
-- vim.api.nvim_create_autocmd("BufRead", {
--   group = augroup,
--   callback = function(ev)
--     if vim.bo[ev.buf].buftype == "quickfix" then
--       vim.schedule(function()
--         vim.cmd.cclose()
--         vim.cmd("Trouble qflist open")
--       end)
--     end
--   end,
-- })
--
--

-- keep lsp and imports in sync when doing oil renames
vim.api.nvim_create_autocmd("User", {
  pattern = "OilActionsPost",
  callback = function(event)
    if event.data.actions[1].type == "move" then
      Snacks.rename.on_rename_file(event.data.actions[1].src_url, event.data.actions[1].dest_url)
    end
  end,
})

-- make oil buffers behave like normal buffers for snacks
vim.api.nvim_create_autocmd("FileType", {
  pattern = "oil",
  callback = function(args)
    vim.b[args.buf].snacks_main = true
  end,
})
