return {
	{
		"folke/neoconf.nvim",
		cmd = "Neoconf",
	},
	"folke/neodev.nvim",
	{
		"dstein64/vim-startuptime",
		-- keys = {
		--   { "<leader>S", "<Cmd>StartupTime<Cr>"}
		-- },
		cmd = "StartupTime",
		config = function()
			vim.g.startuptime_tries = 10
		end,
	},

	-- {
	--   'CosmicNvim/cosmic-ui',
	--   dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
	--   config = function()
	--     require('cosmic-ui').setup({
	--       border_style = 'rounded',
	--     })
	--   end,
	-- },

	-- {
	--  "folke/noice.nvim",
	--  opts = {
	--    -- add any options here
	--  },
	--  dependencies = {
	--    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
	--    "MunifTanjim/nui.nvim",
	--  },
	--  config = function ()
	--    require("noice").setup({
	--      lsp = {
	--        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
	--        override = {
	--          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
	--          ["vim.lsp.util.stylize_markdown"] = true,
	--          ["cmp.entry.get_documentation"] = true,
	--        },
	--      },
	--      cmdline = {
	--        view = "cmdline",
	--      },
	--      -- you can enable a preset for easier configuration
	--      presets = {
	--        bottom_search = true, -- use a classic bottom cmdline for search
	--        command_palette = false, -- position the cmdline and popupmenu together
	--        long_message_to_split = true, -- long messages will be sent to a split
	--        inc_rename = false, -- enables an input dialog for inc-rename.nvim
	--        lsp_doc_border = false, -- add a border to hover docs and signature help
	--      },
	--    })
	--  end
	-- }
	--
	--"nathom/filetype.nvim",
	--{
	--  'stevearc/dressing.nvim',
	--  opts = {},
	--  config = function ()
	--    require('dressing').setup()
	--  end,
	--},
}
