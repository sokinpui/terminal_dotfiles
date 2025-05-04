-- nvim/lua/plugins/config/lsp.lua
local M = {} -- Create a module to export the on_attach function

-- Define the shared on_attach function
function M.on_attach(client, bufnr)
  -- Standard LSP keymaps
  local opts = { buffer = bufnr, noremap = true, silent = true }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  -- vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, opts) -- If NOT using conform.nvim

  -- Enable completion triggered by <c-x><c-o>
  vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

  -- Attach lsp-format if you are using it
  -- Note: If using conform.nvim, you might not need lsp-format anymore.
  if pcall(require, 'lsp-format') then
     require('lsp-format').on_attach(client, bufnr)
  end

  -- Add any other logic needed on attach, e.g., conditional settings
  if client.name == "pyright" then
    -- Pyright specific settings or keymaps on attach
  end
end

-- Remove the old servers list, the loop, and the LspAttach autocmd.
-- The capabilities are now handled directly in the mason-lspconfig handlers.

return M -- Return the module containing the on_attach function
