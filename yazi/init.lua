-- ~/.config/yazi/init.lua
th.git = th.git or {}
th.git.unknown_sign = "?"
th.git.modified_sign = "M"
th.git.added_sign = "A"
th.git.untracked_sign = "U"
th.git.ignored_sign = "I"
th.git.deleted_sign = "D"
th.git.updated_sign = "U"
th.git.clean_sign = "C"

require("git"):setup({ order = 1500 })

require("no-status"):setup()

require("full-border"):setup({
	type = ui.Border.ROUNDED,
})

require("session"):setup({
	sync_yanked = true,
})

require("duckdb"):setup()
