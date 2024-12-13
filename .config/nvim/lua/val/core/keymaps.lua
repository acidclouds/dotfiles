-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness
-- local wk = require("which-key")
-- -- General Keymaps -------------------

-- use jk to exit insert mode
keymap.set("n", "<leader>Q", "<cmd>qa!<CR>", { desc = "Quit all force" })
-- clear search highlights
keymap.set("n", "<leader>hc", ":nohl<CR>", { desc = "Clear search highlights" })
keymap.set("n", "<leader>|", "<C-w>v", { desc = "Split vertical" })
keymap.set("n", "<leader>_", "<C-w>s", { desc = "Split horizontal" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- wk.add({
-- 	{ "<leader>b", group = "+Buffers" },
-- 	{ "<leader>bn", "<cmd>enew<CR>", desc = "New buffer" },
-- 	{ "<leader>bd", "<cmd>bd<CR>", desc = "Delete buffer" },
-- 	{ "<leader>bl", "<cmd>bnext<CR>", desc = "Next buffer" },
-- 	{ "<leader>bh", "<cmd>bprev<CR>", desc = "Previous buffer" },
-- 	{ "<leader>c", group = "+Code" },
-- 	{ "<leader>d", group = "+Debug" },
-- 	{ "<leader>f", group = "+Find" },
-- 	{ "<leader>g", group = "+Git" },
-- 	{ "<leader>m", group = "+CMake" },
-- 	{ "<leader>x", group = "+Diagnostics" },
-- })
keymap.set("n", "L", "<cmd>bnext<CR>", { desc = "Next buffer" })
keymap.set("n", "H", "<cmd>bprev<CR>", { desc = "Previous buffer" })
keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
