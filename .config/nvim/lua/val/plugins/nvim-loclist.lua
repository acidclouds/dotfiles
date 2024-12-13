return {
	"LhKipp/nvim-locationist",
	config = function()
		local locationist = require("locationist")

		locationist.setup({})

		vim.keymap.set("n", "<leader>yl", function()
			locationist.yank({ send_to = "llist", expand_str = "%:p" })
		end, { desc = "Yank current cursor to locationlist", noremap = true })

		vim.keymap.set("n", "<leader>yq", function()
			locationist.yank({ send_to = "clist", expand_str = "%:p" })
		end, { desc = "Yank current cursor to quickfixlist", noremap = true })

		vim.keymap.set("n", "<leader>yL", ":lopen<cr>", { desc = "Open Locationlist" })
		vim.keymap.set("n", "<leader>yC", ":copen<cr>", { desc = "Open Quickfixlist" })
	end,
}
