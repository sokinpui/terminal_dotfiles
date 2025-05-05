-- nvim/lua/plugins/nvim-cmp.lua
-- Auto completion and Snippets - Consolidated Configuration

return {
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		keys = { "/", "?" }, -- Keys that can potentially trigger completion loading if needed later
		dependencies = {
			-- Copilot Integration
			{
				"zbirenbaum/copilot-cmp",
				config = function()
					-- Basic setup for copilot-cmp, specific comparators are handled in main cmp config
					require("copilot_cmp").setup()
				end,
			},
			-- Core Sources
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path", -- Using hrsh7th/cmp-path instead of FelipeLema/cmp-async-path based on your lock file
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",

			-- Snippet Engine & Source
			"saadparwaiz1/cmp_luasnip",
			{
				"L3MON4D3/LuaSnip",
				build = "make install_jsregexp",
				dependencies = {
					-- Optional: Add snippet collections here if desired, e.g.:
					-- "rafamadriz/friendly-snippets",
					-- Load custom snippets defined via snipmate format
					{
						"smjonas/snippet-converter.nvim", -- Keep this if you use it to convert snippets
						cmd = "ConvertSnippets", -- Lazy load on command
					},
				},
				-- LuaSnip configuration is now inside the main cmp config function below
			},

			-- Filetype Specific Sources
			"micangl/cmp-vimtex", -- LaTeX

			-- Utility/Comparator
			"lukas-reineke/cmp-under-comparator",
		},
		config = function()
			-- ################################################################
			-- ## Start of merged content from plugins/config/nvim-cmp.lua ##
			-- ################################################################

			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local cmp_autopairs = require("nvim-autopairs.completion.cmp") -- Needed for autopairs integration

			-- Helper function for termcodes
			local t = function(str)
				return vim.api.nvim_replace_termcodes(str, true, true, true)
			end

			-- Helper function to check if there are words before the cursor
			local has_words_before = function()
				if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
					return false
				end
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
			end

			-- Helper function for Tab mapping logic
			local check_backspace = function()
				local col = vim.fn.col(".") - 1
				return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
			end

			-- Main nvim-cmp setup
			cmp.setup({
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},

				preselect = cmp.PreselectMode.None,

				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body) -- Tell cmp to use luasnip for expansion
					end,
				},

				sources = cmp.config.sources({
					{ name = "nvim_lsp_signature_help" },
					{ name = "nvim_lsp" },
					{ name = "luasnip" }, -- Snippets source
					{ name = "path" }, -- File path source
					{ name = "vimtex" }, -- LaTeX source
					{
						name = "buffer", -- Buffer text source
						keyword_length = 4,
						option = {
							get_bufnrs = function()
								return vim.api.nvim_list_bufs()
							end,
						},
					},
					-- Copilot source - uncomment if you install and setup zbirenbaum/copilot.lua separately
					-- Note: copilot-cmp handles the integration, not just listing 'copilot' here.
					-- The comparator logic handles prioritization.
					-- { name = "copilot" },
				}),

				sorting = {
					priority_weight = 2,
					comparators = {
						require("copilot_cmp.comparators").prioritize, -- Prioritize Copilot suggestions
						cmp.config.compare.offset,
						cmp.config.compare.exact,
						cmp.config.compare.score,
						-- require "cmp-under-comparator".under, -- Uncomment if you prefer this behavior
						cmp.config.compare.recently_used,
						cmp.config.compare.locality,
						cmp.config.compare.kind,
						cmp.config.compare.sort_text,
						cmp.config.compare.length,
						cmp.config.compare.order,
					},
				},

				mapping = cmp.mapping.preset.insert({
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),

					["<CR>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							if luasnip.expandable() then
								luasnip.expand()
							elseif cmp.visible() and cmp.get_active_entry() then
								cmp.confirm({
									select = false,
								})
							else
								fallback()
							end
						else
							fallback()
						end
					end),

					["<C-j>"] = cmp.mapping(function(fallback)
						if require("copilot.suggestion").is_visible() then
							require("copilot.suggestion").accept()
						else
							fallback()
						end
					end),

					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif has_words_before() then
							-- If no completion shown but words before cursor, try to trigger completion
							-- This might be useful if auto-trigger is off or slow
							-- cmp.complete() -- Uncomment if you want Tab to trigger completion manually
							fallback() -- Or just fallback to inserting a Tab character
						else
							fallback() -- Insert Tab if at line start or after space
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback() -- Fallback for Shift-Tab if needed (e.g., outdenting)
						end
					end, { "i", "s" }),

					-- Integrate with nvim-autopairs
					["<C-Space>"] = cmp.mapping.complete(), -- Manually trigger completion
				}),
			})

			-- Setup cmp for command line mode
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})

			-- nvim-autopairs integration
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

			-- ############################
			-- ## LuaSnip Configuration ##
			-- ############################

			-- Basic LuaSnip settings
			luasnip.config.set_config({
				history = true, -- Keep history for jumping back
				updateevents = "TextChanged,TextChangedI", -- When to update snippet nodes
				enable_autosnippets = true, -- Enable snippets triggered automatically
				store_selection_keys = "<Tab>", -- Key to store selected text for snippet expansion (if needed)
			})

			-- Load snippets

			-- Load snippets from friendly-snippets (if installed)
			-- require("luasnip.loaders.from_vscode").lazy_load()

			-- Load custom snippets from snipmate format (using your snippet-converter setup)
			-- Ensure snippet-converter.nvim is configured to output to this path
			require("luasnip.loaders.from_snipmate").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snipmates" } })

			-- Luasnip Keymaps (already partially handled by cmp mapping, but good for clarity/direct access)
			-- Use <C-k> and <C-j> for jumping through snippet placeholders
			vim.keymap.set({ "i", "s" }, "<C-k>", function()
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				end
			end, { silent = true })

			vim.keymap.set({ "i", "s" }, "<C-j>", function()
				if luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				end
			end, { silent = true })

			-- Customization for completion item kinds (optional, example)
			-- vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" }) -- Example highlight
			vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" }) -- Ensure float borders match background

			-- ##############################################################
			-- ## End of merged content from plugins/config/nvim-cmp.lua ##
			-- ##############################################################
		end, -- End of config function
	}, -- End of nvim-cmp plugin definition

	-- Snippet Converter (Keep this separate if you use its command directly)
	-- If you only use it via LuaSnip's loader, it could be just a build dependency of LuaSnip.
	{
		"smjonas/snippet-converter.nvim",
		cmd = "ConvertSnippets",
		config = function()
			-- Your snippet converter setup remains the same
			local template = {
				sources = {
					ultisnips = {
						vim.fn.stdpath("config") .. "/UltiSnips",
					},
				},
				output = {
					snipmate = {
						vim.fn.stdpath("config") .. "/snipmates", -- Ensure this path matches LuaSnip loader path
					},
				},
			}
			require("snippet_converter").setup({
				templates = { template },
			})
		end,
	},
}
