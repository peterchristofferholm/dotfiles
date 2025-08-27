return {
  {
    dir = vim.fn.stdpath("config") .. "/plugins/shuttle",
    opts = {
      target_pane = "0.1",
    },
    config = function(_, opts)
      local shuttle = require("shuttle")
      shuttle.setup(opts)

      -- Set up keymappings
      vim.keymap.set(
        "v",
        "<leader>r",
        shuttle.send_highlighted_text,
        { desc = "Shuttle selection to pane" }
      )
      vim.keymap.set(
        "n",
        "<leader>r",
        shuttle.send_current_line,
        { desc = "Shuttle current line to pane" }
      )
    end,
  },
}
