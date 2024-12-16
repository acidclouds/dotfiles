return {
	"LhKipp/nvim-locationist",
	config = function()
		local locationist = require("locationist")

		locationist.setup({})

		-- vim.keymap.set("n", "<leader>ql", function()
		-- 	locationist.yank({ send_to = "llist", expand_str = "%:p" })
		-- end, { desc = "Yank current cursor to locationlist", noremap = true })

		vim.keymap.set("n", "<leader>ya", function()
			locationist.yank({ send_to = "clist", expand_str = "%:p", comment = "default" })
		end, { desc = "Yank current cursor to quickfixlist", noremap = true })

		-- vim.keymap.set("n", "<leader>qL", ":lopen<cr>", { desc = "Open Locationlist" })
		-- vim.keymap.set("n", "<leader>qQ", ":copen<cr>", { desc = "Open Quickfixlist" })
	end,
}
