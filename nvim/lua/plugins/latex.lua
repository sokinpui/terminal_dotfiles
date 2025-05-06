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
			vim.g.vimtex_compiler_latexmk = {
				options = {
					"-pdf",
					"-shell-escape",
					"-verbose",
					"-file-line-error",
					"-synctex=1",
					"-interaction=nonstopmode",
				},
			}

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

			vim.g.vimtex_view_automatic = 1
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
	{
		"HakonHarnes/img-clip.nvim",
		keys = {
			-- suggested keymap
			{ "<leader>i", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
			{ "<c-v>", mode = { "i" }, "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
		},
		ft = {
			"tex",
			"md",
			"markdown",
		}, -- Load vimtex for .tex and .bib files
		opts = {
			default = {
				-- file and directory options
				dir_path = "assets", ---@type string | fun(): string
				extension = "png", ---@type string | fun(): string
				file_name = "%Y-%m-%d-%H-%M-%S", ---@type string | fun(): string
				use_absolute_path = false, ---@type boolean | fun(): boolean
				relative_to_current_file = false, ---@type boolean | fun(): boolean

				-- template options
				template = "$FILE_PATH", ---@type string | fun(context: table): string
				url_encode_path = false, ---@type boolean | fun(): boolean
				relative_template_path = true, ---@type boolean | fun(): boolean
				use_cursor_in_template = true, ---@type boolean | fun(): boolean
				insert_mode_after_paste = true, ---@type boolean | fun(): boolean

				-- prompt options
				prompt_for_file_name = true, ---@type boolean | fun(): boolean
				show_dir_path_in_prompt = false, ---@type boolean | fun(): boolean

				-- base64 options
				max_base64_size = 10, ---@type number | fun(): number
				embed_image_as_base64 = false, ---@type boolean | fun(): boolean

				-- image options
				process_cmd = "", ---@type string | fun(): string
				copy_images = false, ---@type boolean | fun(): boolean
				download_images = true, ---@type boolean | fun(): boolean

				-- drag and drop options
				drag_and_drop = {
					enabled = true, ---@type boolean | fun(): boolean
					insert_mode = true, ---@type boolean | fun(): boolean
				},
			},

			-- filetype specific options
			filetypes = {
				markdown = {
					url_encode_path = true, ---@type boolean | fun(): boolean
					template = "![$CURSOR]($FILE_PATH)", ---@type string | fun(context: table): string
					download_images = false, ---@type boolean | fun(): boolean
				},

				vimwiki = {
					url_encode_path = true, ---@type boolean | fun(): boolean
					template = "![$CURSOR]($FILE_PATH)", ---@type string | fun(context: table): string
					download_images = false, ---@type boolean | fun(): boolean
				},

				html = {
					template = '<img src="$FILE_PATH" alt="$CURSOR">', ---@type string | fun(context: table): string
				},

				tex = {
					relative_template_path = false, ---@type boolean | fun(): boolean
					template = [[
\begin{figure}[h]
  \centering
  \includegraphics[width=0.5\textwidth]{$FILE_PATH}
  \caption{$CURSOR}
  \label{fig:$LABEL}
\end{figure}
    ]], ---@type string | fun(context: table): string
				},

				typst = {
					template = [[
#figure(
  image("$FILE_PATH", width: 80%),
  caption: [$CURSOR],
) <fig-$LABEL>
    ]], ---@type string | fun(context: table): string
				},

				rst = {
					template = [[
.. image:: $FILE_PATH
   :alt: $CURSOR
   :width: 80%
    ]], ---@type string | fun(context: table): string
				},

				asciidoc = {
					template = 'image::$FILE_PATH[width=80%, alt="$CURSOR"]', ---@type string | fun(context: table): string
				},

				org = {
					template = [=[
#+BEGIN_FIGURE
[[file:$FILE_PATH]]
#+CAPTION: $CURSOR
#+NAME: fig:$LABEL
#+END_FIGURE
    ]=], ---@type string | fun(context: table): string
				},
			},

			-- file, directory, and custom triggered options
			files = {}, ---@type table | fun(): table
			dirs = {}, ---@type table | fun(): table
			custom = {}, ---@type table | fun(): table
		},
	},
}
