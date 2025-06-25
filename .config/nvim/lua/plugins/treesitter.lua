return {
    {
        "nvim-treesitter/nvim-treesitter", 
        branch = 'master', lazy = false, build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { 'bash', 'diff', 'html', 'lua', 'markdown', 'markdown_inline', 'query', 'python' },
                sync_install = true,
                auto_install = true,
                highlight = {
                  enable = true,
                  additional_vim_regex_highlighting = false,
                },
                indent = { enable = true },
            })
        end
    },
}
