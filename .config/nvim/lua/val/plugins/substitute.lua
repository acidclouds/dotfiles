return {
	"gbprod/substitute.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local substitute = require("substitute")

		substitute.setup()

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set(
			"n",
			"<leader>r",
			require("substitute.range").operator,
			{ desc = "Substitute with motion over range", noremap = true }
		)
		-- keymap.set("n", "ss", substitute.line, { desc = "Substitute line", noremap = true })
		-- keymap.set("n", "S", substitute.eol, { desc = "Substitute to end of line", noremap = true })
		-- keymap.set("x", "s", substitute.visual, { desc = "Substitute in visual mode", noremap = true })
	end,
}
