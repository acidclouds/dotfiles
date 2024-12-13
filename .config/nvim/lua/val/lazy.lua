local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ { import = "val.plugins" }, { import = "val.plugins.lsp" } }, {
	checker = {
		enabled = true,
		notify = false,
	},
	ui = {
		border = "rounded",
		size = {
			width = 0.8,
			height = 0.8,
		},
	},
	change_detection = {
		notify = false,
	},
})
