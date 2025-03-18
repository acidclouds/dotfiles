-- set leader key to space
vim.g.mapleader = " "

local function ltrim(s)
	return s:match("^%s*(.*)")
end

function SaveClist(filename)
	filename = filename == "" and "qflist.vim" or filename
	-- Get qflist
	local lflist = vim.api.nvim_cmd({ cmd = "clist" }, { output = true })
	local lines = {}
	for s in lflist:gmatch("[^\r\n]+") do
		table.insert(lines, ltrim(s))
	end
	local outlines = {}
	for _, line in ipairs(lines) do
		local _, j = string.find(line, " ")
		table.insert(outlines, string.sub(line, j + 1))
	end
	local f = io.open(filename, "w")
	if f ~= nil then
		f:write(table.concat(outlines, "\n"))
		f:close()
	end
end

function LoadClist(filename)
	filename = filename == "" and "qflist.vim" or filename
	vim.cmd.cfile(filename)
	vim.cmd.copen()
end

function GetVisualSelection()
	return vim.fn.getregion(vim.fn.getpos("."), vim.fn.getpos("v"), { type = vim.fn.mode() })
end

function ToggleQf()
	local qf_exists = false
	for _, win in pairs(vim.fn.getwininfo()) do
		if win["quickfix"] == 1 then
			qf_exists = true
		end
	end
	if qf_exists == true then
		vim.cmd("cclose")
		return
	end
	if not vim.tbl_isempty(vim.fn.getqflist()) then
		vim.cmd("copen")
	end
end

vim.api.nvim_exec(
	[[
augroup qf
    autocmd!
    autocmd FileType qf set nobuflisted
augroup END]],
	false
)

vim.api.nvim_create_autocmd({ "QuitPre" }, {
	callback = function(context)
		Snacks.bufdelete.all()
	end,
})

local keymap = vim.keymap -- for conciseness
-- local wk = require("which-key")
-- -- General Keymaps -------------------

-- use jk to exit insert mode
keymap.set("n", "<leader>Q", "<cmd>qa<CR>", { desc = "Quit all" })
-- clear search highlights
keymap.set("n", "<leader>hx", ":nohl<CR>", { desc = "Clear search highlights" })
keymap.set("n", "<leader>|", "<C-w>v", { desc = "Split vertical" })
keymap.set("n", "<leader>_", "<C-w>s", { desc = "Split horizontal" })
keymap.set("n", "gm", ":Man<CR>", { desc = "Open man page under cursor" })

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
keymap.set("i", "jj", "<esc>", {})
keymap.set("n", "<leader>gb", "<cmd>BlameToggle<CR>", { desc = "Toggle git blame" })
