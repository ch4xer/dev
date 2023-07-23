# https://github.com/ajeetdsouza/zoxide/issues/403
eval "$(zoxide init zsh --cmd cd)"
source <(kubectl completion zsh)
# todo.sh list
