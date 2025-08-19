return {
	{
		"apple/pkl-neovim",
		lazy = true,
		ft = "pkl",
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter",
				build = function(_)
					vim.cmd("TSUpdate")
				end,
			},
		},
		config = function()
			-- Configure pkl-lsp
			local hasConfigs, configs = pcall(require, "nvim-treesitter.configs")
			if hasConfigs then
				configs.setup({
					ensure_installed = "pkl",
					highlight = {
						enable = true,
					},
					indent = {
						enable = true,
					},
				})
			end
		end,
	},
}
