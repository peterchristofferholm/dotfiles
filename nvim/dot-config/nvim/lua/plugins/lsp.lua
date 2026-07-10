return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.enable({
        "lua_ls",
        "basedpyright",
        "ruff",
        "marksman",
        "denols",
        "pyrefly",
        "bashls",
        "clangd",
      })
    end,
  },
}
