return {
  "neovim/nvim-lspconfig",
  config = function()
    vim.lsp.enable({
      "lua_ls",
      "denols",
      "ty",
      "ruff",
      "marksman",
      "bashls",
      "clangd",
      "gopls",
      "r_language_server",
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp_completion", { clear = true }),
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client:supports_method("textDocument/completion") then
          vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = false })
          vim.keymap.set("i", "<C-Space>", vim.lsp.completion.get, { buffer = args.buf })
        end
      end,
    })
  end,
}
