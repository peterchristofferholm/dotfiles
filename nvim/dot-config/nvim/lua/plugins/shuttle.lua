return {
  {
    dir = vim.fn.stdpath("config") .. "/plugins/shuttle",
    opts = {
      target_pane = "0.1",
    },
    config = function(_, opts)
      local shuttle = require("shuttle")
      shuttle.setup(opts)

      vim.keymap.set("v", "<leader>r", shuttle.send_visual, { desc = "Shuttle selection to pane" })

      vim.keymap.set("n", "<leader>r", shuttle.send_line, { desc = "Shuttle current line to pane" })
      vim.keymap.set("n", "<leader>rb", shuttle.send_block, { desc = "Shuttle treesitter block to pane" })
    end,
  },
}
