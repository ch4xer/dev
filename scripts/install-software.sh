#!/bin/bash

# set -ex

if [ $(uname -s) = "Linux" ]; then
  if ! sudo -v &>/dev/null; then
    echo "Failed to execute sudo. Make sure you have sudo privileges."
    exit 1
  fi
fi

if [ "$(cat /etc/lsb-release | grep DISTRIB_ID | cut -d '=' -f 2)" = "Ubuntu" ]; then
  echo "Detect Ubuntu, installing packages with apt..."
  sudo apt update
  sudo apt install -y git kitty zsh rsync htop bat fzf python3 unzip fd-find lsd wget ripgrep clang nodejs npm golang python3-pip python3-venv zoxide rust-all
  wget https://github.com/neovim/neovim-releases/releases/download/stable/nvim-linux-x86_64.appimage
  mkdir -p ~/.local/bin/
  mv nvim-linux-x86_64.appimage ~/.local/bin/nvim
  chmod +x ~/.local/bin/nvim
  sudo ln -s -f /usr/bin/batcat /usr/bin/bat
  sudo ln -s -f /usr/bin/fdfind /usr/bin/fd
  sudo ln -s -f /usr/bin/python3 /usr/bin/python
  # install yazi
  cargo install --locked yazi-fm yazi-cli

  touch ~/.zshenv
  echo "skip_global_compinit=1" >>~/.zshenv
fi

if [ -f /etc/arch-release ]; then
  echo "Detect Arch based system, installing packages with pacman..."
  sudo pacman -Sy
  sudo pacman -S --needed --noconfirm kitty git zsh rsync htop bat python fzf unzip zoxide lsd fd wget ripgrep neovim glow clang nodejs npm go yazi ffmpegthumbnailer ffmpeg p7zip jq poppler imagemagick
fi

# git submodule init
# git submodule update
git submodule update --init --recursive

BASEDIR=~/.config
read -p "Do you want to overwrite or backup the configuration file? (o/b): " response

if [ "$response" == "o" ]; then
  echo "Overwriting the configuration file..."
  yes | rm -r $BASEDIR/zsh
  yes | rm -r $BASEDIR/yazi
  yes | rm -r $BASEDIR/nvim
elif [ "$response" == "b" ]; then
  echo "Backup the configuration file..."
  mv $BASEDIR/zsh $BASEDIR/zsh_bak || echo "$BASEDIR/zsh not found. Skip."
  mv ~/.zshrc ~/.zshrc_bak || echo "~/.zshrc not found. Skip."
  mv ~/.zimrc ~/.zimrc_bak || echo "~/.zimrc not found. Skip."
  mv $BASEDIR/yazi $BASEDIR/yazi_bak || echo "$BASEDIR/yazi not found. Skip."
  mv $BASEDIR/nvim $BASEDIR/nvim_bak || echo "$BASEDIR/nvim not found. Skip."
  mv $BASEDIR/kitty $BASEDIR/kitty_bak || echo "$BASEDIR/kitty not found. Skip."
else
  echo "Invalid response. Please enter 'o' or 'b'."
  exit 1
fi

cp -r ./zsh/zsh $BASEDIR/zsh/
cp ./zsh/zshrc ~/.zshrc
cp ./zsh/zimrc ~/.zimrc
cp -r ./yazi $BASEDIR/
cp -r ./nvim $BASEDIR/
cp -r ./kitty $BASEDIR/

zsh -i -c "zimfw install"
zsh -i -c "nvim --headless '+Lazy! sync' +qa"
