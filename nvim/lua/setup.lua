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
	require("plugins.buffer"),
	require("plugins.jump"),
	require("plugins.git"),
	-- require("plugins.multi-cursor"),
	-- require("plugins.visual-effect"),
	require("plugins.surround"),
	require("plugins.auto-pairs"),
	require("plugins.fzf"),
	-- require("plugins.latex"),
	require("plugins.code_tools"),
	require("plugins.nvim-cmp"),
	require("plugins.copilot"),
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
}, {})
