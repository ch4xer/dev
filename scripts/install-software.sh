#!/bin/bash

# set -ex

if [ $(uname -s) = "Linux" ]; then
  if ! sudo -v &>/dev/null; then
    echo "Failed to execute sudo. Make sure you have sudo privileges."
    exit 1
  fi
fi

if [ -f /etc/debian_version ]; then
  echo "Detect Debian based system, installing packages with apt..."
  sudo apt update
  if [ "$(cat /etc/lsb-release | grep DISTRIB_ID | cut -d '=' -f 2)" = "Ubuntu" ]; then
    sudo apt install -y git kitty zsh rsync htop bat fzf python3 unzip fd-find wget ripgrep clang nodejs npm golang python3-pip python3-venv
    echo "Please install lsd manually if you want"
  else
    sudo apt install -y git kitty zsh rsync htop bat fzf python3 unzip fd-find lsd wget ripgrep clang nodejs npm golang python3-pip python3-venv
  fi
  curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
  wget https://github.com/neovim/neovim-releases/releases/download/stable/nvim-linux-x86_64.appimage
  mv nvim-linux-x86_64.appimage ~/.local/bin/nvim
  chmod +x ~/.local/bin/nvim
  sudo ln -s -f /usr/bin/batcat /usr/bin/bat
  sudo ln -s -f /usr/bin/fdfind /usr/bin/fd
  sudo ln -s -f /usr/bin/python3 /usr/bin/python
  # install yazi
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  rustup update
  cargo install --locked yazi-fm yazi-cli
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
  rm ~/.zshrc
  yes | rm -r $BASEDIR/zsh
  yes | rm -r $BASEDIR/yazi
  yes | rm -r $BASEDIR/nvim
  cp -r ./zsh/zsh $BASEDIR/
  cp -r ./zsh/zshrc ~/.zshrc
  cp -r ./yazi $BASEDIR/
  cp -r ./nvim $BASEDIR/
  cp -r ./kitty $BASEDIR/
elif [ "$response" == "b" ]; then
  echo "Backup the configuration file..."
  mv $BASEDIR/zsh $BASEDIR/zsh_bak || echo "$BASEDIR/zsh not found. Skip."
  mv ~/.zshrc ~/.zshrc_bak || echo "~/.zshrc not found. Skip."
  mv $BASEDIR/yazi $BASEDIR/yazi_bak || echo "$BASEDIR/yazi not found. Skip."
  mv $BASEDIR/nvim $BASEDIR/nvim_bak || echo "$BASEDIR/nvim not found. Skip."
  mv $BASEDIR/kitty $BASEDIR/kitty_bak || echo "$BASEDIR/kitty not found. Skip."
  cp -r ./zsh/zsh $BASEDIR/
  cp -r ./zsh/zshrc ~/.zshrc
  cp -r ./zsh/zimrc ~/.zimrc
  cp -r ./yazi $BASEDIR/
  cp -r ./nvim $BASEDIR/
  cp -r ./kitty $BASEDIR/
else
  echo "Invalid response. Please enter 'o' or 'b'."
  exit 1
fi

zsh -i -c "zimfw install"
nvim --headless "+Lazy! sync" +qa
