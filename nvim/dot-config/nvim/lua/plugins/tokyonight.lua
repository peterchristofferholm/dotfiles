local M = { "folke/tokyonight.nvim" }

M.opts = {
  style = "night",
  transparent = true,
  styles = {
    floats = "transparent",
    sidebars = "transparent",
  },
}

function M.config(_, opts)
  require("tokyonight").setup(opts)
  vim.cmd.colorscheme("tokyonight")
end

return M
