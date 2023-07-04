git submodule init zsh/plugins/powerlevel10k
git submodule init zsh/plugins/zsh-autosuggestions
git submodule init zsh/plugins/zsh-autoswitch-virtualenv
git submodule init zsh/plugins/zsh-extract
git submodule init zsh/plugins/zsh-history-substring-search
git submodule init zsh/plugins/zsh-syntax-highlighting
git submodule init tmux/plugins/tpm
git submodule init tmux/plugins/tmux-sensible
git submodule init tmux/plugins/tmux-yank
git submodule init tmux/plugins/tmux-net-speed
git submodule init tmux/plugins/vim-tmux-navigator
git submodule init tmux/plugins/tmux-resurrect
git submodule init tmux/plugins/tmux-continuum
git submodule update

BASEDIR=~/.config
rm -r $BASEDIR/alacritty
yes | rm -r $BASEDIR/tmux
yes | rm -r $BASEDIR/zsh
rm -r ~/.zshrc
cp -r ./tmux ~/.config/
cp -r ./alacritty ~/.config/
cp -r ./kitty ~/.config/
cp -r ./zsh ~/.config/
cp -r ./zshrc ~/.zshrc

license=$BASEDIR/nvim/intelephense_license_key
if [ -e "$license" ]; then
  content=$(cat $license)
  rm -r $BASEDIR/nvim
  cp -r ./nvim ~/.config/
  echo $content > $BASEDIR/nvim/intelephense_license_key
else
  rm -r $BASEDIR/nvim
  cp -r ./nvim ~/.config/
fi

