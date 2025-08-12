-- nvim/lua/setup.lua

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
	require("plugins.live-command"),
	-- require("plugins.terminal"),

	-- buffer jump
	require("plugins.buffer"),

	-- require("plugins.file_explorer"),

	-- motion
	-- require("plugins.cleverf"),
	require("plugins.jump"),
	-- require("plugins.multi-cursor"),
	-- require("plugins.visual-effect"),
	require("plugins.surround"),
	require("plugins.auto-pairs"),

	-- fzf
	require("plugins.fzf"),
	-- require("plugins.scroll"),

	-- filetype
	require("plugins.latex"),
	require("plugins.markdown"),
	-- require("plugins.orgmode"),
	-- { "kmonad/kmonad-vim", ft = "kbd"},

	-- === Centralized Code Tools Setup ===
	require("plugins.code_tools"),

	-- === Completion (depends on LSP capabilities from code_tools) ===
	require("plugins.nvim-cmp"),
	require("plugins.copilot"),

	-- git
	-- require("plugins.git"),

	--tmux
	require("plugins.tmux"),
}, {})
