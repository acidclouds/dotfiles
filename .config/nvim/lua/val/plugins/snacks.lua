return {
	"acidclouds/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		scratch = {
			ft = "text",
		},
		picker = {
			win = {
				input = {
					keys = {
						["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
						["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
						["<c-h>"] = { "preview_scroll_left", mode = { "i", "n" } },
						["<c-l>"] = { "preview_scroll_right", mode = { "i", "n" } },
						["h"] = { "list_scroll_left", mode = { "n" } },
						["l"] = { "list_scroll_right", mode = { "n" } },
					},
				},
				list = {
					keys = {
						["<c-u>"] = "preview_scroll_up",
						["<c-d>"] = "preview_scroll_down",
						["<c-h>"] = "preview_scroll_left",
						["<c-l>"] = "preview_scroll_right",
					},
				},
				preview = {
					keys = {
						["<c-u>"] = "preview_scroll_up",
						["<c-d>"] = "preview_scroll_down",
						["<c-h>"] = "preview_scroll_left",
						["<c-l>"] = "preview_scroll_right",
					},
				},
			},
		},
		terminal = {
			-- your terminal configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			win = { style = "terminal" },
			-- win = {
			-- 	-- position = "float",
			-- 	style = "terminal",
			-- 	border = "rounded",
			-- },
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
					-- align = "right",
				},
				{ pane = 1, section = "keys", gap = 1, padding = 1 },
				{ pane = 1, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
				{ pane = 1, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
				{
					pane = 1,
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
		image = { enabled = true },
		indent = {
			enabled = true,
			indent = {
				char = "┊",
				hl = {
					"NeoTreeIndentMarker",
					-- "SnacksIndent1",
					-- "SnacksIndent2",
					-- "SnacksIndent3",
					-- "SnacksIndent4",
					-- "SnacksIndent5",
					-- "SnacksIndent6",
					-- "SnacksIndent7",
					-- "SnacksIndent8",
				},
			},
			scope = { char = "┊" },
		},
		input = { enabled = true },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		-- statuscolumn = { enabled = true },
		explorer = { enabled = false },
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
				width = 0.95,
				border = "rounded",
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
				row = 37,
			},
			terminal = {
				bo = {
					filetype = "snacks_terminal",
				},
				height = 0.25,
				wo = {},
				keys = {
					q = "hide",
					gf = function(self)
						local f = vim.fn.findfile(vim.fn.expand("<cfile>"), "**")
						if f == "" then
							Snacks.notify.warn("No file under cursor")
						else
							-- self:hide()
							vim.schedule(function()
								vim.cmd("e " .. f)
							end)
						end
					end,
					term_normal = {
						"j",
						function(self)
							self.esc_timer = self.esc_timer or (vim.uv or vim.loop).new_timer()
							if self.esc_timer:is_active() then
								self.esc_timer:stop()
								vim.cmd("stopinsert")
								return "<BS>"
							else
								self.esc_timer:start(200, 0, function() end)
								return "j"
							end
							-- vim.cmd("stopinsert")
						end,
						mode = "t",
						expr = true,
						desc = "Double j to normal mode",
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
			"<leader>f.",
			function()
				Snacks.picker.scratch({
					on_show = function()
						vim.cmd.stopinsert()
					end,
					win = {
						input = {
							keys = {
								["<c-n>"] = {
									function(picker)
										picker:close()
										Snacks.input.input({
											prompt = "Name your new scratchpad (cancelling will open default)",
											default = "",
										}, function(response)
											if response then
												Snacks.scratch.open({ name = response })
											else
												Snacks.scratch.open()
											end
										end)
									end,
									mode = { "n", "i" },
								},
							},
						},
					},
				})
			end,
			desc = "Select Scratch Buffers",
		},
		{
			"<leader>.",
			function()
				Snacks.scratch()
			end,
			desc = "Open scratchpad",
		},
		{
			"<leader>fk",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "Keymaps",
		},
		{
			"<leader>fv",
			":Telescope vim_options<CR>",
			desc = "VIM options",
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
			desc = "LazyGit",
		},
		{
			"<leader>gl",
			function()
				Snacks.lazygit.log()
			end,
			desc = "Lazygit Log (cwd)",
		},
		{
			"<leader>gL",
			function()
				Snacks.picker.git_log_line()
			end,
			desc = "Git log current line",
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
			"<leader>x",
			function()
				local window = Snacks.terminal.get(nil, { start_insert = false, win = { enter = false } })
				vim.fn.chansend(vim.bo[window.buf].channel, vim.api.nvim_get_current_line() .. "\n")
			end,
			desc = "Execute current line in terminal",
			mode = { "n" },
		},
		{
			"<leader>x",
			function()
				local visual_selection = GetVisualSelection()
				local window = Snacks.terminal.get(nil, { start_insert = false, win = { enter = false } })
				for _, ln in ipairs(visual_selection) do
					vim.fn.chansend(vim.bo[window.buf].channel, ln .. "\n")
				end
			end,
			desc = "Execute selection in terminal",
			mode = { "v" },
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
			desc = "Save ToDo List to File",
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
			desc = "Load ToDo List from File",
		},
		{
			"<leader>hc",
			function()
				Snacks.picker.command_history()
			end,
			desc = "Commands History",
		},
		{
			"<leader>hn",
			function()
				Snacks.picker.notifications()
			end,
			desc = "Notification History",
		},
		{
			"<leader>ff",
			function()
				Snacks.picker.smart({
					hidden = true,
					ignored = true,
					title = vim.fn.getcwd(),
				})
			end,
			desc = "Find Files in CWD",
		},
		{
			"<leader>gc",
			function()
				Snacks.terminal.open("git show " .. vim.fn.expand("<cword>"), { win = { height = 0.8 } })
			end,
			desc = "Show git commit",
		},
		{
			"<leader>fh",
			function()
				Snacks.picker.help()
			end,
			desc = "Help Pages",
		},
		{
			"<leader>fm",
			function()
				Snacks.picker.man()
			end,
			desc = "Man Pages",
		},
		{
			"<leader>fr",
			function()
				Snacks.picker.resume()
			end,
			desc = "Resume Last Search",
		},
		{
			"<leader>fl",
			function()
				Snacks.picker.lines()
			end,
			desc = "Find String in Current Buffer",
		},
		{
			"<leader>fc",
			function()
				Snacks.picker.grep_word({
					hidden = true,
					ignored = true,
					title = vim.fn.getcwd(),
					on_show = function()
						vim.cmd.stopinsert()
					end,
				})
			end,
			desc = "Find String under Cursor in CWD",
		},
		{
			"<leader>fo",
			function()
				Snacks.picker.recent({
					on_show = function()
						vim.cmd.stopinsert()
					end,
				})
			end,
			desc = "Recent files",
		},
		{
			"<leader>fs",
			function()
				Snacks.picker.grep({
					hidden = true,
					ignored = true,
					title = vim.fn.getcwd(),
				})
			end,
			desc = "Find String in CWD",
		},
		{
			"<leader>U",
			function()
				Snacks.picker.undo({
					on_show = function()
						vim.cmd.stopinsert()
					end,
				})
			end,
			desc = "Undo History",
		},
		{
			"<leader>yq",
			function()
				ToggleQf()
			end,
			desc = "Toggle Quickfix List Window",
		},
		{
			"<leader>ld",
			function()
				Snacks.picker.lsp_definitions()
			end,
			desc = "Goto Definition",
		},
		{
			"<leader>lD",
			function()
				Snacks.picker.lsp_declarations()
			end,
			desc = "Goto Declaration",
		},
		{
			"<leader>lr",
			function()
				Snacks.picker.lsp_references()
			end,
			nowait = true,
			desc = "References",
		},
		{
			"<leader>li",
			function()
				Snacks.picker.lsp_implementations()
			end,
			desc = "Goto Implementation",
		},
		{
			"<leader>la",
			function()
				vim.lsp.buf.code_action()
			end,
			desc = "See available code actions",
		},
		{
			"<leader>D",
			function()
				vim.diagnostic.open_float({ border = "rounded" })
			end,
			desc = "Show line diagnostics",
		},
		{
			"<leader>cr",
			function()
				vim.lsp.buf.rename()
			end,
			desc = "Smart Rename",
		},
		{
			"D",
			function()
				vim.lsp.buf.hover()
			end,
			desc = "Show documentation for what is under cursor",
		},
		{
			"<leader>lt",
			function()
				Snacks.picker.lsp_type_definitions()
			end,
			desc = "Goto Type Definition",
		},
		{
			"<leader>ls",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "LSP Symbols",
		},
		{
			"<leader>W",
			function()
				Snacks.dashboard()
			end,
			desc = "Welcome Screen",
		},
		{
			"<leader>lS",
			function()
				Snacks.picker.lsp_workspace_symbols()
			end,
			desc = "LSP Workspace Symbols",
		},
		{
			"<leader>fd",
			function()
				Snacks.picker.diagnostics_buffer()
			end,
			desc = "Diagnostics",
		},
		{
			"<leader>um",
			function()
				require("render-markdown").toggle()
			end,
			desc = "Toggle Render Markdown",
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				-- Setup some globals for debugging (lazy-loaded)
				_G.dd = function(...)
					Snacks.debug.inspect(...)
				end
				_G.bt = function()
					Snacks.debug.backtrace()
				end
				vim.print = _G.dd -- Override print to use snacks for `:=` command

				-- Create some toggle mappings
				Snacks.toggle.animate():map("<leader>ua")
				Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
				Snacks.toggle.option("list", { name = "󱁐 List (Visible Whitespace)" }):map("<leader>ul")
				Snacks.toggle
					.new({
						id = "format_on_save",
						name = "󰊄 Format on Save (global)",
						get = function()
							return not vim.g.disable_autoformat
						end,
						set = function(state)
							vim.g.disable_autoformat = not state
						end,
					})
					:map("<leader>uf")
				Snacks.toggle
					.new({
						id = "format_on_save_buffer",
						name = "󰊄 Format on Save (buffer)",
						get = function()
							return not vim.b.disable_autoformat
						end,
						set = function(state)
							vim.b.disable_autoformat = not state
						end,
					})
					:map("<leader>uF")
			end,
		})
	end,
}
