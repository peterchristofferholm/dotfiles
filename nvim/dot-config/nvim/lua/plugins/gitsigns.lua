local M = { "lewis6991/gitsigns.nvim" }

M.opts = {
  signs = {
    add = { text = "┃" },
    change = { text = "┃" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
    untracked = { text = "┆" },
  },
  signs_staged = {
    add = { text = "┃" },
    change = { text = "┃" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
    untracked = { text = "┆" },
  },
  signs_staged_enable = true,
  signcolumn = true,
  numhl = false,
  linehl = false,
  word_diff = false,
  watch_gitdir = {
    follow_files = true,
  },
  auto_attach = true,
  attach_to_untracked = false,
  current_line_blame = false,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol",
    delay = 1000,
    ignore_whitespace = false,
    virt_text_priority = 100,
    use_focus = true,
  },
  current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil,
  max_file_length = 40000,
  preview_config = {
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
  on_attach = function(bufnr)
    local gs = require("gitsigns")

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    require("which-key").add({
      { "<leader>p", group = "preview/hunks", buffer = bufnr },
      { "<leader>pt", group = "toggle", buffer = bufnr },
    })

    map("n", "]c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "]c", bang = true })
      else
        gs.nav_hunk("next")
      end
    end, { desc = "Next hunk" })

    map("n", "[c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "[c", bang = true })
      else
        gs.nav_hunk("prev")
      end
    end, { desc = "Prev hunk" })

    map("n", "<leader>pp", gs.preview_hunk, { desc = "Preview hunk" })
    map("n", "<leader>pi", gs.preview_hunk_inline, { desc = "Preview hunk inline" })

    map("n", "<leader>pd", gs.diffthis, { desc = "Diff against index" })
    map("n", "<leader>pD", function()
      gs.diffthis(vim.g.diff_base or "master")
    end, { desc = "Diff against branch base" })

    map("n", "<leader>ptd", gs.toggle_deleted, { desc = "Toggle deleted lines" })
    map("n", "<leader>ptb", gs.toggle_current_line_blame, { desc = "Toggle line blame" })
    map("n", "<leader>ptw", gs.toggle_word_diff, { desc = "Toggle word diff" })

    map("n", "<leader>pc", function()
      gs.blame_line({ full = true })
    end, { desc = "Blame line (full)" })

    map("n", "<leader>pq", gs.setqflist, { desc = "Hunks to quickfix" })
    map("n", "<leader>pQ", function()
      gs.setqflist("all")
    end, { desc = "All hunks to quickfix" })

    map({ "o", "x" }, "ih", gs.select_hunk, { desc = "Select hunk" })
  end,
}

return M
