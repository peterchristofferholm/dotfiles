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
    "jinja",
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
}
