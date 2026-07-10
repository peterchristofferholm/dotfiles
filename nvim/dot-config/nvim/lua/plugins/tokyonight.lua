local M = { "folke/tokyonight.nvim" }

M.opts = {
  style = "night",
  transparent = true,
  styles = {
    floats = "transparent",
    sidebars = "transparent",
  },
  on_highlights = function(hl, c)
    -- make trailing whitespace (and nbsp) stand out
    hl.Whitespace = { bg = c.red }
  end,
}

function M.config(_, opts)
  require("tokyonight").setup(opts)
  vim.cmd.colorscheme("tokyonight")
end

return M
