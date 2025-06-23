return {

	{
		"smjonas/live-command.nvim",
		-- live-command supports semantic versioning via Git tags
		-- tag = "2.*",
		config = function()
			require("live-command").setup({
				enable_highlighting = true,
				inline_highlighting = true,
				hl_groups = {
					insertion = "DiffAdd",
					deletion = "DiffDelete",
					change = "DiffChange",
				},
				commands = {
					Norm = { cmd = "norm" },
					D = { cmd = "d" },
					G = { cmd = "g" },
				},
			})
			vim.cmd("cnoreabbrev norm Norm")
			vim.cmd("cnoreabbrev d D")
			vim.cmd("cnoreabbrev g G")
		end,
	},
}
