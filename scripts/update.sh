rm -r nvim
yes | rm -r zsh
rm -r alacritty
rm -r ranger
rm -r tmux
cp -r ~/.config/nvim/ ./
cp -r ~/.config/alacritty/ ./
cp -r ~/.config/ranger/ ./
cp -r ~/.config/tmux/ .
mkdir zsh
cp -r ~/.config/zsh/ ./zsh/
cp -r ~/.zshrc ./zsh/zshrc
cp -r ~/.config/fontconfig/ ./
