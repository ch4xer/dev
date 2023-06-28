
# export FZF_DEFAULT_OPTS="--height 80% --layout=reverse --border --history=$HOME/.local/share/fzf/fzfhistory --preview 'bat --style=numbers --color=always --line-range :500 {}'"
export FZF_DEFAULT_OPTS="--height 80% --layout=reverse --border --history=$HOME/.local/share/fzf/fzfhistory --preview '$HOME/Tools/Other/fzf-scope.sh {}'"
export FZF_DEFAULT_COMMAND="fd --exclude={.wine,.git,.idea,.vscode,.sass-cache,node_modules,build,.local,.steam,.m2,.rangerdir,.ssh,.ghidra,.mozilla,.cache} --type f --hidden --follow"
