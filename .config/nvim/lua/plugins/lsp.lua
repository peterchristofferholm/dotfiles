return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.enable({
        "lua_ls",
        "pyright",
        "ruff",
        "marksman",
        "bashls",
      })
    end,
  },
}
