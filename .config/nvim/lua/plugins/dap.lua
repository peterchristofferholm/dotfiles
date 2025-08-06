local config = function()
	local mason_dap = require("mason-nvim-dap")
	local dap = require("dap")
	local ui = require("dapui")

	mason_dap.setup({
		ensure_installed = { "python" },
		automatic_installation = true,
		handlers = {
			function(config)
				require("mason-nvim-dap").default_setup(config)
			end,
		},
	})

	dap.configurations = {
		python = {
			{
				type = "python",
				request = "launch",
				name = "Launch file",
				program = "${file}",
				pythonPath = function()
					local git_root = vim.fn.system("git rev-parse --show-toplevel | xargs")

					if vim.fn.executable(git_root .. "/.venv/bin/python") == 1 then
						return git_root .. "/.venv/bin/python"
					end

					if vim.fn.executable(".venv/bin/python") == 1 then
						return ".venv/bin/python"
					end

					-- Fall back to /usr/bin/env python

					return "/usr/bin/python"
				end,
			},
		},
	}

	-- Dap UI
	ui.setup()
	vim.fn.sign_define("DapBreakpoint", { text = "🔴" })

	dap.listeners.before.attach.dapui_config = function()
		ui.open()
	end
	dap.listeners.before.launch.dapui_config = function()
		ui.open()
	end
	dap.listeners.before.event_terminated.dapui_config = function()
		ui.close()
	end
	dap.listeners.before.event_exited.dapui_config = function()
		ui.close()
	end
end

return {
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"jay-babu/mason-nvim-dap.nvim",
		},
		config = config,
	},

	-- {
	-- 	"nvim-neotest/neotest",
	-- 	dependencies = {
	-- 		"nvim-neotest/nvim-nio",
	-- 		"nvim-lua/plenary.nvim",
	-- 		"antoinemadec/FixCursorHold.nvim",
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 		"nvim-neotest/neotest-python",
	-- 	},
	-- 	config = function()
	-- 		require("neotest").setup({
	-- 			adapters = {
	-- 				require("neotest-python")({
	-- 					dap = { justMyCode = false },
	-- 					args = { "--log-level", "DEBUG" },
	-- 					runner = "poetry run pytest",
	-- 					python = ".venv/bin/python",
	-- 				}),
	-- 			},
	-- 		})
	-- 	end,
	-- },
}
