return {
  {
    'nvim-orgmode/orgmode',
    ft = "org",
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter', lazy = true },
      {
        'akinsho/org-bullets.nvim',
        config = function()
          require('org-bullets').setup()
        end
      },
      {
        'sokinpui/orgmode-multi-key',
        config = function()
          require('orgmode-multi-key').setup()
        end
      }
    },
    config = function()
      -- Load treesitter grammar for org

      require('orgmode').setup({
        org_agenda_files = '~/org/**/*',
        org_default_notes_file = '~/org/index.org',
        -- org_highlight_latex_and_related = "entities",
        -- org_hide_leading_stars = true,
      })
    end,
  }
}
