return {
	{
		dir = "~/work/toss.nvim",
		opts = {},
		keys = {
			{
				"<c-M>",
				function()
					require("toss.terminal").send()
				end,
				mode = { "n", "x" },
				desc = "Toss: send current block, selection, or line to terminal",
			},
			{
				"<leader>tt",
				function()
					require("toss.terminal").toggle()
				end,
				mode = { "n" },
				desc = "Toss: toggle terminal",
			},
		},
	},
	-- opts = {
	-- 	repl = {
	-- 		targets = {
	-- 			python = {},
	-- 		},
	-- 	},
	-- },
	-- keys = {
	-- 	{
	-- 		"<leader>rr",
	-- 		function()
	-- 			require("replz.repl").toggle()
	-- 		end,
	-- 		desc = "Replz Toggle REPL",
	-- 	},
	-- 	{
	-- 		"<leader>rs",
	-- 		function()
	-- 			require("replz.repl").select()
	-- 		end,
	-- 		-- Or to select only installed targets:
	-- 		-- require("replz.repl").select({ filter = { installed = true } })
	-- 		desc = "Select REPL",
	-- 	},
	-- 	{
	-- 		"<c-M>",
	-- 		function()
	-- 			require("replz.repl.send").block()
	-- 		end,
	-- 		mode = { "x", "n" },
	-- 		desc = "Send Block (selection or treesitter node under cursor)",
	-- 	},
	-- },
}
