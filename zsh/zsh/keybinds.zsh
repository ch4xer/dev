# keybindings must be provided after plugin source
# disable vim mode
bindkey -v
bindkey -M viins '^[' empty
bindkey '^R' filemanager
bindkey '^E' filemanager_gui
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[[Z' reverse-menu-complete
bindkey "^H" backward-kill-word
