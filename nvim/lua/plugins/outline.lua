return {
  {
    "hedyhli/outline.nvim",
    keys = {
      { "<leader>ol", "<cmd>Outline<cr>", desc = "Outline" },
    },
    cmd = { "Outline", "OutlineOpen" },
    config = function()
      require("outline").setup()
    end,
  },
}
