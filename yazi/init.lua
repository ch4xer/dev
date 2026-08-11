require("session"):setup({
	sync_yanked = true,
})

ps.sub("ind-app-title", function(args)
	local cwd = tostring(cx.active.current.cwd):match("([^/]+)$")
	args.value = "yazi " .. cwd
	return args
end)

require("no-status"):setup()
require("git"):setup()
