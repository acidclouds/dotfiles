return {
	{
		"mfussenegger/nvim-dap",
		keys = {
			{ "<leader>dt", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "Toggle Breakpoint" },
			{ "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", desc = "Continue" },
			{ "<leader>ds", "<cmd>lua require'dap'.step_into()<cr>", desc = "Step Into" },
			{ "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", desc = "Step Over" },
			{ "<leader>du", "<cmd>lua require'dap'.step_out()<cr>", desc = "Step Out" },
			{ "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", desc = "Toggle Repl" },
			{ "<leader>dp", "<cmd>lua require'dap'.pause()<cr>", desc = "Pause" },
			{ "<leader>de", "<cmd>lua require'dap'.disconnect()<cr>", desc = "Disconnect" },
			{ "<leader>dq", "<cmd>lua require'dap'.terminate()<cr>", desc = "Quit" },
		},
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dap.repl.close()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
		keys = {
			-- {
			-- 	"<leader>dv",
			-- 	"<cmd>lua local widgets=require'dap.ui.widgets'; widgets.centered_float(widgets.scopes)<CR>",
			-- 	desc = "Variables",
			-- },
			-- { "<leader>dx", "<cmd>lua require'dap.ui.widgets'.hover()<cr>", desc = "Examine" },
			{ "<leader>dU", "<cmd>lua require'dapui'.toggle()<cr>", desc = "Toggle UI" },
		},
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		config = function()
			require("mason-nvim-dap").setup({
				ensure_installed = {
					-- "python",   -- debugpy
					"delve", -- golang
					-- "codelldb", -- rust, c, c++
				},
			})
		end,
	},
	{
		"leoluz/nvim-dap-go",
		dpendencies = { "mfussenegger/nvim-dap" },
		config = function()
			require("dap-go").setup()
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("nvim-dap-virtual-text").setup()
		end,
	},
}
