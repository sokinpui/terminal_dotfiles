return {
	{
		"kevinhwang91/nvim-bqf",
		ft = "qf",
		config = function()
			vim.cmd([[
      hi BqfPreviewBorder guifg=#3e8e2d ctermfg=71
      hi BqfPreviewTitle guifg=#3e8e2d ctermfg=71
      hi BqfPreviewThumb guibg=#3e8e2d ctermbg=71
      hi link BqfPreviewRange Search
      ]])
			require("bqf").setup({
				auto_resize_height = true,
			})
		end,
	},
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("trouble").setup({
				padding = false, -- add an extra new line on top of the list
				cycle_results = false,
			})
		end,
	},
}
