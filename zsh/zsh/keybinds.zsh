# keybindings must be provided after plugin source
# disable vim mode
bindkey -v
bindkey -M viins '^[' empty
bindkey '^R' filemanager
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[[Z' reverse-menu-complete
bindkey '\t' menu-select "$terminfo[kcbt]" menu-select
bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete
bindkey "^?" backward-delete-char
