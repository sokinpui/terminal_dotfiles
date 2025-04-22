local opts = {silent = true, noremap = true}
-- local fzf = require('fzf-lua')
return {
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = {
      -- "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    keys = {
      { "<space>ff", "<cmd>FzfLua<cr>" },
      { "<space><space>", function()
        local success, result = pcall(require('fzf-lua').git_files)
        if not result then
          require('fzf-lua').files()
        end
      end },
      -- { "<space>pp", function () require('fzf-lua').grep_project() end },
      { "<space>gp", function () require('fzf-lua').grep({ search = "" }) end },
      { "<space>fl", function () require('fzf-lua').lines() end },

      { "<leader>fh", function () require('fzf-lua').help_tags() end },
      -- { "<leader>fm", function () require('fzf-lua').marks() end },
      -- { "<leader>fk", function () require('fzf-lua').keymaps() end },
      -- { "<leader>fo", function () require('fzf-lua').oldfiles() end },
      -- { "<leader>fgf", function () require('fzf-lua').git_files() end },
      -- { "<leader>fc", function () require('fzf-lua').commands() end },

      -- { "<leader>fl", function () require('fzf-lua').resume() end },
      -- { "<leader>fz", function () require('fzf-lua').builtin() end },
    },
    cmd = "FzfLua",
    config = function()
      local actions = require "fzf-lua.actions"
      -- calling `setup` is optional for customization
      require("fzf-lua").setup({
        global_resume = true,
        global_resume_query = true,
        file_icons    = false,
        winopts = {
          height = 1,
          width = 0.95,
          preview = {
            horizontal     = 'down:55%'
          }
        },
        fzf_opts = {
          ['--history'] = vim.fn.stdpath("data") .. '/fzf-lua-history',
        },
        hls = {
          cursorline = "Search",
          buf_name = "Normal"
        },
        buffers = {
          -- prompt            = 'Buffers❯ ',
          -- file_icons        = "devicons",         -- show file icons (true|"devicons"|"mini")?
          -- file_icons        = false,         -- show file icons (true|"devicons"|"mini")?
          color_icons       = true,         -- colorize file|git icons
          sort_lastused     = false,         -- sort buffers() by last used
          show_unloaded     = true,         -- show unloaded buffers
          cwd_only          = false,        -- buffers for the cwd only
          cwd               = nil,          -- buffers list for a given dir
          actions = {
            -- actions inherit from 'actions.files' and merge
            -- by supplying a table of functions we're telling
            -- fzf-lua to not close the fzf window, this way we
            -- can resume the buffers picker on the same window
            -- eliminating an otherwise unaesthetic win "flash"
            ["ctrl-x"]      = { fn = actions.buf_del, reload = true },
          }
        },
        actions = {
          -- These override the default tables completely
          -- no need to set to `false` to disable an action
          -- delete or modify is sufficient
          files = {
            -- providers that inherit these actions:
            --   files, git_files, git_status, grep, lsp
            --   oldfiles, quickfix, loclist, tags, btags
            --   args
            -- default action opens a single selection
            -- or sends multiple selection to quickfix
            -- replace the default action with the below
            -- to open all files whether single or multiple
            -- ["default"]     = actions.file_edit,
            ["default"]     = actions.file_edit_or_qf,
            ["ctrl-s"]      = actions.file_split,
            ["ctrl-v"]      = actions.file_vsplit,
            ["ctrl-t"]      = actions.file_tabedit,
            ["ctrl-q"]       = actions.file_sel_to_qf,
            ["alt-l"]       = actions.file_sel_to_ll,
          },
          buffers = {
            -- providers that inherit these actions:
            --   buffers, tabs, lines, blines
            ["default"]     = actions.buf_edit,
            ["ctrl-s"]      = actions.buf_split,
            ["ctrl-v"]      = actions.buf_vsplit,
            ["ctrl-t"]      = actions.buf_tabedit,
            ["ctrl-q"]       = actions.file_sel_to_qf,
          }
        },
      })

      --vim.keymap.set("t", "<C-v>", "<C-\\><C-n>\"+pA", opts)
    end
  }
}
