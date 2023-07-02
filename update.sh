rsync -av --delete ~/.config/tmux/ ./tmux/
rsync -av --delete ~/.config/nvim/ ./nvim/
rsync -av --delete ~/.config/alacritty/ ./alacritty/
rsync -av --delete ~/.config/zsh/ ./zsh/
rsync -a ~/.zshrc ./zshrc

# Install zsh plugins
git clone --depth=1 https://github.com/romkatv/powerlevel10k ./zsh/plugins/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ./zsh/plugins/zsh-autosuggestions
git clone https://github.com/MichaelAquilina/zsh-autoswitch-virtualenv.git ./zsh/plugins/zsh-autoswitch-virtualenv
git clone https://github.com/le0me55i/zsh-extract.git ./zsh/plugins/zsh-extract
git clone https://github.com/zsh-users/zsh-history-substring-search ./zsh/plugins/zsh-history-substring-search
git clone https://github.com/zsh-users/zsh-syntax-highlighting ./zsh/plugins/zsh-syntax-highlighting

