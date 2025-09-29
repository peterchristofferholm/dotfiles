local M = {}

local cache = {}

local function set_python_colorcolumn()
  local cache_key = vim.fn.getcwd()

  if cache[cache_key] then
    vim.opt_local.colorcolumn = cache[cache_key]
    return
  end

  local config_files = { "pyproject.toml", "ruff.toml" }

  for _, filename in ipairs(config_files) do
    local filepath = vim.fn.findfile(filename, ".;")
    if filepath ~= "" then
      local content = table.concat(vim.fn.readfile(filepath), "\n")
      local line_length = content:match("line%-length%s*=%s*(%d+)")
      if line_length then
        local _length = tostring(tonumber(line_length) + 1)
        cache[cache_key] = _length
        vim.opt_local.colorcolumn = _length
        break
      end
    end
  end
end

function M.setup()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = set_python_colorcolumn,
  })
end

return M
