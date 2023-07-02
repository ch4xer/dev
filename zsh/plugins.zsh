source $XDG_CONFIG_HOME/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $XDG_CONFIG_HOME/zsh/plugins/zsh-extract/extract.plugin.zsh
source $XDG_CONFIG_HOME/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source $XDG_CONFIG_HOME/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $XDG_CONFIG_HOME/zsh/plugins/zsh-autoswitch-virtualenv/autoswitch_virtualenv.plugin.zsh
source $XDG_CONFIG_HOME/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme

autoload -U compinit; compinit

# fix case error
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# set completion color
zstyle ':completion:*:default' list-colors '=(#b)(-*)(-- *)===34' '=(#b)(-- *)=34'
# zstyle ':completion:*' list-colors '=*=34'
zstyle ':completiom:*' list-colors 'di=1:fi=96:*.m=31:*.py=32:*.txt=36:*.out=35'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}  

HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=bg=#d33682,fg=#002b36

HISTORY_SUBSTRING_SEARCH_PREFIXED=1
setopt HIST_FIND_NO_DUPS

# custom os_icon
# typeset -g POWERLEVEL9K_OS_ICON_CONTENT_EXPANSION='⭐'
