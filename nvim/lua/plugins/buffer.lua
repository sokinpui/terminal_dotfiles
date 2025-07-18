return {
	-- {
	--   "j-morano/buffer_manager.nvim",
	--   keys = {
	--     -- {"<C-b>"},
	--     {"<CR>"},
	--   },
	--   dependencies = {
	--     "nvim-lua/plenary.nvim",
	--   },
	--   config = function()
	--     local opts = { noremap = true, silent = true }
	--     require("buffer_manager").setup({
	--       focus_alternate_buffer = true,
	--       borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
	--       height = 24,
	--       width = 80,
	--       short_term_names = true,
	--       line_keys = "1234567890",
	--       loop_nav = true
	--     })
	--     -- vim.keymap.set("n", "<C-b>", require("buffer_manager.ui").toggle_quick_menu, opts)
	--     vim.keymap.set("n", "<Cr>", require("buffer_manager.ui").toggle_quick_menu, opts)
	--   end
	-- },
	{
		"ThePrimeagen/harpoon",
		keys = {
			{
				mode = "n",
				"<leader>m",
				function()
					require("harpoon"):list():add()
				end,
			},
			{
				mode = "n",
				"<leader>h",
				function()
					require("harpoon"):list():add()
				end,
			},
			{
				mode = "n",
				"<C-h>",
				function()
					require("harpoon"):list():add()
				end,
			},
			{
				mode = "n",
				"<C-CR>",
				function()
					require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
				end,
			},
			{
				mode = "n",
				"H",
				function()
					require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
				end,
			},
			{
				mode = "n",
				"<C-h>",
				function()
					require("harpoon"):list():select(1)
				end,
			},
			{
				mode = "n",
				"<C-j>",
				function()
					require("harpoon"):list():select(2)
				end,
			},
			{
				mode = "n",
				"<C-k>",
				function()
					require("harpoon"):list():select(3)
				end,
			},
			{
				mode = "n",
				"<C-l>",
				function()
					require("harpoon"):list():select(4)
				end,
			},
			{
				mode = "n",
				"<leader><C-h>",
				function()
					require("harpoon"):list():replace_at(1)
				end,
			},
			{
				mode = "n",
				"<leader><C-j>",
				function()
					require("harpoon"):list():replace_at(2)
				end,
			},
			{
				mode = "n",
				"<leader><C-k>",
				function()
					require("harpoon"):list():replace_at(3)
				end,
			},
			{
				mode = "n",
				"<leader><C-l>",
				function()
					require("harpoon"):list():replace_at(4)
				end,
			},
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
	-- {
	--   "cbochs/grapple.nvim",
	--   keys = {
	--     "<Enter>",
	--     "<leader>m",
	--     "<leader>a",
	--   },
	--   cmd = {
	--     "Grapple",
	--   },
	--   dependencies = { "nvim-lua/plenary.nvim" },
	--   config = function ()
	--     local grapple = require("grapple")
	--     grapple.setup()
	--     vim.keymap.set("n", "<leader>m", function() grapple.tag() end, {})
	--     vim.keymap.set("n", "<leader>a", function() grapple.tag() end, {})
	--     vim.keymap.set("n", "<Enter>", function() grapple.open_tags() end, {})
	--   end
	-- },
}
