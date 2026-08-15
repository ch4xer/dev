#!/usr/bin/env zsh
# Prompt for a session name in an overlay window. Enter submits the name,
# Esc or Ctrl+C cancels without changing the current session name.

stty -isig -echo 2>/dev/null
printf 'Session name: '
name=''
while read -rk 1 c; do
    case "$c" in
        $'\x1b' | $'\x03')
            exit 130
            ;;
        $'\n' | $'\r')
            print
            break
            ;;
        $'\x7f' | $'\x08')
            if [[ -n "$name" ]]; then
                name="${name%?}"
                printf '\b \b'
            fi
            ;;
        *)
            name+="$c"
            printf '%s' "$c"
            ;;
    esac
done
stty isig echo 2>/dev/null

id=$(kitty @ ls --self | grep -o '"id": *[0-9]*' | head -1 | grep -o '[0-9]*$')
printf '%s' "$name" > "/tmp/kitty-session-$KITTY_PID-$id"
