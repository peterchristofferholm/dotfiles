local configure = function()
  require("nvim-treesitter").install({
    "bash",
    "diff",
    "lua",
    "markdown",
    "markdown_inline",
    "query",
    "python",
    "pkl",
  })
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = configure,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    lazy = false,
    build = ":TSUpdate",
    opts = {
      enable = true,
      multiwindow = false,
      max_lines = 0,
      min_window_height = 0,
      line_numbers = true,
      multiline_threshold = 20,
      trim_scope = "outer",
      mode = "cursor",
      separator = nil,
      zindex = 20,
      on_attach = nil,
    },
  },
}
