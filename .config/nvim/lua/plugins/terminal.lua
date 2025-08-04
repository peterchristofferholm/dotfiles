local keys = {
    -- different terminal directions
    { "<leader>tt", "<cmd>ToggleTerm direction=float<cr>", desc = "Horizontal terminal" },
    { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Horizontal terminal" },
    { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Vertical terminal" },

    -- send code to terminal
    {
        "<leader><CR>",
        "<cmd>ToggleTermSendCurrentLine<cr>",
        mode = "n",
        desc = "Send line to terminal"
    },
    {
        "<leader><CR>",
        "<cmd>ToggleTermSendVisualSelection<cr>",
        mode = "v",
        desc = "Send selection to terminal"
    },

    -- terminal mode mappings
    { "<esc>", [[<C-\><C-n>]], mode = "t", desc = "Exit terminal mode" },
    { "<C-h>", [[<Cmd>wincmd h<CR>]], mode = "t", desc = "Go to left window" },
    { "<C-j>", [[<Cmd>wincmd j<CR>]], mode = "t", desc = "Go to lower window" },
    { "<C-k>", [[<Cmd>wincmd k<CR>]], mode = "t", desc = "Go to upper window" },
    { "<C-l>", [[<Cmd>wincmd l<CR>]], mode = "t", desc = "Go to right window" },
}

local float_opts = {
    border = "curved",
    width = function()
        return math.floor(vim.o.columns * 0.8)
    end,
    height = function()
        return math.floor(vim.o.lines * 0.80)
    end,
}

return {
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        lazy = false,
        config = true,
        opts = {
            direction = "float",
            open_mapping = [[<c-\>]],
            float_opts = float_opts,
        },
        keys = keys,
    }
}
