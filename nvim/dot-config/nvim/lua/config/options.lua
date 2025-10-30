vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.smartindent = true
vim.opt.colorcolumn = "100"
vim.opt.relativenumber = true

-- use lsp foldexpr()
vim.opt.fillchars = "eob: ,fold: ,foldopen:,foldsep: ,foldclose:"
vim.opt.foldenable = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

-- enable loading of .nvim.lua files
vim.o.exrc = true
vim.o.secure = true

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
