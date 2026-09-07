require("session"):setup({
	sync_yanked = true,
})

ps.sub("ind-app-title", function(args)
	local cwd = tostring(cx.active.current.cwd):match("([^/]+)$")
	args.value = "yazi " .. cwd
	return args
end)

for _, id in ipairs({ 1, 2 }) do
	Status:children_remove(id, Status.LEFT)
end

for _, id in ipairs({ 5, 6 }) do
	Status:children_remove(id, Status.RIGHT)
end

require("git"):setup()
