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
    sudo apt install -y git kitty tmux zsh rsync htop bat fzf python3 unzip fd-find wget ripgrep clang nodejs npm golang python3-pip python3-venv silversearcher-ag
    echo "Please install lf and lsd manually if you want"
  else
    sudo apt install -y git kitty tmux zsh lf rsync htop bat fzf python3 unzip fd-find lsd wget ripgrep clang nodejs npm golang python3-pip python3-venv silversearcher-ag
  fi
  curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
  wget https://github.com/neovim/neovim-releases/releases/download/stable/nvim.appimage 
  mv nvim.appimage ~/.local/bin
  sudo ln -s -f /usr/bin/batcat /usr/bin/bat
  sudo ln -s -f /usr/bin/fdfind /usr/bin/fd
  sudo ln -s -f /usr/bin/python3 /usr/bin/python
fi

if [ -f /etc/arch-release ]; then
  echo "Detect Arch based system, installing packages with pacman..."
  sudo pacman -Sy
  sudo pacman -S --needed --noconfirm kitty git tmux zsh lf rsync htop bat python fzf unzip zoxide lsd fd wget ripgrep neovim glow clang nodejs npm go the_silver_searcher
fi

if [ $(uname -s) = "Darwin" ]; then
  echo "Detect macOS, installing packages with homebrew..."
  brew update
  brew install git tmux zsh lf kitty rsync htop bat python fzf unzip zoxide lsd fd wget ripgrep neovim glow clang npm nodejs go the_silver_searcher
fi

# git submodule init
# git submodule update
git submodule update --init --recursive

BASEDIR=~/.config
read -p "Do you want to overwrite or backup the configuration file? (o/b): " response

if [ "$response" == "o" ]; then
  echo "Overwriting the configuration file..."
  yes | rm -r $BASEDIR/tmux
  rm ~/.zshrc
  yes | rm -r $BASEDIR/zsh
  yes | rm -r $BASEDIR/lf
  yes | rm -r $BASEDIR/nvim
  cp -r ./tmux $BASEDIR/
  cp -r ./zsh/zsh $BASEDIR/
  cp -r ./zsh/zshrc ~/.zshrc
  cp -r ./lf $BASEDIR/
  cp -r ./nvim $BASEDIR/
  cp -r ./kitty $BASEDIR/
elif [ "$response" == "b" ]; then
  echo "Backup the configuration file..."
  mv $BASEDIR/tmux $BASEDIR/tmux_bak || echo "$BASEDIR/tmux not found. Skip."
  mv $BASEDIR/zsh $BASEDIR/zsh_bak || echo "$BASEDIR/zsh not found. Skip."
  mv ~/.zshrc ~/.zshrc_bak || echo "~/.zshrc not found. Skip."
  mv $BASEDIR/lf $BASEDIR/lf_bak || echo "$BASEDIR/lf not found. Skip."
  mv $BASEDIR/nvim $BASEDIR/nvim_bak || echo "$BASEDIR/nvim not found. Skip."
  mv $BASEDIR/kitty $BASEDIR/kitty_bak || echo "$BASEDIR/kitty not found. Skip."
  cp -r ./tmux $BASEDIR/
  cp -r ./zsh/zsh $BASEDIR/
  cp -r ./zsh/zshrc ~/.zshrc
  cp -r ./lf $BASEDIR/
  cp -r ./nvim $BASEDIR/
  cp -r ./kitty $BASEDIR/
else
  echo "Invalid response. Please enter 'o' or 'b'."
  exit 1
fi

zsh -i -c "znap pull;echo 'zsh plugins installed!';exit"
nvim --headless "+Lazy! sync" +qa
nvim --headless "+MasonToolsInstallSync" +qa
nvim --headless "+TSUpdateSync" +qa
