local M = {}

-- Default configuration
local config = {
  target_pane = "0.1",
}

-- Escape special characters for tmux
local function escape_text(text)
  local escaped_chars = { "\\", ";", '"', "$", "'" }
  for _, char in ipairs(escaped_chars) do
    text = text:gsub("%" .. char, "\\" .. char)
  end
  return text
end

-- Send text to configured pane with Enter
function M.send(text)
  local escaped_text = escape_text(text)
  local cmd = string.format("tmux send-keys -t '%s' '%s' C-m", config.target_pane, escaped_text)
  os.execute(cmd)
end

-- Send highlighted text using getregion
function M.send_highlighted_text()
  local region = vim.fn.getregion(vim.fn.getpos("'<"), vim.fn.getpos("'>"), { type = "v" })
  print(region)
  local text = table.concat(region, "\n")
  M.send(text)
end

-- Send current line
function M.send_current_line()
  local line = vim.api.nvim_get_current_line()
  M.send(line)
end

-- Setup function
function M.setup(opts)
  opts = opts or {}
  config.target_pane = opts.target_pane or config.target_pane
end

return M
