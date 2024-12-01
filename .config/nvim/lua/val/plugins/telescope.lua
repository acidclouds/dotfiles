return {
	"nvim-telescope/telescope.nvim",
	branch = "master",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				layout_strategy = "vertical",
				sorting_strategy = "ascending",
				layout_config = { height = 0.9 },
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
					n = {
						["<C-k>"] = actions.preview_scrolling_up,
						["<C-j>"] = actions.preview_scrolling_down,
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						["<C-l>"] = actions.preview_scrolling_right,
						["<C-h>"] = actions.preview_scrolling_left,
						["l"] = actions.results_scrolling_right,
						["h"] = actions.results_scrolling_left,
					},
				},
			},
			extensions = {
				file_browser = {
					grouped = true,
					hidden = { file_browser = true, folder_browser = true },
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("file_browser")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
		keymap.set(
			"n",
			"<leader>fe",
			":Telescope file_browser path=%:p:h select_buffer=true<CR>",
			{ desc = "File Explorer" }
		)
		keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
		keymap.set(
			"n",
			"<leader>fl",
			"<cmd>Telescope lsp_workspace_symbols<cr>",
			{ desc = "Find current document LSP symbols in workspace" }
		)
		keymap.set(
			"n",
			"<leader>fL",
			"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
			{ desc = "Find in all LSP sworkspace symbols" }
		)
		keymap.set("n", "<leader>ft", "<cmd>Telescope treesitter<cr>", { desc = "Find symbol in current buffer" })
		keymap.set(
			"n",
			"<leader>fb",
			"<cmd>Telescope current_buffer_fuzzy_find<cr>",
			{ desc = "Find string in current buffer" }
		)
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
	end,
}
