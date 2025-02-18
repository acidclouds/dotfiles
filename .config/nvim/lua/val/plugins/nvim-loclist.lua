return {
	"LhKipp/nvim-locationist",
	config = function()
		local locationist = require("locationist")

		locationist.setup({})

		-- vim.keymap.set("n", "<leader>ql", function()
		-- 	locationist.yank({ send_to = "llist", expand_str = "%:p" })
		-- end, { desc = "Yank current cursor to locationlist", noremap = true })

		vim.keymap.set({ "n", "v" }, "<leader>ya", function()
			Snacks.input.input({ prompt = "Comment: " }, function(response)
				if response then
					local commentStr = response
					locationist.yank({
						send_to = "clist",
						expand_str = "%:p",
						comment = function()
							return commentStr
						end,
					})
				end
			end)
			-- locationist.yank({
			-- 	send_to = "clist",
			-- 	expand_str = "%:p",
			-- 	comment = function()
			-- 		local input_comment = vim.fn.input("Comment: ")
			--
			-- 		return input_comment
			-- 	end,
			-- })
		end, { desc = "Yank current cursor to quickfixlist", noremap = true })
		vim.keymap.set({ "n", "v" }, "<leader>yA", function()
			locationist.yank({
				send_to = "clist",
				expand_str = "%:p",
				comment = function()
					return vim.fn.getline(".")
				end,
			})
		end, { desc = "Yank current cursor to quickfixlist, text as description", noremap = true })

		-- vim.keymap.set("n", "<leader>qL", ":lopen<cr>", { desc = "Open Locationlist" })
		-- vim.keymap.set("n", "<leader>qQ", ":copen<cr>", { desc = "Open Quickfixlist" })
	end,
}
