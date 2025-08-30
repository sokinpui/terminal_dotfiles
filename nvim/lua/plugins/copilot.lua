return {

	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		build = ":Copilot auth",
		-- event = "InsertEnter",
		event = {
			"InsertEnter",
			"BufReadPre",
			"BufNewFile",
		},
		config = function()
			require("copilot").setup({
				suggestion = {
					enabled = true,
					auto_trigger = true,
					keymap = {
						accept = "<S-CR>",
						-- accept_word = false,
						-- accept_line = false,
						-- next = "<C-j>",
						-- prev = "<C-k>",
						-- dismiss = "<C-]>",
					},
				},
				panel = { enabled = false },
				filetypes = {
					yaml = true,
					markdown = true,
					help = false,
					gitcommit = true,
					gitrebase = false,
					hgcommit = false,
					svn = false,
					cvs = false,
					["."] = false,
				},
			})

			-- local cmp_status_ok, cmp = pcall(require, "cmp")
			-- if cmp_status_ok then
			-- 	cmp.event:on("menu_opened", function()
			-- 		vim.b.copilot_suggestion_hidden = true
			-- 	end)
			--
			-- 	cmp.event:on("menu_closed", function()
			-- 		vim.b.copilot_suggestion_hidden = false
			-- 	end)
			-- end
		end,
	},
}
