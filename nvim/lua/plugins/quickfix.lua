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
				preview = {
					winblend = 0,
				},
			})
			vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>")
			vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>")

			local function ToggleQuickFix()
				-- Check if the quickfix window is already open
				local qf_open = false
				for _, win in ipairs(vim.fn.getwininfo()) do
					if win.quickfix == 1 then
						qf_open = true
						break
					end
				end

				if qf_open then
					-- If it's open, close it
					vim.cmd("cclose")
				else
					-- Otherwise, try to open it
					-- pcall is used to catch errors, for instance, if there is no quickfix list
					local success, _ = pcall(vim.cmd, "copen")
					if not success then
						print("No Quickfix list available.")
					end
				end
			end

			-- Map the function to <leader>qf in normal mode
			vim.keymap.set("n", "<leader>qf", ToggleQuickFix, { desc = "Toggle Quickfix window" })
			vim.keymap.set("n", "<C-l>", function()
				ToggleQuickFix()
			end)
		end,
	},
	-- {
	-- 	"folke/trouble.nvim",
	-- 	cmd = "Trouble",
	-- 	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- 	config = function()
	-- 		require("trouble").setup({
	-- 			padding = false, -- add an extra new line on top of the list
	-- 			cycle_results = false,
	-- 		})
	-- 	end,
	-- },
}
