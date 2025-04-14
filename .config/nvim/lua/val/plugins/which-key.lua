return {
	"folke/which-key.nvim",
	enabled = true,
	event = "VeryLazy",
	init = function()
		vim.o.timeout = false
		vim.o.timeoutlen = 300
	end,
	opts = {
		preset = "modern",
		spec = {
			{ "x", '"_x', mode = "n", hidden = true },
			{ "X", '"_X', mode = "n", hidden = true },
			{ "c", '"_c', mode = "n", hidden = true },
			{ "C", '"_C', mode = "n", hidden = true },
			{ "p", "P", mode = { "n", "v", "x" }, hidden = true },
			{ "<c-h>", "<cmd>TmuxNavigateLeft<cr>", hidden = true },
			{ "<c-j>", "<cmd>TmuxNavigateDown<cr>", mode = { "n", "v" }, hidden = true },
			{ "<c-k>", "<cmd>TmuxNavigateUp<cr>", mode = { "n", "v" }, hidden = true },
			{ "<c-l>", "<cmd>TmuxNavigateRight<cr>", hidden = true },
			{ "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>", hidden = true },
			{ "n", "nzz", mode = "n", hidden = true },
			{ "N", "Nzz", mode = "n", hidden = true },
			{ "<c-d>", "<c-d>zz", mode = "n", hidden = true },
			{ "<c-u>", "<c-u>zz", mode = "n", hidden = true },
			{ "<c-f>", "<c-f>zz", mode = "n", hidden = true },
			{ "<c-b>", "<c-b>zz", mode = "n", hidden = true },
			-- { "J", "<nop>", mode = "n", hidden = true },
			{ "gu", "<nop>", mode = "n", hidden = true },
			{ "gU", "<nop>", mode = "n", hidden = true },
			{ "Q", "q", mode = "n", hidden = true },
			{ "q", "<nop>", mode = "n", hidden = true },
			{ "<leader>J", "J", mode = "n", desc = "Join Lines" },
			{ "<leader>cU", "gU", mode = "n", desc = "Uppercase" },
			{ "<leader>cu", "gu", mode = "n", desc = "Lowercase" },
			{ "K", ":m '<-2<CR>gv=gv", mode = "v", desc = "Move lines up" },
			{ "J", ":m '>+1<CR>gv=gv", mode = "v", desc = "Move lines down" },
			{ "K", ":m .-2<CR>==", mode = "n", desc = "Move current line up" },
			{ "J", ":m .+1<CR>==", mode = "n", desc = "Move current line down" },
			{ "<leader>cU", "gU", mode = "n", desc = "Uppercase" },
			{ "<leader>f", group = "Find" },
			{ "<leader>g", group = "Git" },
			{ "<leader>l", group = "LSP" },
			{ "<leader>e", group = "File Explorer" },
			{ "<leader>c", group = "Change" },
			{ "<leader>s", group = "Split" },
			{ "<leader>h", group = "Highlights" },
			{ "<leader>y", group = "Quickfix" },
		},
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
}
