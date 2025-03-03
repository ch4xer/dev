require("session"):setup({
	sync_yanked = true,
})

require("no-status"):setup()
THEME.git = THEME.git or {}
THEME.git.added_sign = "A"
THEME.git.modified_sign = "M"
THEME.git.deleted_sign = "D"
require("git"):setup()
