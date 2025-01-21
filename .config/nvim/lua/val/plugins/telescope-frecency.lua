return {
	"prochri/telescope-all-recent.nvim",
	enabled = true,
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"kkharji/sqlite.lua",
		-- optional, if using telescope for vim.ui.select
		-- "stevearc/dressing.nvim"
	},
	opts = {
		-- pickers = {
		-- 	find_files = {
		-- 		disable = false,
		-- 		sorting = "recent",
		-- 	},
		-- },
		-- your config goes here
	},
}
