local configure = function()
  require("nvim-treesitter").install({
    "bash",
    "diff",
    "jinja",
    "lua",
    "go",
    "markdown",
    "markdown_inline",
    "pkl",
    "python",
    "query",
    "html",
    "templ",
    "typst",
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
