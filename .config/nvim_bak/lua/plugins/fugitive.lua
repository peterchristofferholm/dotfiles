return {
	"tpope/vim-fugitive",
	lazy = false,
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
	end,
}
