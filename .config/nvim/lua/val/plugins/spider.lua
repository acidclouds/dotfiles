return {
	{
		"chrisgrieser/nvim-spider",
		enabled = false,
		keys = {
			{
				"e",
				"<cmd>lua require('spider').motion('e')<CR>",
				mode = { "n", "o", "x" },
			},
			{
				"w",
				function()
					require("spider").motion("w")
				end,
				mode = { "n", "o", "x" },
			},
			{
				"b",
				function()
					require("spider").motion("b")
				end,
				mode = { "n", "o", "x" },
			},
		},
	},
}
