# make powerlevel10k at first, use instant prompt to load other plugins later
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
PLUGIN_HOME=$XDG_CONFIG_HOME/zsh/plugins
source $PLUGIN_HOME/powerlevel10k/powerlevel10k.zsh-theme
source $PLUGIN_HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $PLUGIN_HOME/zsh-extract/extract.plugin.zsh
source $PLUGIN_HOME/zsh-history-substring-search/zsh-history-substring-search.zsh
source $PLUGIN_HOME/zsh-autosuggestions/zsh-autosuggestions.zsh
source $PLUGIN_HOME/zsh-autoswitch-virtualenv/autoswitch_virtualenv.plugin.zsh
source $PLUGIN_HOME/zsh-autocomplete/zsh-autocomplete.plugin.zsh

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
