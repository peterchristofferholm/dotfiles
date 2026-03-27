return {
  {
    "folke/sidekick.nvim",
    opts = {
      -- add any options here
      cli = {
        mux = {
          backend = "tmux",
          enabled = true,
        },
        win = {
          layout = "float",
          float = {
            width = 1,
            height = 0.95,
          },
        },
      },
      nes = { enabled = false },
    },
    keys = {
      {
        "<c-]>",
        function()
          require("sidekick.cli").toggle()
        end,
        desc = "Sidekick Toggle",
        mode = { "n", "t", "i", "x" },
      },
      {
        "<leader>ac",
        function()
          require("sidekick.cli").toggle()
        end,
        desc = "Sidekick Toggle CLI",
      },
      {
        "<leader>as",
        function()
          require("sidekick.cli").select()
        end,
        desc = "Select CLI",
      },
      {
        "<leader>ad",
        function()
          require("sidekick.cli").close()
        end,
        desc = "Detach a CLI Session",
      },
      {
        "<leader>at",
        function()
          require("sidekick.cli").send({ msg = "{this}" })
        end,
        mode = { "x", "n" },
        desc = "Send This",
      },
      {
        "<leader>af",
        function()
          require("sidekick.cli").send({ msg = "{file}" })
        end,
        desc = "Send File",
      },
      {
        "<leader>av",
        function()
          require("sidekick.cli").send({ msg = "{selection}" })
        end,
        mode = { "x" },
        desc = "Send Visual Selection",
      },
      {
        "<leader>ap",
        function()
          require("sidekick.cli").prompt()
        end,
        mode = { "n", "x" },
        desc = "Sidekick Select Prompt",
      },
      {
        "<leader>ax",
        function()
          require("sidekick.cli").send({ msg = "/clear" })
        end,
        desc = "Send /clear to CLI",
      },
      {
        "<leader>aa",
        function()
          require("sidekick.cli").toggle({ name = "claude", focus = true })
        end,
        desc = "Sidekick Toggle Claude",
      },
    },
  },
  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   build = ":Copilot auth",
  --   config = function()
  --     require("copilot").setup({
  --       suggestion = { enabled = false },
  --       panel = { enabled = false },
  --     })
  --   end,
  -- },
  -- {
  --   "giuxtaposition/blink-cmp-copilot",
  -- },
}
