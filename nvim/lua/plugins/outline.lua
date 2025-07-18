return {
	{
		"hedyhli/outline.nvim",
		keys = {
			{ "<leader>ol", "<cmd>Outline<cr>", desc = "Outline" },
		},
		cmd = { "Outline", "OutlineOpen" },
		config = function()
			require("outline").setup({
				outline_window = {
					position = "left",
					auto_jump = true,
				},
			})
		end,
	},
}
