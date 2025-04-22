return {
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewClose",
      "DiffviewFileHistory",
      "DiffviewLog",
      "DiffviewFoucusFiles",
      "DiffviewOpen",
      "DiffviewRefresh",
      "DiffviewToggleFiles",
    },
    config = function()
      local actions = require("diffview.actions")

      require("diffview").setup({
        keymaps = {
          disable_defaults = false,
          view = {
            { "n", "q", "<Cmd>DiffviewClose<CR>", { silent = true } },
          },
          file_panel = {
            { "n", "q", "<Cmd>DiffviewClose<CR>", { silent = true } },
          }
        }
      })
    end,
  },
}
