return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				ensure_installed = {
					"html",
					"css",
					"vim",
					"lua",
					"javascript",
					"typescript",
					"python",
					"c",
					"java",
					"julia",
					"query",
					"markdown",
					"bash",
					"comment",
					"vimdoc",
				},
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = { "markdown", "org" },
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						node_incremental = "<TAB>",
						node_decremental = "<S-TAB>",
					},
				},
				indent = {
					enable = false,
				},
				matchup = {},
			})
			vim.wo.foldmethod = "expr"
			vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
			vim.wo.foldlevel = 99
			vim.g.foldlevelstart = 99
			vim.opt.foldenable = false
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
						},
					},
				},
			})
		end,
	},
}
