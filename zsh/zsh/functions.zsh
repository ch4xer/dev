redraw-prompt() {
  local f
  for f in chpwd "${chpwd_functions[@]}" precmd "${precmd_functions[@]}"; do
    [[ "${+functions[$f]}" == 0 ]] || "$f" &>/dev/null || true
  done
  p10k display -r
}

# filemanager() {
#     tmp="$(mktemp)"
#     lf --last-dir-path="$tmp" "$@"
#     if [ -f "$tmp" ]; then
#         dir="$(cat "$tmp")"
#         rm -f "$tmp"
#         if [ -d "$dir" ]; then
#             if [ "$dir" != "$(pwd)" ]; then
#                 cd "$dir"
#                 zoxide add "$dir"
#                 redraw-prompt
#             fi
#         fi
#     fi
# }

yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
        redraw-prompt
        zoxide add "$cwd"
	fi
	rm -f -- "$tmp"
}

filemanager_gui() {
    xdg-open $(pwd)
}

man() {
    local width=$(tput cols)
    [ $width -gt $MANWIDTH ] && width=$MANWIDTH
    env MANWIDTH=$width \
    man "$@"
}

empty() {
# empty widget for ESC keybinding
}

zle -N yy
zle -N filemanager_gui
zle -N empty
