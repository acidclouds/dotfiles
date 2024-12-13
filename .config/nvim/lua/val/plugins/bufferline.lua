return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = { "nvim-tree/nvim-web-devicons", "folke/snacks.nvim" },
		config = function()
			require("bufferline").setup({
				options = {
					numbers = "none",
					close_command = require("snacks").bufdelete.delete, --"bdelete! %d",
					right_mouse_command = require("snacks").bufdelete.delete, --""bdelete! %d",
					middle_mouse_command = require("snacks").bufdelete.delete, --""bdelete! %d",
					offsets = {
						{
							filetype = "NvimTree",
							text = "File Explorer",
							separator = true,
							highlight = "Directory",
							text_align = "left",
						},
					},
					show_tab_indicators = true,
					show_close_icon = false,
					diagnostics = "nvim_lsp",
					diagnostics_indicator = function(count, level, diagnostics_dict, context)
						return "(" .. count .. ")"
					end,
					-- custom_filter = function(buf_number)
					-- 	if vim.bo[buf_number].filetype ~= "NvimTree" then
					-- 		return true
					-- 	end
					-- end,
				},
			})
		end,
	},
}
