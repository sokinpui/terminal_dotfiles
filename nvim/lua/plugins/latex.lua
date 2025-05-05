-- nvim/lua/plugins/latex.lua
return {
	{
		"lervag/vimtex",
		ft = { "tex", "bib" }, -- Load vimtex for .tex and .bib files
		lazy = false, -- Load vimtex eagerly for ft=tex to ensure globals are set
		-- Alternatively, keep lazy=true and move vim.g settings to init = function() ... end

		init = function()
			-- General settings (must be set BEFORE vimtex loads)
			vim.g.vimtex_enabled = 1 -- Ensure vimtex is enabled (redundant but safe)

			-- === Viewer ===
			-- Use Zathura as the PDF viewer. Alternatives: 'skim', 'sumatrapdf', 'evince', 'okular'
			-- Make sure the chosen viewer is installed on your system!
			vim.g.vimtex_view_method = "skim"
			-- vim.g.vimtex_view_general_viewer = "open"
			-- Optional: Set specific viewer options if needed (often auto-detected)
			-- vim.g.vimtex_view_general_options = '--synctex-forward 1:0:%f:%t' -- Example for some viewers
			-- Zathura specific options for SyncTeX inverse search (jumping from PDF to Vim)
			-- Often works automatically if nvim server is running and zathura is configured
			-- vim.g.vimtex_view_zathura_options = '--synctex-editor-command "nvim --servername ' .. vim.v.servername .. ' --remote-send \'<C-\\><C-N>:VimtexInverseSearch<CR>\'"'

			-- === Compiler ===
			-- Use latexmk for compilation (highly recommended)
			vim.g.vimtex_compiler_method = "latexmk"
			vim.g.vimtex_compiler_progname = "nvr"
			-- Ensure latexmk produces PDF output
			vim.g.vimtex_compiler_latexmk = {
				pdf_mode = 1,
				-- Add other latexmk options if needed, e.g.:
				-- options = {
				--   '-shell-escape',
				--   '-verbose',
				-- },
			}

			-- === Interface ===
			-- Use location list for errors/warnings (0=disable, 1=qf, 2=loclist per compile, 3=loclist continuously)
			vim.g.vimtex_quickfix_mode = 1
			-- Enable folding based on sections/environments
			vim.g.vimtex_fold_enabled = 1
			-- Enable concealment (e.g., show α instead of \alpha)
			vim.g.vimtex_conceal_enabled = 0
			vim.g.vimtex_conceal_active = 0 -- 0 = disabled, 1 = normal mode, 2 = normal+insert

			-- === Other ===
			-- Enable indentation
			vim.g.vimtex_indent_enabled = 1
			-- Enable syntax highlighting
			vim.g.vimtex_syntax_enabled = 1

			-- Optional: Disable default keybindings if you want to set them all manually
			-- vim.g.vimtex_mappings_enabled = 0
		end,

		config = function()
			-- Vimtex is now loaded, you can add config specific things here if needed
			-- e.g., setting up keymaps if default ones were disabled

			-- Example keymaps (vimtex default leader is '\')
			-- You can change the leader with: vim.g.vimtex_leader_key = ',' etc. in init()
			-- These are often enabled by default, but shown here for clarity
			vim.keymap.set(
				"n",
				"<leader>ll",
				"<Plug>(vimtex-compile)",
				{ noremap = false, silent = true, desc = "VimTeX Compile" }
			)
			vim.keymap.set(
				"n",
				"<leader>lv",
				"<Plug>(vimtex-view)",
				{ noremap = false, silent = true, desc = "VimTeX View" }
			)
			vim.keymap.set(
				"n",
				"<leader>ls",
				"<Plug>(vimtex-compile-selected)",
				{ noremap = false, silent = true, desc = "VimTeX Compile Selected" }
			)
			vim.keymap.set(
				"n",
				"<leader>lk",
				"<Plug>(vimtex-stop)",
				{ noremap = false, silent = true, desc = "VimTeX Stop" }
			)
			vim.keymap.set(
				"n",
				"<leader>lc",
				"<Plug>(vimtex-clean)",
				{ noremap = false, silent = true, desc = "VimTeX Clean Aux" }
			)
			vim.keymap.set(
				"n",
				"<leader>li",
				"<Plug>(vimtex-info)",
				{ noremap = false, silent = true, desc = "VimTeX Info/Errors" }
			)
			vim.keymap.set(
				"n",
				"<leader>lt",
				"<Plug>(vimtex-toc_open)",
				{ noremap = false, silent = true, desc = "VimTeX TOC Open" }
			)
			vim.keymap.set(
				"n",
				"<leader>lq",
				"<Plug>(vimtex-toc_toggle)",
				{ noremap = false, silent = true, desc = "VimTeX TOC Toggle" }
			) -- Toggle requires setting g:vimtex_toc_config
			vim.keymap.set(
				"n",
				"<leader>lg",
				"<Plug>(vimtex-status)",
				{ noremap = false, silent = true, desc = "VimTeX Status" }
			)

			vim.opt.conceallevel = 0 -- 0=none, 1=some, 2=most, 3=all
		end,
	},
}
