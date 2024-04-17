#!/bin/bash

if [ "$(id -u)" -eq 0 ]; then
    echo "Current user is root, check passed"
else
    echo "switch to root..."
    if sudo -s true; then
        echo "switch to root successfully."
    else
        echo "Failed to switch to root."
        exit 1
    fi
fi


if [ -f /etc/debian_version ]; then
  echo "Detect Debian based system, installing packages with apt..."
  apt update
  apt install -y git tmux zsh lf ranger rsync htop bat fzf python3 unzip fd-find lsd wget ripgrep neovim todotxt-cli clang nodejs
  curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
  ln -s /usr/bin/batcat /usr/bin/bat
  ln -s /usr/bin/fdfind /usr/bin/fd
  ln -s /usr/bin/python3 /usr/bin/python
  echo "Please install glow and kitty manually if you want"
fi

if [ -f /etc/arch-release ]; then
  echo "Detect Arch based system, installing packages with pacman..."
  pacman -Sy
  pacman -S --needed --noconfirm git tmux zsh lf ranger rsync htop bat python fzf unzip zoxide lsd fd wget ripgrep neovim glow clang nodejs
  echo "Please install todotxt-cli and kitty if you want."
fi

# git submodule init
# git submodule update
git submodule update --init --recursive

BASEDIR=~/.config
read -p "Do you want to overwrite or backup the configuration file? (o/b): " response

if [ "$response" == "o" ]; then
    echo "Overwriting the configuration file..."
    yes | rm -r $BASEDIR/tmux
    yes | rm -r $BASEDIR/zsh
    yes | rm -r $BASEDIR/lf
    yes | rm -r $BASEDIR/todo
    yes | rm -r $BASEDIR/nvim
    cp -r ./tmux $BASEDIR/
    cp -r ./zsh/zsh $BASEDIR/
    cp -r ./zsh/zshrc ~/.zshrc
    cp -r ./lf $BASEDIR/
    cp -r ./todo $BASEDIR/
    cp -r ./nvim $BASEDIR/
elif [ "$response" == "b" ]; then
    echo "Backup the configuration file..."
    mv $BASEDIR/tmux $BASEDIR/tmux_bak
    mv $BASEDIR/zsh $BASEDIR/zsh_bak
    mv ~/.zshrc ~/.zshrc_bak
    mv $BASEDIR/lf $BASEDIR/lf_bak
    mv $BASEDIR/todo $BASEDIR/todo_bak
    mv $BASEDIR/nvim $BASEDIR/nvim_bak
    cp -r ./tmux $BASEDIR/
    cp -r ./zsh/zsh $BASEDIR/
    cp -r ./zsh/zshrc ~/.zshrc
    cp -r ./lf $BASEDIR/
    cp -r ./todo $BASEDIR/
    cp -r ./nvim $BASEDIR/
else
    echo "Invalid response. Please enter 'o' or 'b'."
    exit 1
fi
