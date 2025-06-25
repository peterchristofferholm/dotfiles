return {
    "nvim-tree/nvim-tree.lua",

    config = {
        view = { width = 15 },
        hijack_directories = { enable = false },
        renderer = {
            icons = {
                show = {
                    file = false,
                    folder = false,
                    folder_arrow = false,
                    git = true,
                },
            }
        },
    },

    cmd = {
        "NvimTreeToggle",
        "NvimTreeFindFileToggle"
    },

    keys = {
        { "<Leader>ee", "<Cmd>NvimTreeToggle<CR>", desc = "Root (toggle)" },
        { "<Leader>ef", "<Cmd>NvimTreeFindFileToggle<CR>", desc = "File (toggle)" },
    },
}
