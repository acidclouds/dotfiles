return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	enabled = false,
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- Set header
		dashboard.section.header.val = {
			"oooooo     oooo       .o.       ooooo        oooooooooooo ooooooooo.   ooooo ooooo     ooo  .oooooo..o",
			" `888.     .8'       .888.      `888'        `888'     `8 `888   `Y88. `888' `888'     `8' d8P'    `Y8",
			"  `888.   .8'       .8'888.      888          888          888   .d88'  888   888       8  Y88bo.     ",
			"   `888. .8'       .8' `888.     888          888oooo8     888ooo88P'   888   888       8   `'Y8888o. ",
			"    `888.8'       .88ooo8888.    888          888    '     888`88b.     888   888       8       `'Y88b",
			"     `888'       .8'     `888.   888       o  888       o  888  `88b.   888   `88.    .8'  oo     .d8P",
			"      `8'       o88o     o8888o o888ooooood8 o888ooooood8 o888o  o888o o888o    `YbodP'    8''88888P' ",
		}

		-- Set menu
		dashboard.section.buttons.val = {
			dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
			dashboard.button("SPC ee", "  > Toggle file explorer", "<cmd>NvimTreeToggle<CR>"),
			dashboard.button("SPC ff", "󰱼 > Find File", "<cmd>Telescope find_files<CR>"),
			dashboard.button("SPC fs", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
			dashboard.button("SPC wr", "󰁯  > Restore Session For Current Directory", "<cmd>SessionRestore<CR>"),
			dashboard.button("q", " > Quit NVIM", "<cmd>qa<CR>"),
		}

		-- Send config to alpha
		alpha.setup(dashboard.opts)

		-- Disable folding on alpha buffer
		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}
