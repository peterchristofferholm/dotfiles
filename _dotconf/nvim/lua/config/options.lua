vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.smartindent = true
vim.opt.colorcolumn = "100"
vim.opt.relativenumber = true

vim.opt.cursorline = true
vim.opt.fillchars = { vert = "│" }
vim.opt.number = true
vim.opt.scrolloff = 8
vim.opt.shortmess:append("c")
vim.opt.showmode = false
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true

vim.opt.grepprg = "rg --vimgrep"
vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.smartcase = true

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "python", "lua", "pkl" },
  callback = function()
    vim.treesitter.start()
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.pkl",
  command = "set filetype=pkl",
})
