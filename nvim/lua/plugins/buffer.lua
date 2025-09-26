return {

	{
		"ThePrimeagen/harpoon",
		keys = {
			-- {
			-- 	mode = "n",
			-- 	"<leader>m",
			-- 	function()
			-- 		require("harpoon"):list():add()
			-- 	end,
			-- },
			{
				mode = "n",
				"<leader>h",
				function()
					require("harpoon"):list():add()
				end,
			},
			-- {
			-- 	mode = "n",
			-- 	"<C-h>",
			-- 	function()
			-- 		require("harpoon"):list():add()
			-- 	end,
			-- },
			-- {
			-- 	mode = "n",
			-- 	"<C-CR>",
			-- 	function()
			-- 		require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
			-- 	end,
			-- },
			{
				mode = "n",
				"H",
				function()
					require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
				end,
			},
			{
				mode = "n",
				"<space>1",
				function()
					require("harpoon"):list():select(1)
				end,
			},
			{
				mode = "n",
				"<space>2",
				function()
					require("harpoon"):list():select(2)
				end,
			},
			{
				mode = "n",
				"<space>3",
				function()
					require("harpoon"):list():select(3)
				end,
			},
			{
				mode = "n",
				"<space>4",
				function()
					require("harpoon"):list():select(4)
				end,
			},
			{
				mode = "n",
				"<space>5",
				function()
					require("harpoon"):list():select(5)
				end,
			},
			-- {
			-- 	mode = "n",
			-- 	"<leader><C-j>",
			-- 	function()
			-- 		require("harpoon"):list():replace_at(1)
			-- 	end,
			-- },
			-- {
			-- 	mode = "n",
			-- 	"<leader><C-k>",
			-- 	function()
			-- 		require("harpoon"):list():replace_at(2)
			-- 	end,
			-- },
			-- {
			-- 	mode = "n",
			-- 	"<leader><C-l>",
			-- 	function()
			-- 		require("harpoon"):list():replace_at(3)
			-- 	end,
			-- },
			-- {
			-- 	mode = "n",
			-- 	"<leader><C-;>",
			-- 	function()
			-- 		require("harpoon"):list():replace_at(4)
			-- 	end,
			-- },
		},
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup({
				settings = {
					save_on_toggle = true,
					sync_on_ui_close = true,
					key = function()
						return vim.loop.cwd()
					end,
				},
			})
		end,
	},
}
