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
		})

		vim.lsp.config("denols", {
			on_attach = on_attach,
			root_markers = { "deno.json", "deno.jsonc" },
		})

		vim.lsp.config("ts_ls", {
			on_attach = on_attach,
			root_markers = { "package.json" },
			single_file_support = false,
		})
	end,
}
