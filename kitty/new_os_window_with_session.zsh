#!/usr/bin/env zsh
# Open an OS window with the current window's CWD, then copy its session name.

source_os_window_id=$(kitty @ ls --self | grep -o '"id": *[0-9]*' | head -1 | grep -o '[0-9]*$')
[[ -n "$source_os_window_id" ]] || exit 1

name_file="/tmp/kitty-session-$KITTY_PID-$source_os_window_id"
name=$(<"$name_file") 2>/dev/null || name=''

# --copy-env in the key mapping provides the source KITTY_WINDOW_ID here.
# Use it explicitly for both the working directory and the new OS window.
new_window_id=$(kitty @ launch --type=os-window --cwd=current --source-window "id:$KITTY_WINDOW_ID") || exit 1
target_os_window_id=$(kitty @ ls --match "id:$new_window_id" | grep -o '"id": *[0-9]*' | head -1 | grep -o '[0-9]*$')
[[ -n "$target_os_window_id" ]] || exit 1

[[ -n "$name" ]] && print -rn -- "$name" > "/tmp/kitty-session-$KITTY_PID-$target_os_window_id"
