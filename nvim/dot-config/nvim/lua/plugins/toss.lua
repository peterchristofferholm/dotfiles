return {
  {
    "peterchristofferholm/toss.nvim",
    opts = {},
    keys = {
      {
        "<c-M>",
        function()
          require("toss.terminal").send()
          -- go down after
          vim.cmd("normal! }j")
        end,
        mode = { "n", "x" },
        desc = "Toss: send current block, selection, or line to terminal",
      },
      {
        "<leader>tt",
        function()
          require("toss.terminal").toggle()
        end,
        mode = { "n" },
        desc = "Toss: toggle terminal",
      },
    },
  },
}
