return {
	"kevinhwang91/nvim-bqf",
	ft = "qf",
	config = function()
		require("bqf").setup({
			preview = {
				winblend = 0,
				auto_preview = false,
			},
			func_map = {
				pscrollup = "<C-u>",
				pscrolldown = "<C-d>",
			},
		})
	end,
}
