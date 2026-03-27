local M = {}

local config = {
  target_pane = "0.1",
}

local function tmux(args, opts)
  return vim.system(args, opts):wait()
end

local function dedent(lines)
  local min = math.huge
  for _, line in ipairs(lines) do
    if line:match("%S") then
      min = math.min(min, #line:match("^(%s*)"))
    end
  end
  if min == 0 or min == math.huge then
    return lines
  end
  for i, line in ipairs(lines) do
    lines[i] = line:sub(min + 1)
  end
  return lines
end

local function send(lines)
  local text = table.concat(lines, "\n"):gsub("%s+$", "")
  if text == "" then
    return
  end
  local suffix = text:find("\n") and "\n\n" or "\n"
  tmux({ "tmux", "load-buffer", "-" }, { stdin = text .. suffix })
  tmux({ "tmux", "paste-buffer", "-d", "-t", config.target_pane })
end

function M.send_visual()
  local region = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = vim.fn.mode() })
  send(dedent(region))
end

function M.send_line()
  send({ vim.trim(vim.api.nvim_get_current_line()) })
end

function M.send_block()
  local node = vim.treesitter.get_node()
  if not node then
    vim.notify("No treesitter node under cursor", vim.log.levels.WARN)
    return
  end
  while node:parent() and node:parent():type() ~= "module" do
    node = node:parent()
  end
  local sr, sc, er, ec = node:range()
  send(vim.api.nvim_buf_get_text(0, sr, sc, er, ec, {}))
end

function M.setup(opts)
  config = vim.tbl_extend("force", config, opts or {})
end

return M
