local function pane_id_of(sess)
  while sess do
    if sess.tmux_pane_id then
      return sess.tmux_pane_id
    end
    sess = sess.parent
  end
end

local function focus_sidekick_pane(session_id)
  local Session = require("sidekick.cli.session")
  for id, sess in pairs(Session.attached()) do
    if not session_id or id == session_id then
      local pane = pane_id_of(sess)
      if pane then
        vim.fn.system({ "tmux", "select-pane", "-t", pane })
        return true
      end
    end
  end
  return false
end

local function send(opts)
  if not focus_sidekick_pane() then
    vim.api.nvim_create_autocmd("User", {
      pattern = "SidekickCliAttach",
      once = true,
      callback = function(ev)
        focus_sidekick_pane(ev.data and ev.data.id)
      end,
    })
  end
  require("sidekick.cli").send(opts)
end

return {
  {
    "folke/sidekick.nvim",
    opts = {
      -- add any options here
      cli = {
        mux = {
          backend = "tmux",
          enabled = true,
          create = "split",
          split = {
            vertical = true,
            size = 0.4,
          },
        },
        win = {
          layout = "float",
          float = {
            width = 1,
            height = 0.95,
          },
          split = {
            width = 0.382,
            height = 0.4,
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
          send({ msg = "{this}" })
        end,
        mode = { "x", "n" },
        desc = "Send This",
      },
      {
        "<leader>af",
        function()
          send({ msg = "{file}" })
        end,
        desc = "Send File",
      },
      {
        "<leader>av",
        function()
          send({ msg = "{selection}" })
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
          send({ msg = "/clear" })
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
}
