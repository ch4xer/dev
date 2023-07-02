BASEDIR=~/.config
rm -r ~/.config/alacritty
yes | rm -r ~/.config/tmux
rm -r ~/.config/nvim
rm -r ~/.config/zsh
rm -r ~/.zshrc

cp -r ./nvim ~/.config/
cp -r ./tmux ~/.config/
cp -r ./alacritty ~/.config/
cp -r ./zsh ~/.config/
cp -r ./zshrc ~/.zshrc

