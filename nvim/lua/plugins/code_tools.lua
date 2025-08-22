-- lua/plugins/code_tools.lua
-- Centralized configuration for Mason, LSP, Formatting, and Linting
-- Uses mason-tool-installer to manage tool installations.

return {
	-- Tool Installer (Core Mason)

	-- Automatic Tool Installation Manager
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonLog", "MasonUpdate" },
			opts = {
				ui = { border = "rounded" },
				-- Note: ensure_installed is NOT configured here directly.
				-- It's handled by mason-tool-installer.nvim
			},
			-- config = function(_, opts)
			--   require("mason").setup(opts)
			-- end,
		},
		opts = {
			-- Central list of ALL tools to ensure are installed by Mason
			ensure_installed = {
				-- LSPs
				"lua_ls",
				"ruff", -- Combined LSP/Linter/Formatter for Python
				-- "pyright",         -- Alternative Python LSP (commented out, choose one)
				"bashls",
				"eslint", -- JavaScript/TypeScript LSP/Linter
				-- "vtsls", -- JavaScript/TypeScript LSP/Linter
				"texlab",
				"gopls",

				-- Formatters (used by conform.nvim)
				"stylua", -- Lua
				"black", -- Python
				"isort", -- Python import sorting
				"prettier", -- JS/TS, Markdown, etc.
				"clang-format", -- C/C++
				"google-java-format", -- Java
				"shfmt", -- Shell scripts
				"latexindent", -- LaTeX

				-- Linters (used by nvim-lint)
				"ruff", -- Python (can be used alongside ruff_lsp or standalone)
				"shellcheck", -- Shell scripts
				"luacheck", -- Lua
				"vale", -- latex, markdown
				-- eslint is already listed (covers JS/TS linting)
				-- markdownlint-cli is already listed
			},
			-- Optional: Run Mason tool installer automatically on startup
			-- run_on_start = true, -- default is true
			-- Optional: Auto update tools (can be slow on startup)
			-- auto_update = false,
		},
		-- No specific config function needed usually, it hooks into Mason
	},

	-- LSP Configuration (+ Mason integration)
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" }, -- Trigger LSP setup early
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp", -- Ensure cmp support is loaded
			-- mason-tool-installer is implicitly a dependency via mason
		},
		config = function()
			-- on_attach function (same as before)
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
				-- Add any client-specific attach logic if needed
			end

			-- Get capabilities from cmp-nvim-lsp
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Use mason-lspconfig to bridge Mason installed LSPs with nvim-lspconfig
			require("mason-lspconfig").setup({
				-- This plugin NO LONGER needs ensure_installed.
				-- mason-tool-installer handles the actual installation.
				-- We just need to tell mason-lspconfig HOW to set up the servers.
				automatic_installation = false, -- Set to false, as mason-tool-installer handles it.
				-- Can be true, but it's redundant effort.
				handlers = {
					-- Default handler: Sets up servers found by Mason with capabilities and on_attach
					function(server_name)
						require("lspconfig")[server_name].setup({
							capabilities = capabilities,
							on_attach = on_attach,
						})
					end,
				},
				vim.diagnostic.config({
					virtual_text = {
						spacing = 4, -- Add some spacing
						prefix = "●", -- Or '▎', '‣', etc.
						source = "if_many", -- Show source only if multiple sources exist for the same diagnostic
						update_in_insert = true, -- THIS IS KEY for seeing messages in insert mode
					},
					signs = true, -- You already see these, but good to be explicit
					underline = true,
					update_in_insert = true, -- General update flag, also important
					severity_sort = true, -- Show errors before warnings, etc.
					float = { -- Configuration for vim.diagnostic.open_float()
						focusable = false,
						style = "minimal",
						border = "rounded",
						source = "if_many",
						prefix = "", -- No prefix for floats
						header = "", -- No header for floats
					},
				}),
			})
		end,
		opts = function()
			require("lspconfig").dartls.setup({
				cmd = { "dart", "language-server", "--protocol=lsp" },
			})
		end,
	},

	-- Formatter Configuration (conform.nvim)
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		dependencies = { "williamboman/mason.nvim" }, -- Depends on Mason providing the tools
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				-- javascript = { "prettier" },
				-- typescript = { "prettier" },
				c = { "clang-format" },
				java = { "google-java-format" },
				markdown = { "prettier" }, -- Can also use "markdownlint-cli" if preferred/configured
				bash = { "shfmt" },
				sh = { "shfmt" },
				tex = { "latexindent" },
				-- dart = { "dcm_format" },
				["*"] = { "trim_whitespace" },
			},
			format_on_save = {
				timeout_ms = 5000,
				lsp_fallback = true,
			},
		},
		init = function()
			vim.api.nvim_create_user_command("Format", function(args)
				require("conform").format({ async = true, lsp_fallback = true, bufnr = args.bufnr })
			end, { range = true, bang = true })
		end,
	},

	-- Linter Configuration (nvim-lint)
	{
		"mfussenegger/nvim-lint",
		event = {
			"BufWritePost",
			"BufReadPost",
			-- "InsertLeave",
		},
		dependencies = { "williamboman/mason.nvim" }, -- Depends on Mason providing the tools
		opts = {
			linters_by_ft = {
				python = { "ruff" },
				lua = { "luacheck" },
				sh = { "shellcheck" },
				bash = { "shellcheck" },
				-- markdown = { "markdownlint" }, -- Uses markdownlint-cli
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
			"stevearc/dressing.nvim", -- optional for vim.ui.select
		},
		config = function()
			require("flutter-tools").setup({
				flutter_path = nil,
				flutter_lookup_cmd = "asdf where flutter",
				fvm = false,
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
				ui = {
					border = "rounded",
					notification_style = "native",
				},
				decorations = {
					statusline = {
						app_version = false,
						device = true,
					},
				},
				widget_guides = { enabled = true },
				closing_tags = { highlight = "Error" },
			})
		end,
	},
}
