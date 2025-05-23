return {
	{
		"toppair/peek.nvim",
		build = "deno task --quiet build:fast",
		config = function()
			-- default config:
			require("peek").setup({
				auto_load = true, -- whether to automatically load preview when
				-- entering another markdown buffer
				close_on_bdelete = true, -- close preview window on buffer delete

				syntax = true, -- enable syntax highlighting, affects performance

				theme = "light", -- 'dark' or 'light'

				update_on_change = true,

				app = "webview", -- 'webview', 'browser', string or a table of strings
				-- explained below

				filetype = { "markdown" }, -- list of filetypes to recognize as markdown

				-- relevant if update_on_change is true
				throttle_at = 200000, -- start throttling when file exceeds this
				-- amount of bytes in size
				throttle_time = "auto", -- minimum amount of time in milliseconds
				-- that has to pass before starting new render
			})
			vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
			vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
		end,
	},
	-- {
	--   "preservim/vim-markdown",
	--   config = function()
	--     vim.opt.conceallevel                       = 0
	--     vim.g.vim_markdown_folding_disabled        = 1
	--     vim.g.vim_markdown_no_default_key_mappings = 1
	--     vim.g.vim_markdown_conceal_code_blocks     = 1
	--     vim.g.vim_markdown_math                    = 1
	--     vim.g.tex_conceal                          = "abmgs"
	--     vim.g.vim_markdown_conceal                 = 1
	--     vim.g.vim_markdown_toc_autofit             = 1
	--     vim.g.vim_markdown_follow_anchor           = 0
	--     vim.g.vim_markdown_toml_frontmatter        = 1
	--     vim.g.vim_markdown_json_frontmatter        = 1
	--     vim.g.vim_markdown_frontmatter             = 1
	--     vim.g.vim_markdown_strikethrough           = 0
	--   end,
	-- },
	-- {
	--   "postfen/clipboard-image.nvim",
	--   ft = "markdown",
	--   config = function()
	--     require 'clipboard-image'.setup {
	--       -- Default configuration for all filetype
	--       default = {
	--         img_dir = { "%:p:h", "img" }, -- Use table for nested dir (New feature form PR #20)
	--         img_name = function()
	--           vim.fn.inputsave()
	--           local name = vim.fn.input('Name: ')
	--           vim.fn.inputrestore()
	--           return name
	--         end,
	--         affix = "<\n  %s\n>" -- Multi lines affix
	--       },
	--       -- You can create configuration for ceartain filetype by creating another field (markdown, in this case)
	--       -- If you're uncertain what to name your field to, you can run `lua print(vim.bo.filetype)`
	--       -- Missing options from `markdown` field will be replaced by options from `default` field
	--       markdown = {
	--         img_dir = { "%:p:h", "img" }, -- Use table for nested dir (New feature form PR #20)
	--         img_name = function()
	--           vim.fn.inputsave()
	--           local name = vim.fn.input('Name: ')
	--           vim.fn.inputrestore()
	--           return name
	--         end,
	--         img_handler = function(img)
	--           vim.cmd("normal! f[")            -- go to [
	--           vim.cmd("normal! a" .. img.name) -- append text with image name
	--         end,
	--         affix = "![](%s)",
	--       }
	--     }
	--   end
	-- },
	--{
	--  "lervag/lists.vim",
	--  ft = "markdown",
	--  config = function()
	--    vim.cmd("ListsEnable")
	--  end,
	--},
	-- {
	--   "coachshea/vim-textobj-markdown",
	--   dependencies = {
	--     "kana/vim-textobj-user"
	--   },
	--   ft = "markdown",
	--   config = function()
	--     vim.g.textobj_markdown_no_default_key_mappings = 1
	--   end
	-- },

	--{
	--  "AckslD/nvim-FeMaco.lua",
	--  cmd = "FeMaco",
	--  config = function()
	--    require("femaco").setup()
	--  end
	--},

	-- {
	--   "sokinpui/open-in-obsidian.nvim",
	--   cmd = "Obsidian",
	--   config = function()
	--     require("obs")
	--   end,
	-- },
	-- {
	--   'jghauser/follow-md-links.nvim',
	--   ft = "markdown",
	-- }
}
