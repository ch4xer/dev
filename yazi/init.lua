require("session"):setup({
	sync_yanked = true,
})

ps.sub("ind-app-title", function(args)
	local cwd = tostring(cx.active.current.cwd):match("([^/]+)$")
	args.value = "yazi " .. cwd
	return args
end)

for _, id in ipairs({ 1, 2, 3 }) do
	Status:children_remove(id, Status.LEFT)
end

for _, id in ipairs({ 4, 5, 6 }) do
	Status:children_remove(id, Status.RIGHT)
end

Status:children_add(function(self)
	local h = self._current.hovered
	return h and ui.Line { " ", ui.Span(ui.printable(h.name)):style(th.status.overall) } or ""
end, 1000, Status.LEFT)

require("git"):setup()
