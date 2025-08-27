return {
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonLog", "MasonUpdate" },
			opts = {
				ui = { border = "rounded" },
			},
		},
		opts = {
			ensure_installed = {
				-- LSPs
				"lua_ls",
				"ruff", -- Combined LSP/Linter/Formatter for Python
				"bashls",
				"eslint", -- JavaScript/TypeScript LSP/Linter
				"texlab",
				"gopls",

				-- Formatters
				"stylua", -- Lua
				"black", -- Python
				"isort", -- Python
				"prettier", -- JS/TS, Markdown
				-- "clang-format", -- C/C++
				-- "google-java-format", -- Java
				"shfmt", -- Shell scripts
				"latexindent", -- LaTeX

				-- Linters
				"ruff", -- Python
				"shellcheck", -- Shell scripts
				"luacheck", -- Lua
				"vale", -- latex, markdown

				"codespell", -- spell check
			},
		},
	},

	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local function on_attach(client, bufnr)
				local opts = { buffer = bufnr, noremap = true, silent = true }
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
			end

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			require("mason-lspconfig").setup({
				automatic_installation = false,
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({
							capabilities = capabilities,
							on_attach = on_attach,
						})
					end,
				},
				vim.diagnostic.config({
					virtual_text = {
						spacing = 4,
						prefix = "●",
						source = "if_many",
						update_in_insert = true,
					},
					signs = true,
					underline = true,
					update_in_insert = true,
					severity_sort = true,
					float = {
						focusable = false,
						style = "minimal",
						border = "rounded",
						source = "if_many",
						prefix = "",
						header = "",
					},
				}),
			})
		end,
	},

	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				c = { "clang-format" },
				java = { "google-java-format" },
				markdown = { "prettier" },
				bash = { "shfmt" },
				sh = { "shfmt" },
				tex = { "latexindent" },
				dart = { "dart_format" },
				["*"] = { "codespell" },
				["_"] = { "trim_whitespace" },
			},
			format_on_save = {
				timeout_ms = 5000,
				lsp_format = "fallback",
			},
			format_after_save = {
				lsp_format = "fallback",
			},
		},
		init = function()
			vim.api.nvim_create_user_command("Format", function(args)
				require("conform").format({ async = true, lsp_fallback = true, bufnr = args.bufnr })
			end, { range = true, bang = true })
		end,
	},

	{
		"mfussenegger/nvim-lint",
		event = {
			"BufWritePost",
			"BufReadPost",
			-- "InsertLeave",
		},
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			linters_by_ft = {
				python = { "ruff" },
				lua = { "luacheck" },
				sh = { "shellcheck" },
				bash = { "shellcheck" },
				javascript = { "eslint" },
				typescript = { "eslint" },
			},
			lint_on_events = {
				"BufWritePost",
				"BufReadPost",
				-- "InsertLeave",
			},
		},
		config = function(_, opts)
			local lint = require("lint")
			lint.linters_by_ft = opts.linters_by_ft

			local lint_augroup = vim.api.nvim_create_augroup("nvim-lint-autogroup", { clear = true })
			vim.api.nvim_create_autocmd(opts.lint_on_events, {
				group = lint_augroup,
				callback = function()
					vim.defer_fn(function()
						lint.try_lint()
					end, 100)
				end,
			})

			vim.api.nvim_create_user_command("Lint", function()
				lint.try_lint()
			end, {})
			-- vim.keymap.set("n", "<leader>li", "<cmd>Lint<cr>", { desc = "Run Linters" })
		end,
	},

	{
		"nvim-flutter/flutter-tools.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim",
		},
		config = function()
			require("flutter-tools").setup({
				lsp = {
					settings = {
						showtodos = true,
						completefunctioncalls = true,
						analysisexcludedfolders = {
							vim.fn.expand("$Home/.pub-cache"),
						},
						renamefileswithclasses = "prompt",
						updateimportsonrename = true,
						enablesnippets = false,
					},
				},
			})
		end,
	},
}
