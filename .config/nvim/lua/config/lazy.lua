-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

-- load core configuration
require("config.remaps")
require("config.options")

-- setup lazy.nvim
require("lazy").setup({
    change_detection = { notify = false },
    spec = {{ import = "plugins" }},
    checker = { enabled = true },
    install = { colorscheme = { "tokyonight-moon" }}
})
