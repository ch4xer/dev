if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
PLUGIN_HOME=$XDG_CONFIG_HOME/zsh/plugins
[[ -r $PLUGIN_HOME/znap/znap.zsh ]] ||
    git clone --depth 1 -- https://github.com/marlonrichert/zsh-snap.git $PLUGIN_HOME/znap
source $PLUGIN_HOME/znap/znap.zsh

# `znap source` starts plugins.
znap source romkatv/powerlevel10k
znap source zsh-users/zsh-syntax-highlighting
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-history-substring-search
znap source MichaelAquilina/zsh-autoswitch-virtualenv
znap source le0me55i/zsh-extract

# `znap install` adds new commands and completions.
znap install zsh-users/zsh-completions

# fix case error
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# set completion color
zstyle ':completion:*:default' list-colors '=(#b)(-*)(-- *)===34' '=(#b)(-- *)=34'
# zstyle ':completion:*' list-colors '=*=34'
zstyle ':completiom:*' list-colors 'di=1:fi=96:*.m=31:*.py=32:*.txt=36:*.out=35'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}  
zstyle ':completion:*' menu select

HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=bg=#d33682,fg=#002b36

HISTORY_SUBSTRING_SEARCH_PREFIXED=1
setopt HIST_FIND_NO_DUPS

# let zsh-autosuggestions work
export SAVEHIST=100000
export HISTSIZE=100000
export HISTFILESIZE=100000
export HISTFILE=$HOME/.zsh_history
# share history in different terminal
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
