return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      lazygit = {
        win = {
          border = "rounded",
        },
      },
      indent = {},
    },
    keys = {
      {
        "<leader>gg",
        function()
          Snacks.lazygit()
        end,
        desc = "Lazygit",
      },
      {
        "<leader>.",
        function()
          Snacks.scratch()
        end,
        desc = "Toggle Scratch Buffer",
      },
      {
        "<leader>S",
        function()
          Snacks.scratch.select()
        end,
        desc = "Select Scratch Buffer",
      },
      {
        "<leader>tf",
        function()
          local path = vim.api.nvim_buf_get_name(0)
          local cwd = path ~= "" and vim.fn.fnamemodify(path, ":p:h") or vim.fn.getcwd()
          Snacks.terminal(nil, { cwd = cwd })
        end,
        desc = "Terminal (current file dir)",
      },
    },
  },
}
