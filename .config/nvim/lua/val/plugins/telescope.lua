return {
	"nvim-telescope/telescope.nvim",
	branch = "master",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"nvim-telescope/telescope-ui-select.nvim",
		"debugloop/telescope-undo.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local function copy_file_path()
			local entry = require("telescope.actions.state").get_selected_entry()
			local cb_opts = vim.opt.clipboard:get()
			if vim.tbl_contains(cb_opts, "unnamed") then
				vim.fn.setreg("*", entry.path)
			end
			if vim.tbl_contains(cb_opts, "unnamedplus") then
				vim.fn.setreg("+", entry.path)
			end
			vim.fn.setreg("", entry.path)
		end
		local function sudo_open()
			local entry = require("telescope.actions.state").get_selected_entry()
			print(entry.path)
			vim.api.nvim_command("e! " .. vim.fn.fnameescape("suda://" .. entry.path))
		end

		telescope.setup({
			defaults = {
				layout_strategy = "vertical",
				sorting_strategy = "ascending",
				layout_config = { height = 0.9 },
				path_display = { "smart" },
				dynamic_preview_title = true,
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
					},
					n = {
						["<C-k>"] = actions.preview_scrolling_up,
						["<C-j>"] = actions.preview_scrolling_down,
						["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
						["<C-l>"] = actions.preview_scrolling_right,
						["<C-h>"] = actions.preview_scrolling_left,
						["l"] = actions.results_scrolling_right,
						["h"] = actions.results_scrolling_left,
						["q"] = actions.close,
					},
				},
			},
			pickers = {
				find_files = {
					-- theme = "dropdown",
					find_command = { "fd", "--hidden", "--type", "f" }, -- "--strip-cwd-prefix" },
				},
			},
			extensions = {
				file_browser = {
					grouped = true,
					hidden = { file_browser = true, folder_browser = true },
					use_ui_input = true,
					mappings = {
						n = {
							["<C-y>"] = copy_file_path,
							["<C-o>"] = sudo_open,
						},
					},
				},
				["ui-select"] = {
					require("telescope.themes").get_dropdown({
						-- even more opts
					}),
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("file_browser")
		telescope.load_extension("ui-select")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		-- keymap.set("n", "<leader>ff", function()
		-- 	require("telescope.builtin").find_files({ results_title = vim.fn.getcwd() })
		-- end, { desc = "Fuzzy find files in cwd" })

		-- keymap.set("n", "<leader>fF", "<cmd>Telescope find_files cwd=~<cr>", { desc = "Fuzzy find files in ~" })
		keymap.set(
			"n",
			"<leader>fe",
			":Telescope file_browser path=%:p:h select_buffer=true initial_mode=normal<CR>",
			{ desc = "File Explorer" }
		)
		-- keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
		-- keymap.set(
		-- 	"n",
		-- 	"<leader>fl",
		-- 	"<cmd>Telescope lsp_workspace_symbols initial_mode=normal<cr>",
		-- 	{ desc = "Find current document LSP symbols in workspace" }
		-- )
		-- keymap.set(
		-- 	"n",
		-- 	"<leader>fL",
		-- 	"<cmd>Telescope lsp_dynamic_workspace_symbols initial_mode=normal<cr>",
		-- 	{ desc = "Find in all LSP sworkspace symbols" }
		-- )
		keymap.set(
			"n",
			"<leader>ft",
			"<cmd>Telescope treesitter initial_mode=normal<cr>",
			{ desc = "Find symbol in current buffer" }
		)
		-- keymap.set(
		-- 	"n",
		-- 	"<leader>fb",
		-- 	"<cmd>Telescope current_buffer_fuzzy_find<cr>",
		-- 	{ desc = "Find string in current buffer" }
		-- )
		-- keymap.set(
		-- 	"n",
		-- 	"<leader>fc",
		-- 	"<cmd>Telescope grep_string initial_mode=normal<cr>",
		-- 	{ desc = "Find string under cursor in cwd" }
		-- )
		-- keymap.set(
		-- 	"n",
		-- 	"<leader>fr",
		-- 	"<cmd>Telescope resume initial_mode=normal<cr>",
		-- 	{ desc = "Resume last Telescope search" }
		-- )
		-- keymap.set("n", "<leader>fo", ":Telescope oldfiles initial_mode=normal<CR>", { desc = "Recent Files" })
	end,
}
