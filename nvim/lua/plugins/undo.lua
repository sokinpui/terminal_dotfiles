return {
  {
    'mbbill/undotree',
    keys = {
      {'<leader>u', '<Cmd>UndotreeToggle<cr>', { noremap = true, silent = true }}
    },
    config = function()
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_HelpLine = 0
      vim.g.undotree_ShortIndicators = 1
    end
  }
}
