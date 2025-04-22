return {
  -- {
  --   'echasnovski/mini.jump',
  --   version = false,
  --   keys = {
  --     {"f", mode = {"n", "v", "o"}},
  --     {"F", mode = {"n", "v", "o"}},
  --     {"t", mode = {"n", "v", "o"}},
  --     {"T", mode = {"n", "v", "o"}},
  --   },
  --   config = function()
  --     require('mini.jump').setup({
  --       mappings = {
  --         -- forward = ';',
  --         -- backward = ',',
  --         -- repeat_jump = '',
  --       },
  --       delay = {
  --         highlight = 0,
  --       }
  --     })
  --   end
  -- },

  {
    "rhysd/clever-f.vim",
    keys = {
      { "f", mode = { "n", "v", "o" } },
      { "F", mode = { "n", "v", "o" } },
      { "t", mode = { "n", "v", "o" } },
      { "T", mode = { "n", "v", "o" } },
    },
    config = function()
      vim.cmd([[highlight CleverFDefaultLabel cterm=bold, ctermfg=9 gui=bold guifg=#E3242B]])
      vim.g.clever_f_smart_case = 1
      vim.g.clever_f_across_no_line = 0
      vim.g.clever_f_chars_match_any_signs = '\t'
      vim.g.clever_f_repeat_last_char_inputs = { '\r' }
      vim.g.clever_f_fix_key_direction = 1
      vim.keymap.set('', ';', '<Plug>(clever-f-repeat-forward)', { noremap = true, silent = true })
      vim.keymap.set('', ',', '<Plug>(clever-f-repeat-back)', { noremap = true, silent = true })
    end
  },
}
