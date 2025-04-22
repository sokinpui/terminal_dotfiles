--lazy.nvim
---install plugin if missed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "

require("lazy").setup({
  -- editor
  require("plugins.ultis"),
  require("plugins.appearance"),
  require("plugins.treesitter"),
  require("plugins.undo"),
  require("plugins.quickfix"),
  require("plugins.comments"),
  require("plugins.outline"),
  -- require("plugins.terminal"),

  -- buffer jump
  require("plugins.buffer"),

  require("plugins.file_explorer"),

  -- motion
  -- require("plugins.cleverf"),
  require("plugins.jump"),
  require("plugins.visual-multi"),
  require("plugins.surround"),
  require("plugins.auto-pairs"),

  -- fzf
  require("plugins.fzf"),
  -- require("plugins.scroll"),
  -- filetype
  -- require("plugins.markdown"),

  -- require("plugins.orgmode"),
  -- { "kmonad/kmonad-vim", ft = "kbd"},

  -- completion
  require("plugins.lsp"),
  require("plugins.nvim-cmp"),
  require("plugins.copilot"),

  -- git
  -- require("plugins.git"),

  --tmux
  require("plugins.tmux"),

  --create directory if not exist
  -- 'jghauser/mkdir.nvim'

  -- useless
  -- require("plugins.fun"),

  -- 'nanotee/zoxide.vim',

  --require("plugins.fern"),
  --require("plugins.flit"),
  --require("plugins.neorg"),
  --require("plugins.which-key"),
  --require("plugins.telescope"),
  --'wellle/targets.vim',

}, {})

-- vim.keymap.set("n", "<leader>L", "<Cmd>Lazy<Cr>", { noremap = true })
