return {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
        keymaps = {
            -- disable these
            ["<C-h>"] = false,
            ["<C-j>"] = false,
            ["<C-k>"] = false,
            ["<C-l>"] = false,
        }
    },
    keys = {
        { "-", "<CMD>Oil<CR>", mode = "n", desc = "Open parent directory" },
    },
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    lazy = false,
}
