local colors = require("catppuccin.palettes.mocha")
return {
	"nvim-lualine/lualine.nvim",
	-- dependencies = { "nvim-tree/nvim-web-devicons" },
	dependencies = { "echasnovski/mini.icons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count
		local mocha = require("catppuccin.palettes").get_palette("mocha")
		require("mini.icons").setup()

		-- configure lualine with modified theme
		lualine.setup({
			options = {
				theme = "catppuccin",
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = {
					{ "mode", separator = { left = "" }, right_padding = 2 },
					{
						function()
							return require("noice").api.status.mode.get()
						end,
						cond = function()
							return package.loaded["noice"] and require("noice").api.status.mode.has()
						end,
					},
				},
				lualine_b = {
					{
						"branch",
						fmt = function(str)
							if #str > 20 then
								return str:sub(1, 20) .. ".."
							else
								return str
							end
						end,
						color = { bg = mocha.surface1 }, --"#45475a"
					},
					{ "filename", color = { bg = mocha.surface0 } }, -- "#313244"
				},
				lualine_c = {
					{
						function()
							return require("nvim-navic").get_location()
						end,
						cond = function()
							return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
						end,
					},
				},
				lualine_x = {
					-- {
					-- 	function()
					-- 		return require("noice").api.status.mode.get()
					-- 	end,
					-- 	cond = function()
					-- 		return package.loaded["noice"] and require("noice").api.status.mode.has()
					-- 	end,
					-- 	color = { fg = colors.flamingo, gui = "bold" },
					-- },
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
					},
					{ "filetype" },
				},
			},
		})
	end,
}
