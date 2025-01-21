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
					section = "terminal",
					cmd = "ascii-image-converter ~/.config/max.png -c -C -H 25; sleep .1",
					height = 28,
					width = 61,
				},
				{ pane = 2, section = "keys", gap = 1, padding = 1 },
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
			input = {
				keys = {
					i_esc = { "<esc>", { "cmp_close", "cancel" }, mode = "i" },
					q = "cancel",
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
			"<leader>ys",
			function()
				local defname = vim.fn.system({ "git", "branch", "--show-current" })
				if vim.v.shell_error == 0 then
					defname = string.gsub(defname, "%s", "") .. ".txt"
				else
					defname = "todo.txt"
				end
				Snacks.input.input(
					{ prompt = "Save file to: " .. vim.fn.getcwd(), default = defname },
					function(response)
						if response then
							SaveClist(response)
						else
							Snacks.notify.warn("Did not save list to file")
						end
					end
				)
			end,
			desc = "Save ToDo list to file",
		},
		{
			"<leader>yl",
			function()
				local defname = vim.fn.system({ "git", "branch", "--show-current" })
				if vim.v.shell_error == 0 then
					defname = string.gsub(defname, "%s", "") .. ".txt"
				else
					defname = "todo.txt"
				end
				Snacks.input.input({ prompt = "Load from: " .. vim.fn.getcwd(), default = defname }, function(response)
					if response then
						LoadClist(response)
					else
						Snacks.notify.warn("Did not load list from file")
					end
				end)
			end,
			desc = "Load ToDo list from file",
		},
		{
			"<leader>hn",
			function()
				Snacks.notifier.show_history()
			end,
			desc = "Notification History",
		},
		{
			"<leader>ff",
			function()
				Snacks.picker.smart()
			end,
			desc = "Find files in CWD",
		},
		{
			"<leader>fr",
			function()
				Snacks.picker.resume()
			end,
			desc = "Resume last search",
		},
		{
			"<leader>fl",
			function()
				Snacks.picker.lines()
			end,
			desc = "Find string in current buffer",
		},
		{
			"<leader>fc",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "Find string under cursor in cwd",
		},
		{
			"<leader>fo",
			function()
				Snacks.picker.recent()
			end,
			desc = "Recent files",
		},
		{
			"<leader>fs",
			function()
				Snacks.picker.grep()
			end,
			desc = "Find string in cwd",
		},
		{
			"<leader>U",
			function()
				Snacks.picker.undo()
			end,
			desc = "Undo History",
		},
		{
			"<leader>yq",
			function()
				ToggleQf()
			end,
			desc = "Toggle Quickfix list window",
		},
	},
}
