return {
  "folke/trouble.nvim",
  opts = {
    modes = {
      diagnostics = {
        auto_open = false,
        auto_close = true,
      },
    },
  },
  cmd = "Trouble",
  keys = {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xs",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "<leader>xl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
      "<leader>qq",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
    {
      "<M-j>",
      "<cmd>Trouble next skip_groups=true jump=true<cr>",
      desc = "Next trouble item",
    },
    {
      "<M-k>",
      "<cmd>Trouble prev skip_groups=true jump=true<cr>",
      desc = "Previous trouble item",
    },
  },
}
