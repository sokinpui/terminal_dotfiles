local opts = { silent = true, noremap = true }
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
				"<C-f>",
				function()
					local success, result = pcall(require("fzf-lua").git_files)
					if not result then
						require("fzf-lua").files()
					end
				end,
			},
			{
				"<C-p>",
				function()
					require("fzf-lua").live_grep_native({
						fzf_opts = {
							["--tiebreak"] = "index",
						},
					})
				end,
			},
			{
				"<space>fl",
				function()
					require("fzf-lua").lines()
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
			require("fzf-lua").setup({ "fzf-native" })
			local actions = require("fzf-lua.actions")
			-- calling `setup` is optional for customization
			require("fzf-lua").setup({
				global_resume = true,
				global_resume_query = true,
				file_icons = false,
				winopts = {
					height = 1,
					width = 0.95,
					preview = {
						horizontal = "down:55%",
					},
				},
				fzf_opts = {
					["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-history",
				},
				hls = {
					cursorline = "Search",
					buf_name = "Normal",
				},
				buffers = {
					color_icons = true,
					sort_lastused = true,
					show_unloaded = true,
					cwd_only = false,
					cwd = nil,
					actions = {
						["ctrl-x"] = { fn = actions.buf_del, reload = true },
					},
				},
				actions = {
					files = {
						["default"] = actions.file_edit_or_qf,
						["ctrl-s"] = actions.file_split,
						["ctrl-v"] = actions.file_vsplit,
						["ctrl-t"] = actions.file_tabedit,
						["ctrl-q"] = actions.file_sel_to_qf,
						["alt-l"] = actions.file_sel_to_ll,
					},
					buffers = {
						["default"] = actions.buf_edit,
						["ctrl-s"] = actions.buf_split,
						["ctrl-v"] = actions.buf_vsplit,
						["ctrl-t"] = actions.buf_tabedit,
						["ctrl-q"] = actions.file_sel_to_qf,
					},
				},
			})
		end,
	},
}
