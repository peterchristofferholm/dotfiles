return {
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      keymaps = {
        -- disable these
        ["<C-s>"] = false,
        ["<C-a>"] = false,
        ["<C-d>"] = false,
        ["<C-h>"] = false,
        ["<C-j>"] = false,
        ["<C-k>"] = false,
        ["<C-l>"] = false,
        ["g."] = { "actions.toggle_hidden", mode = "n" },

        -- Snacks terminal in the directory Oil is showing (see snacks.nvim: Snacks.terminal)
        ["<leader>to"] = {
          function()
            local dir = require("oil").get_current_dir()
            Snacks.terminal(nil, { cwd = dir or vim.fn.getcwd() })
          end,
          mode = "n",
          desc = "Snacks terminal (Oil directory)",
        },
      },
    },
    keys = {
      { "-", "<CMD>Oil<CR>", mode = "n", desc = "Open parent directory" },
    },
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    lazy = false,
  },
}
