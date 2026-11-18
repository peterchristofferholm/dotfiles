local M = {}

-- split on lines containing only `---`, ignoring ones inside fenced code blocks
local function split(lines)
  local slides, cur, fenced = {}, {}, false
  for _, line in ipairs(lines) do
    if line:match("^```") then
      fenced = not fenced
    end
    if not fenced and line:match("^%-%-%-+%s*$") then
      table.insert(slides, cur)
      cur = {}
    else
      table.insert(cur, line)
    end
  end
  table.insert(slides, cur)
  return slides
end

function M.start()
  local slides = split(vim.api.nvim_buf_get_lines(0, 0, -1, false))
  local idx = 1

  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].filetype = "markdown"

  -- black backdrop covering the whole screen, with the slide floating on top
  vim.api.nvim_set_hl(0, "SlidesBackdrop", { bg = "#000000" })
  local border_fg = vim.api.nvim_get_hl(0, { name = "FloatBorder", link = false }).fg
  vim.api.nvim_set_hl(0, "SlidesBorder", { bg = "#000000", fg = border_fg })
  local backdrop_buf = vim.api.nvim_create_buf(false, true)
  vim.bo[backdrop_buf].bufhidden = "wipe"
  local backdrop = vim.api.nvim_open_win(backdrop_buf, false, {
    relative = "editor",
    width = vim.o.columns,
    height = vim.o.lines,
    row = 0,
    col = 0,
    style = "minimal",
    focusable = false,
    zindex = 40,
  })
  vim.wo[backdrop].winhighlight = "NormalFloat:SlidesBackdrop"

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = vim.o.columns - 4,
    height = vim.o.lines - 4,
    row = 1,
    col = 1,
    style = "minimal",
    border = "rounded",
    zindex = 50,
  })
  vim.wo[win].winhighlight = "NormalFloat:SlidesBackdrop,FloatBorder:SlidesBorder,FloatFooter:SlidesBorder"
  vim.api.nvim_create_autocmd("WinClosed", {
    pattern = tostring(win),
    once = true,
    callback = function()
      if vim.api.nvim_win_is_valid(backdrop) then
        vim.api.nvim_win_close(backdrop, true)
      end
    end,
  })
  vim.wo[win].wrap = true
  vim.wo[win].linebreak = true
  vim.wo[win].conceallevel = 2

  local function render()
    vim.bo[buf].modifiable = true
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, slides[idx])
    vim.bo[buf].modifiable = false
    vim.api.nvim_win_set_config(win, { footer = (" %d/%d "):format(idx, #slides), footer_pos = "right" })
    vim.api.nvim_win_set_cursor(win, { 1, 0 })
  end

  local function go(to)
    idx = math.min(#slides, math.max(1, to))
    render()
  end

  local function map(lhs, fn)
    vim.keymap.set("n", lhs, fn, { buffer = buf, nowait = true })
  end
  for _, k in ipairs({ "n", "l", "<Right>", "<CR>" }) do
    map(k, function() go(idx + 1) end)
  end
  for _, k in ipairs({ "p", "h", "<Left>", "<BS>" }) do
    map(k, function() go(idx - 1) end)
  end
  map("gg", function() go(1) end)
  map("G", function() go(#slides) end)
  map("q", function() vim.api.nvim_win_close(win, true) end)

  render()
end

return M
