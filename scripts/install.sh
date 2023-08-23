if [ -f /etc/debian_version ]; then
  apt update
  apt install -y tmux zsh ranger kitty rsync htop bat fzf git python3 unzip fd-finder exa
  curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
  ln -s /usr/bin/batcat /usr/bin/bat
  ln -s /usr/bin/python3 /usr/bin/python
  wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
  chmod u+x nvim.appimage
  mv nvim.appimage /usr/bin/nvim
fi

if [ -f /etc/arch-release ]; then
  pacman -S tmux zsh ranger kitty rsync htop bat git python fzf unzip zoxide exa fd
  wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
  chmod u+x nvim.appimage
  mv nvim.appimage /usr/bin/nvim
fi

git submodule init
git submodule update

BASEDIR=~/.config
rm -r $BASEDIR/kitty
yes | rm -r $BASEDIR/tmux
yes | rm -r $BASEDIR/zsh
yes | rm -r $BASEDIR/ranger
cp -r ./tmux ~/.config/
cp -r ./kitty ~/.config/
cp -r ./zsh/zsh ~/.config/
cp -r ./zsh/zshrc ~/.zshrc
cp -r ./ranger ~/.config/ranger

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

FONT_FILE1=/usr/share/fonts/TTF/FiraCodeNerdFont-Regular.ttf
FONT_FILE2=/usr/share/fonts/FiraCode/FiraCodeNerdFont-Regular.ttf
FONT='https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraCode.zip'
if [ -f "$FONT_FILE1" ]; then
  echo "FiraCodeNerdFont-Regular.ttf already exists."
elif [ -f "$FONT_FILE2" ]; then
  echo "FiraCodeNerdFont-Regular.ttf already exists."
else
  echo "Downloading FiraCodeNerdFont-Regular.ttf..."
  wget $FONT
  unzip FiraCode.zip
  mkdir -p /usr/share/fonts/FiraCode
  cp ./FiraCode/*.ttf /usr/share/fonts/FiraCode
  rm -r ./FiraCode
  rm ./FiraCode.zip
  fc-cache -fv
  rm FiraCodeNerdFont*.ttf
fi
