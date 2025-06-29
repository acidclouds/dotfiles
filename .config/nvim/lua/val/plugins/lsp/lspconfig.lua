return {
	"neovim/nvim-lspconfig",
	enabled = false,
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		-- "hrsh7th/cmp-nvim-lsp",
		-- { "antosha417/nvim-lsp-file-operations", config = true },
		-- { "folke/neodev.nvim", opts = {} },
	},
	opts = {
		ui = {
			windows = {
				default_options = {
					border = "rounded",
				},
			},
		},
	},
	config = function()
		-- import lspconfig plugin
		-- local lspconfig = require("lspconfig")
		-- local win = require("lspconfig.ui.windows")
		-- local _default_opts = win.default_opts
		--
		-- win.default_opts = function(options)
		-- 	local opts = _default_opts(options)
		-- 	opts.border = "rounded"
		-- 	return opts
		-- end

		-- import mason_lspconfig plugin
		-- local mason_lspconfig = require("mason-lspconfig")

		-- import cmp-nvim-lsp plugin
		-- local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- local keymap = vim.keymap -- for conciseness

		-- vim.api.nvim_create_autocmd("LspAttach", {
		-- 	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
		-- 	callback = function(ev)
		-- 		-- Buffer local mappings.
		-- 		-- See `:help vim.lsp.*` for documentation on any of the below functions
		-- 		local opts = { buffer = ev.buf, silent = true }
		--
		-- 		-- set keybinds
		-- 		-- opts.desc = "Show LSP references"
		-- 		-- keymap.set("n", "<leader>lr", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references
		--
		-- 		opts.desc = "Go to declaration"
		-- 		keymap.set("n", "<leader>lD", vim.lsp.buf.declaration, opts) -- go to declaration
		--
		-- 		--     opts.desc = "Show LSP definitions"
		-- 		-- keymap.set("n", "<leader>ld", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions
		-- 		--
		-- 		-- opts.desc = "Show LSP implementations"
		-- 		-- keymap.set("n", "<leader>li", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations
		-- 		--
		-- 		-- opts.desc = "Show LSP type definitions"
		-- 		-- keymap.set("n", "<leader>lt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions
		--
		-- 		opts.desc = "See available code actions"
		-- 		keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection
		--
		-- 		opts.desc = "Smart rename"
		-- 		keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts) -- smart rename
		--
		-- 		-- opts.desc = "Show buffer diagnostics"
		-- 		-- keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file
		--
		-- 		opts.desc = "Show line diagnostics"
		-- 		keymap.set("n", "<leader>D", function()
		-- 			vim.diagnostic.open_float({ border = "rounded" })
		-- 		end, opts) -- show diagnostics for line
		--
		-- 		opts.desc = "Go to previous diagnostic"
		-- 		keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer
		--
		-- 		opts.desc = "Go to next diagnostic"
		-- 		keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer
		--
		-- 		opts.desc = "Show documentation for what is under cursor"
		-- 		keymap.set("n", "D", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor
		--
		-- 		opts.desc = "Restart LSP"
		-- 		keymap.set("n", "<leader>lR", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
		-- 	end,
		-- })
		--
		-- used to enable autocompletion (assign to every lsp server config)
		-- local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		-- local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		-- for type, icon in pairs(signs) do
		-- 	local hl = "DiagnosticSign" .. type
		-- 	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		-- end
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
				texthl = {
					[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
					[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
					[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
					[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
				},
			},
			virtual_text = true,
		})

		vim.lsp.config("*", {
			-- capabilities = capabilities,
			single_file_support = true,
			border = "rounded",
		})

		vim.lsp.config("lua_ls", {
			on_init = function(client)
				if client.workspace_folders then
					local path = client.workspace_folders[1].name
					if
						path ~= vim.fn.stdpath("config")
						and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
					then
						return
					end
				end

				client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
					runtime = {
						-- Tell the language server which version of Lua you're using (most
						-- likely LuaJIT in the case of Neovim)
						version = "LuaJIT",
						-- Tell the language server how to find Lua modules same way as Neovim
						-- (see `:h lua-module-load`)
						path = {
							"lua/?.lua",
							"lua/?/init.lua",
						},
					},
					-- Make the server aware of Neovim runtime files
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME,
							-- Depending on the usage, you might want to add additional paths
							-- here.
							-- '${3rd}/luv/library'
							-- '${3rd}/busted/library'
						},
						-- Or pull in all of 'runtimepath'.
						-- NOTE: this is a lot slower and will cause issues when working on
						-- your own configuration.
						-- See https://github.com/neovim/nvim-lspconfig/issues/3189
						-- library = {
						--   vim.api.nvim_get_runtime_file('', true),
						-- }
					},
				})
			end,
			settings = {
				Lua = {
					-- make the language server recognize "vim" global
					diagnostics = {
						globals = { "vim" },
					},
					completion = {
						callSnippet = "Replace",
					},
				},
			},
		})
		vim.lsp.enable({ "lua_ls", "pyright", "clangd" })
		-- vim.lsp.enable("clangd")

		-- mason_lspconfig.setup_handlers({
		-- 	-- default handler for installed servers
		-- 	function(server_name)
		-- 		lspconfig[server_name].setup({
		-- 			capabilities = capabilities,
		-- 			single_file_support = true,
		-- 			border = "rounded",
		-- 		})
		-- 	end,
		-- 	["java_language_server"] = function()
		-- 		-- configure lua server (with special settings)
		-- 		lspconfig["java_language_server"].setup({
		-- 			capabilities = capabilities,
		-- 			single_file_support = true,
		-- 			handlers = {
		-- 				["client/registerCapability"] = function(err, result, ctx, config)
		-- 					local registration = {
		-- 						registrations = { result },
		-- 					}
		-- 					return vim.lsp.handlers["client/registerCapability"](err, registration, ctx, config)
		-- 				end,
		-- 			},
		-- 		})
		-- 	end,
		-- 	["lua_ls"] = function()
		-- 		-- configure lua server (with special settings)
		-- 		lspconfig["lua_ls"].setup({
		-- 			capabilities = capabilities,
		-- 			settings = {
		-- 				Lua = {
		-- 					-- make the language server recognize "vim" global
		-- 					diagnostics = {
		-- 						globals = { "vim" },
		-- 					},
		-- 					completion = {
		-- 						callSnippet = "Replace",
		-- 					},
		-- 				},
		-- 			},
		-- 		})
		-- 	end,
		-- })
	end,
}
