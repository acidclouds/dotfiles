return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		terminal = {
			-- your terminal configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			-- win = { style = "terminal" },
			win = {
				-- position = "float",
				style = "terminal",
				border = "rounded",
			},
			enabled = true,
		},
		bigfile = { enabled = true },
		dashboard = {
			enabled = true,
			sections = {
				{ section = "header" },
				{
					pane = 2,
					section = "terminal",
					cmd = "ascii-image-converter ~/.config/max.png -c -C -H 40",
					-- cmd = "chafa ~/.config/india.jpg --format symbols --symbols vhalf --size 60x20 --stretch; sleep .1",
					height = 40,
					-- width = 60,
					padding = 1,
				},
				{ section = "keys", gap = 1, padding = 1 },
				{ pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
				{ pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
				{
					pane = 2,
					icon = " ",
					title = "Git Status",
					section = "terminal",
					enabled = function()
						return Snacks.git.get_root() ~= nil
					end,
					cmd = "hub status --short --branch --renames",
					height = 5,
					padding = 1,
					ttl = 5 * 60,
					indent = 3,
				},
				{ section = "startup" },
			},
		},
		indent = { enabled = true, indent = { char = "┊" }, scope = { char = "┊" } },
		input = { enabled = true },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		toggle = {
			enabled = true,
			map = vim.keymap.set, -- keymap.set function to use
			which_key = true, -- integrate with which-key to show enabled/disabled icons and colors
			notify = true, -- show a notification when toggling
			-- icons for enabled/disabled states
			icon = {
				enabled = " ",
				disabled = " ",
			},
			-- colors for enabled/disabled states
			color = {
				enabled = "green",
				disabled = "yellow",
			},
		},
		scroll = { enabled = true },
		win = { enabled = true },
		words = { enabled = true },
		styles = {
			lazygit = {
				height = 0.8,
			},
			notification = {
				wo = {
					wrap = true,
				},
			},
			terminal = {
				bo = {
					filetype = "snacks_terminal",
				},
				height = 0.2,
				wo = {},
				keys = {
					q = "hide",
					gf = function(self)
						local f = vim.fn.findfile(vim.fn.expand("<cfile>"), "**")
						if f == "" then
							Snacks.notify.warn("No file under cursor")
						else
							self:hide()
							vim.schedule(function()
								vim.cmd("e " .. f)
							end)
						end
					end,
					term_normal = {
						"<esc>",
						function(self)
							-- self.esc_timer = self.esc_timer or (vim.uv or vim.loop).new_timer()
							-- if self.esc_timer:is_active() then
							-- 	self.esc_timer:stop()
							-- 	vim.cmd("stopinsert")
							-- else
							-- 	self.esc_timer:start(200, 0, function() end)
							-- 	return "<esc>"
							-- end
							vim.cmd("stopinsert")
						end,
						mode = "t",
						expr = true,
						desc = "Double escape to normal mode",
					},
				},
			},
			win = {
				split = {
					position = "bottom",
					height = 0.2,
					border = "rounded",
				},
			},
		},
	},
	keys = {
		{
			"<leader>.",
			function()
				Snacks.scratch()
			end,
			desc = "Toggle Scratch Buffer",
		},
		{
			"<leader>bd",
			function()
				Snacks.bufdelete()
			end,
			desc = "Delete Buffer",
		},
		{
			"<leader>gg",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit",
		},
		{
			"<leader>gl",
			function()
				Snacks.lazygit.log()
			end,
			desc = "Lazygit Log (cwd)",
		},
		{
			"<leader>hd",
			function()
				Snacks.notifier.hide()
			end,
			desc = "Dismiss All Notifications",
		},
		{
			"<leader>T",
			function()
				Snacks.terminal()
			end,
			desc = "Toggle Terminal",
		},
		{
			"]]",
			function()
				Snacks.words.jump(vim.v.count1)
			end,
			desc = "Next Reference",
			mode = { "n", "t" },
		},
		{
			"[[",
			function()
				Snacks.words.jump(-vim.v.count1)
			end,
			desc = "Prev Reference",
			mode = { "n", "t" },
		},
		{
			"<leader>qs",
			function()
				Snacks.input.input({ prompt = "Enter ToDo list file name to save" }, function(response)
					Sllist(response)
				end)
			end,
			desc = "Save ToDo list to file",
		},
		{
			"<leader>qg",
			function()
				Snacks.input.input({ prompt = "Enter ToDo list file name to load" }, function(response)
					Lllist(response)
				end)
			end,
			desc = "Save ToDo list to file",
		},
	},
}
