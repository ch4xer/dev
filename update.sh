rsync -av --delete ~/.config/tmux/ ./tmux/
rsync -av --delete ~/.config/zellij/ ./zellij/
rsync -av --delete ~/.config/nvim/ ./nvim/
rsync -av --delete ~/.config/alacritty/ ./alacritty/
rsync -av --delete ~/.config/kitty/ ./kitty/
rsync -av --delete ~/.config/zsh/ ./zsh/
rsync -a ~/.zshrc ./zshrc

git submodule add https://github.com/romkatv/powerlevel10k zsh/plugins/powerlevel10k
git submodule add https://github.com/zsh-users/zsh-autosuggestions zsh/plugins/zsh-autosuggestions
git submodule add https://github.com/MichaelAquilina/zsh-autoswitch-virtualenv.git zsh/plugins/zsh-autoswitch-virtualenv
git submodule add https://github.com/le0me55i/zsh-extract.git zsh/plugins/zsh-extract
git submodule add https://github.com/zsh-users/zsh-history-substring-search zsh/plugins/zsh-history-substring-search
git submodule add https://github.com/zsh-users/zsh-syntax-highlighting zsh/plugins/zsh-syntax-highlighting
git submodule add https://github.com/tmux-plugins/tpm tmux/plugins/tpm
git submodule add https://github.com/tmux-plugins/tmux-sensible tmux/plugins/tmux-sensible
git submodule add https://github.com/tmux-plugins/tmux-yank tmux/plugins/tmux-yank
git submodule add https://github.com/tmux-plugins/tmux-net-speed tmux/plugins/tmux-net-speed
git submodule add https://github.com/christoomey/vim-tmux-navigator tmux/plugins/vim-tmux-navigator
git submodule add https://github.com/tmux-plugins/tmux-resurrect tmux/plugins/tmux-resurrect
git submodule add https://github.com/tmux-plugins/tmux-continuum tmux/plugins/tmux-continuum

yes | rm -r tmux/plugins/*
yes | rm -r zsh/plugins/*

