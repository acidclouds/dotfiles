return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	opts = {
		preset = "modern",
		spec = {
			{ "x", '"_x', mode = "n", hidden = true },
			{ "X", '"_X', mode = "n", hidden = true },
			{ "c", '"_c', mode = "n", hidden = true },
			{ "C", '"_C', mode = "n", hidden = true },
			{ "<c-h>", "<cmd>TmuxNavigateLeft<cr>", hidden = true },
			{ "<c-j>", "<cmd>TmuxNavigateDown<cr>", hidden = true },
			{ "<c-k>", "<cmd>TmuxNavigateUp<cr>", hidden = true },
			{ "<c-l>", "<cmd>TmuxNavigateRight<cr>", hidden = true },
			{ "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>", hidden = true },
			{ "n", "nzz", mode = "n", hidden = true },
			{ "N", "Nzz", mode = "n", hidden = true },
			{ "J", "<nop>", mode = "n", hidden = true },
			{ "gu", "<nop>", mode = "n", hidden = true },
			{ "gU", "<nop>", mode = "n", hidden = true },
			{ "<leader>J", "J", mode = "n", desc = "Join Lines" },
			{ "<leader>cU", "gU", mode = "n", desc = "Uppercase" },
			{ "<leader>cu", "gu", mode = "n", desc = "Lowercase" },
			{ "<leader>f", group = "Find" },
			{ "<leader>l", group = "LSP" },
			{ "<leader>e", group = "File Explorer" },
			{ "<leader>c", group = "Change" },
			{ "<leader>s", group = "Split" },
			{ "<leader>h", group = "Highlights" },
		},
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
}
