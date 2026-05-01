return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("nvim-treesitter").install({
				"html",
				"css",
				"vim",
				"lua",
				"javascript",
				"typescript",
				"go",
				"python",
				"c",
				"java",
				"julia",
				"query",
				"markdown",
				"bash",
				"comment",
				"vimdoc",
			})

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					pcall(vim.treesitter.start, args.buf)

					vim.opt_local.foldmethod = "expr"
					vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
				end,
			})

			vim.opt.foldlevel = 99
			vim.opt.foldlevelstart = 99
			vim.opt.foldenable = false
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("nvim-treesitter-textobjects").setup({
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
			})
		end,
	},
}
