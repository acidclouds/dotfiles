return {
	{
		"FabijanZulj/blame.nvim",
		lazy = false,
		config = function()
			require("blame").setup({
				blame_options = { "-w" },
				commit_detail_view = "split",
			})
		end,
	},
}
