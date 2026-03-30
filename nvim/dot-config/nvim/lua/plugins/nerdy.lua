return {
	"2kabhishek/nerdy.nvim",
	dependencies = {
		"folke/snacks.nvim",
	},
	cmd = "Nerdy",
	opts = {
		max_recents = 20,
		copy_to_clipboard = false,
		copy_register = "+",
	},
	keys = {
		{ "<leader>in", ":Nerdy list<CR>", desc = "Browse nerd icons" },
		{ "<leader>iN", ":Nerdy recents<CR>", desc = "Browse recent nerd icons" },
	},
}
