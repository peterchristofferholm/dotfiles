vim.g.mapleader = " "
vim.g.maplocalleader = ","

local set = vim.keymap.set

-- window navigation
set("n", "<C-h>", "<Cmd>wincmd h<CR>")
set("n", "<C-j>", "<Cmd>wincmd j<CR>")
set("n", "<C-k>", "<Cmd>wincmd k<CR>")
set("n", "<C-l>", "<Cmd>wincmd l<CR>")

-- esc in normal mode clears search results
vim.keymap.set("n", "<Esc>", "<cmd>noh<CR>")

vim.keymap.set("n", "<leader>rp", function()
  vim.cmd("LspRestart pyright")
end, { desc = "Restart Pyright LSP" })

vim.keymap.set("n", "<leader>lr", function()
  vim.cmd("cexpr system('ruff check --output-format=concise .')")
  vim.cmd("copen")
end, { desc = "Ruff: lint project" })

local pyright_efm = "%f:%l:%c - %trror: %m,%f:%l:%c - %tarning: %m,%f:%l:%c - %tnformation: %m"

local function typecheck_project()
  local lines = {}
  vim.fn.jobstart({ "bash", "-c", "pyright 2>&1" }, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      for _, line in ipairs(data) do
        if line ~= "" then
          table.insert(lines, line)
        end
      end
    end,
    on_exit = function()
      vim.schedule(function()
        vim.fn.setqflist({}, "r", { title = "Pyright", lines = lines, efm = pyright_efm })
        vim.cmd("copen")
        vim.notify("Pyright done!")
      end)
    end,
  })
  vim.notify("Pyright running...")
end
vim.keymap.set("n", "<leader>lt", typecheck_project, { desc = "Pyright: type-check project" })

-- double escape to exit terminal mode without delaying single escape
local esc_timer
set("t", "<Esc>", function()
  esc_timer = esc_timer or (vim.uv or vim.loop).new_timer()
  if esc_timer:is_active() then
    esc_timer:stop()
    vim.cmd("stopinsert")
  else
    esc_timer:start(200, 0, function() end)
    return "<Esc>"
  end
end, { expr = true, desc = "Double escape to normal mode" })

set("n", "<leader>yf", function()
  vim.fn.setreg('"', vim.fn.expand("%:."))
end, { desc = "Yank buffer path to unnamed register" })
