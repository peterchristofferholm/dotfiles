local M = { "folke/tokyonight.nvim" }

M.opts = { style = "night" }

function M.config()
  vim.cmd.colorscheme("tokyonight")
end

return M
