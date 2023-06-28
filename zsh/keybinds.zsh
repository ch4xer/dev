
# keybindings must be provided after plugin source
bindkey -e
# set title
bindkey '\er' filemanager
bindkey '\ef' cd_fzf
bindkey '\eF' cd_fzf_from_home
bindkey '\eo' open_fzf
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# in tmux, I can only use alt-backspace
bindkey '^H' backward-kill-word
