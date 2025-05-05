return {
	{
		"mg979/vim-visual-multi",
		keys = {
			{ "<C-n>" },
			{ "<space><C-n>" },
			{ "<C-n>", mode = "v" },
			{ "<c-down>" },
			{ "<c-up>" },
			{ "u" },
			{ "<C-r>" },
		},
		branch = "master",
		config = function()
			vim.g.VM_default_mappings = 0
			vim.g.VM_maps = {
				["Find Under"] = "<C-n>",
				["Find Subword Under"] = "<C-n>",
				["Add Cursor Up"] = "<c-up>",
				["Add Cursor Down"] = "<c-down>",
				["Undo"] = "u",
				["Redo"] = "<C-r>",
				-- ["Find Operator"] = 'm',
				-- ["Run Last Visual"] = '<space><C-n>',
				["Switch Mode"] = "<Tab>",
				["Find Operator"] = "m",
			}
			vim.g.VM_quit_after_leaving_insert_mode = 0
			vim.g.VM_highlight_matches = "red"
			vim.g.VM_highlight_matches = "hi! Search ctermfg=228 "

			vim.cmd([[hi link VM_cursor NONE]])
			vim.cmd([[hi clear VM_cursor ]])
			vim.cmd([[highlight VM_cursor cterm=underline,reverse guifg=#282c34 guibg=#73b8f1 blend=0]])

			vim.g.VM_custom_remaps = { s = "c" }
		end,
	},
}
