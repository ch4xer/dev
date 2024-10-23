filemanager() {
    tmp="$(mktemp)"
    lf --last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
                zoxide add "$dir"
                zle reset-prompt
            fi
        fi
    fi
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

zle -N filemanager
zle -N filemanager_gui
zle -N empty
