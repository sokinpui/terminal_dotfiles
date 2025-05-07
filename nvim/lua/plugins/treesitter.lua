return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				-- 安装 language parser
				-- :TSInstallInfo 命令查看支持的语言
				ensure_installed = {
					"html",
					"css",
					"vim",
					"lua",
					"javascript",
					"typescript",
					"python",
					"c",
					"java",
					"julia",
					"query",
					"markdown",
					"bash",
					"comment",
					"vimdoc",
				},
				-- 启用代码高亮功能
				highlight = {
					enable = true,
					--additional_vim_regex_highlighting = false
					additional_vim_regex_highlighting = { "markdown", "org" },
				},
				-- 启用增量选择
				incremental_selection = {
					enable = true,
					keymaps = {
						--- init_selection = '<TAB>',
						node_incremental = "<TAB>",
						node_decremental = "<S-TAB>",
						--- scope_incremental = '<TAB>',
					},
				},
				-- 启用基于Treesitter的代码格式化(=) . NOTE: This is an experimental feature.
				indent = {
					enable = false,
				},
				matchup = {
					enable = true, -- mandatory, false will disable the whole extension
					disable = {}, -- optional, list of language that will be disabled
					-- [options]
				},
			})
			vim.wo.foldmethod = "manual"
			vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
			---- 默认不要折叠
			---- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
			vim.wo.foldlevel = 99
			vim.g.foldlevelstart = 99
			vim.opt.foldenable = false
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
						},
					},
				},
			})
		end,
	},

	-- {
	--   "theHamsta/nvim-treesitter-pairs",
	--   event = { "BufReadPost", "BufNewFile" },
	--   config = function ()
	--     require'nvim-treesitter.configs'.setup {
	--       pairs = {
	--         enable = true,
	--         disable = {},
	--         highlight_pair_events = {}, -- e.g. {"CursorMoved"}, -- when to highlight the pairs, use {} to deactivate highlighting
	--         highlight_self = false, -- whether to highlight also the part of the pair under cursor (or only the partner)
	--         goto_right_end = false, -- whether to go to the end of the right partner or the beginning
	--         fallback_cmd_normal = "call matchit#Match_wrapper('',1,'n')", -- What command to issue when we can't find a pair (e.g. "normal! %")
	--         keymaps = {
	--           goto_partner = "<leader>%",
	--           delete_balanced = "X",
	--         },
	--         delete_balanced = {
	--           only_on_first_char = false, -- whether to trigger balanced delete when on first character of a pair
	--           fallback_cmd_normal = nil, -- fallback command when no pair found, can be nil
	--           longest_partner = false, -- whether to delete the longest or the shortest pair when multiple found.
	--           -- E.g. whether to delete the angle bracket or whole tag in  <pair> </pair>
	--         }
	--       }
	--     }
	--   end
	-- }

	--{
	--  'kevinhwang91/nvim-ufo',
	--  dependencies = {
	--    'kevinhwang91/promise-async'
	--  },
	--  config = function ()
	--    require('ufo').setup({
	--      provider_selector = function(bufnr, filetype, buftype)
	--        return {'treesitter', 'indent'}
	--      end
	--    })
	--  end
	--}
}
