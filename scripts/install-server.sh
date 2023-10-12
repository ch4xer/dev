#!/bin/bash

if sudo -n true 2>/dev/null; then
    echo "User can run sudo commands, check passed."
else
    echo "User cannot run sudo commands."
    exit 1
fi

if [ -f /etc/debian_version ]; then
  echo "Detect Debian based system, installing packages with apt..."
  sudo apt update
  sudo apt install -y tmux zsh ranger rsync htop bat fzf python3 unzip fd-find lsd wget ripgrep neovim
  curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
  sudo ln -s /usr/bin/batcat /usr/bin/bat
  sudo ln -s /usr/bin/fdfind /usr/bin/fd
  sudo ln -s /usr/bin/python3 /usr/bin/python
fi

if [ -f /etc/arch-release ]; then
  echo "Detect Arch based system, installing packages with pacman..."
  sudo pacman -S --needed --noconfirm tmux zsh ranger rsync htop bat python fzf unzip zoxide lsd fd wget ripgrep neovim
fi

git submodule init
git submodule update

BASEDIR=~/.config
read -p "Do you want to overwrite the configuration file? (y/n): " response

if [ "$response" == "y" ]; then
    echo "Overwriting the configuration file..."
    yes | rm -r $BASEDIR/tmux
    yes | rm -r $BASEDIR/zsh
    yes | rm -r $BASEDIR/ranger
    cp -r ./tmux ~/.config/
    cp -r ./zsh/zsh ~/.config/
    cp -r ./zsh/zshrc ~/.zshrc
    cp -r ./ranger ~/.config/ranger
    license=$BASEDIR/nvim/intelephense
    if [ -e "$license" ]; then
      content=$(cat $license)
      rm -r $BASEDIR/nvim
      cp -r ./nvim ~/.config/
      echo $content > $BASEDIR/nvim/intelephense_license_key
    else
      rm -r $BASEDIR/nvim
      cp -r ./nvim ~/.config/
    fi
elif [ "$response_lowercase" == "n" ]; then
    echo "Not overwriting the configuration file."
    exit 0
else
    echo "Invalid response. Please enter 'yes' or 'no'."
    exit 1
fi

# NEOVIM_BINARY=/usr/bin/nvim
# if [ -f "$NEOVIM_BINARY" ]; then
#   echo "Neovim already exists, skip..."
# else
#   echo "Downloading Neovim nightly..."
#   rm nvim.appimage.*
#   wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
#   chmod u+x nvim.appimage
#   sudo mv nvim.appimage /usr/bin/nvim
# fi
