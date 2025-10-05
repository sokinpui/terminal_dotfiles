return {
	{
		"ibhagwan/fzf-lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		lazy = false,
		keys = {
			{ "<space>ff", "<cmd>FzfLua<cr>" },
			{
				"<C-b>",
				function()
					require("fzf-lua").buffers()
				end,
			},
			{
				"<C-f>",
				function()
					require("fzf-lua").files()
				end,
			},
			{
				"<C-g>",
				function()
					require("fzf-lua").grep({ search = "" })
				end,
			},
			{
				mode = "v",
				"<C-g>",
				function()
					require("fzf-lua").grep_visual()
				end,
			},
			{
				"<leader>fh",
				function()
					require("fzf-lua").help_tags()
				end,
			},
		},
		cmd = "FzfLua",
		config = function()
			-- require("fzf-lua").setup({ "fzf-native" })
			-- calling `setup` is optional for customization
			require("fzf-lua").setup({
				"telescope",
				global_resume = true,
				global_resume_query = true,
				winopts = {
					-- height = 1,
					width = 0.95,
					-- preview = {
					-- 	horizontal = "down:55%",
					-- },
				},
				hls = {
					cursorline = "Search",
					buf_name = "Normal",
				},
				files = {
					cwd_prompt = false,
					prompt = "Files❯ ",
				},
			})
		end,
	},
}
