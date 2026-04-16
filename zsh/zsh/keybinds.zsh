# keybindings must be provided after plugin source
# disable vim mode
bindkey -v
bindkey -M viins '^[' empty
bindkey '^R' yy
bindkey '^E' filemanager_gui
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[[Z' reverse-menu-complete
bindkey "^H" backward-kill-word

# Fix cursor not being able to move across lines in multi-line commands
bindkey '^[[D' backward-char
bindkey '^[[C' forward-char
bindkey '^[[A' up-line-or-history
bindkey '^[[B' down-line-or-history

# Improve Backspace and Delete behavior across lines
bindkey '^?' backward-delete-char
bindkey '^[[3~' delete-char
