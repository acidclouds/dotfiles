return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		config = function()
			require("noice").setup({
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
					},
				},
				-- you can enable a preset for easier configuration
				presets = {
					bottom_search = true, -- use a classic bottom cmdline for search
					-- command_palette = true, -- position the cmdline and popupmenu together
					command_palette = {
						views = {
							cmdline_popup = {
								position = {
									row = 30,
									col = "50%",
								},
								size = {
									min_width = 60,
									width = "auto",
									height = "auto",
								},
							},
							cmdline_popupmenu = {
								relative = "editor",
								position = {
									row = 33,
									col = "50%",
								},
								size = {
									width = 60,
									height = "auto",
									max_height = 15,
								},
								border = {
									style = "rounded",
									padding = { 0, 1 },
								},
								win_options = {
									winhighlight = { Normal = "Normal", FloatBorder = "NoiceCmdlinePopupBorder" },
								},
							},
						},
					},
					-- long_message_to_split = true, -- long messages will be sent to a split
					-- inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = true, -- add a border to hover docs and signature help
				},
				views = {
					mini = {
						border = {
							style = "rounded",
						},
					},
				},
			})
		end,
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
		keys = {
			{
				"<leader>hd",
				"<cmd>NoiceDismiss<CR>",
				desc = "Dismiss notification",
			},
		},
	},
}
