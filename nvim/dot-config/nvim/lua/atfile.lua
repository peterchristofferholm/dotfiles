local M = {}
function M.new() return setmetatable({}, { __index = M }) end
function M:get_trigger_characters() return { "@" } end

function M:get_completions(_, cb)
  vim.system({ "git", "ls-files" }, { text = true }, function(out)
    local items = {}
    for f in (out.stdout or ""):gmatch("[^\n]+") do
      items[#items + 1] = { label = "@" .. f, insertText = f, filterText = "@" .. f }
    end
    cb({ items = items, is_incomplete_forward = false, is_incomplete_backward = false })
  end)
end

return M
