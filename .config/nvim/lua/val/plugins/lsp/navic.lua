return {
	{
		"SmiteshP/nvim-navic",
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			require("nvim-navic").setup({
				highlight = true,
				lsp = {
					auto_attach = true,
					preference = nil,
				},
			})
		end,
	},
}
