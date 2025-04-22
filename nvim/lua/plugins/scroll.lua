return {
  {
    'declancm/cinnamon.nvim',
    config = function()
      require('cinnamon').setup({
        default_delay = 5,
        centered = true,
      })
      -- Previous/next cursor location:
      -- vim.keymap.set('n', '<C-o>', "<Cmd>lua Scroll('<C-o>', 1)<CR>")
      -- vim.keymap.set('n', '<C-i>', "<Cmd>lua Scroll('1<C-i>', 1)<CR>")

      -- SCROLL_WHEEL_KEYMAPS:
      vim.keymap.set({ 'n', 'x' }, '<ScrollWheelUp>', "<Cmd>lua Scroll('<ScrollWheelUp>')<CR>")
      vim.keymap.set({ 'n', 'x' }, '<ScrollWheelDown>', "<Cmd>lua Scroll('<ScrollWheelDown>')<CR>")

      -- Previous/next search result:
      -- vim.keymap.set('n', 'n', "<Cmd>lua Scroll('n', 1)<CR>")
      -- vim.keymap.set('n', 'N', "<Cmd>lua Scroll('N', 1)<CR>")
      -- vim.keymap.set('n', '*', "<Cmd>lua Scroll('*', 1)<CR>")
      -- vim.keymap.set('n', '#', "<Cmd>lua Scroll('#', 1)<CR>")
      -- vim.keymap.set('n', 'g*', "<Cmd>lua Scroll('g*', 1)<CR>")
      -- vim.keymap.set('n', 'g#', "<Cmd>lua Scroll('g#', 1)<CR>")
    end
  }
  -- {
  --   "karb94/neoscroll.nvim",
  --   config = function ()
  --     require('neoscroll').setup {}
  --   end
  -- }
}
