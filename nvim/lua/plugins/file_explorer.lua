return {

	---@type LazySpec
	{
		"mikavilpas/yazi.nvim",
		event = "VeryLazy",
		dependencies = {
			-- check the installation instructions at
			-- https://github.com/folke/snacks.nvim
			-- "folke/snacks.nvim",
		},
		keys = {
			-- 👇 in this section, choose your own keymappings!
			{
				"L",
				mode = { "n", "v" },
				"<cmd>Yazi<cr>",
				desc = "Open yazi at the current file",
			},
			{
				-- Open in the current working directory
				"<leader>cw",
				"<cmd>Yazi cwd<cr>",
				desc = "Open the file manager in nvim's working directory",
			},
			{
				"<c-up>",
				"<cmd>Yazi toggle<cr>",
				desc = "Resume the last yazi session",
			},
		},
		---@type YaziConfig | {}
		opts = {
			-- if you want to open yazi instead of netrw, see below for more info
			open_for_directories = false,
			keymaps = {
				show_help = "<f1>",
			},
		},
		-- 👇 if you use `open_for_directories=true`, this is recommended
		init = function()
			-- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
			-- vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
		end,
		config = function()
			require("yazi").setup({
				open_for_directories = true,
			})
		end,
	},

	-- {
	-- 	"lmburns/lf.nvim",
	-- 	dependencies = {
	-- 		"akinsho/toggleterm.nvim",
	-- 	},
	-- 	config = function()
	-- 		local fn = vim.fn
	-- 		-- This feature will not work if the plugin is lazy-loaded
	-- 		vim.g.lf_netrw = 1
	--
	-- 		require("lf").setup({
	-- 			escape_quit = true,
	-- 			border = "rounded",
	-- 			height = fn.float2nr(fn.round(1 * vim.o.lines)), -- height of the *floating* window
	-- 			width = fn.float2nr(fn.round(1 * vim.o.columns)), -- width of the *floating* window
	-- 			default_file_manager = true,
	-- 			disable_netrw_warning = true,
	-- 		})
	--
	-- 		vim.keymap.set("n", "L", "<Cmd>Lf<CR>")
	--
	-- 		vim.api.nvim_create_autocmd("User", {
	-- 			pattern = "LfTermEnter",
	-- 			callback = function()
	-- 				vim.api.nvim_buf_set_keymap(a.buf, "t", "q", "q", { nowait = true })
	-- 			end,
	-- 		})
	-- 	end,
	-- },
}
