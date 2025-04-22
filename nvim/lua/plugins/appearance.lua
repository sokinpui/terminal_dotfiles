return {
  {
    "sokinpui/onedark-modified",
    config = function()
      vim.opt.background = "dark"
      --enable colorscheme
      require('onedark').setup {
        style = 'dark'
      }
      require('onedark').load()
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    -- dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = {
          icons_enabled = false,
          section_separators = { '', '' },
          component_separators = { '', '' },
        },
        sections = {
          lualine_a = {'branch'},
          -- lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_b = {
            {
              'filename',
              path = 3,
              file_status = true,
            }
          },
          lualine_c = {},
          -- lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_x = {'progress'},
          lualine_y = {'location'},
          lualine_z = { },
        },
      })
    end
  },
  -- {
  --   "nvim-tree/nvim-web-devicons",
  --   lazy = true,
  --   config = function()
  --     require'nvim-web-devicons'.setup()
  --   end
  -- },
  {
    "anuvyklack/help-vsplit.nvim",
    event = "VeryLazy",
    config = function()
      require('help-vsplit').setup({
        always = true, -- Always open help in a vertical split.
        side = 'right', -- 'left' or 'right'
        buftype = { 'help' },
        filetype = { 'man' }
      })
    end
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    keys = {
      { "<leader>ll", "<CMD>IBLToggle<CR>" },
    },
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
    config = function()
      require("ibl").setup()
      local ibl = require("ibl")
      local conf = require "ibl.config"
      ibl.update { enabled = not conf.get_config(-1).enabled }
    end
  },
  {
    -- "sphamba/smear-cursor.nvim",
    -- opts = {},
    -- confi = function()
    --   require('smear_cursor').enabled = true
    -- end
  }
}
