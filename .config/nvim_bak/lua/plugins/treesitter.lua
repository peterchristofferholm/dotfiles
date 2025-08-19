local configure = function()
	require("nvim-treesitter.configs").setup({
		ensure_installed = { "bash", "diff", "lua", "markdown", "markdown_inline", "query", "python" },
		sync_install = false,
		auto_install = true,
		ignore_install = { "javascript " },
		highlight = {
			disable = { "tmux" },
			enable = true,
			additional_vim_regex_highlighting = false,
		},
		indent = { enable = true },
		modules = {},
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
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	},
}
