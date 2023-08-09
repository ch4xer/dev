# Personal Development Toolkit 📡

## Introduction

This repo contains my configuration of kitty, tmux, ranger, zsh and neovim.

## Install

```bash
# make sure you have kitty, tmux, ranger, neovim(nightly) installed
git clone https://github.com/ch3n9w/dev
cd dev
./scripts/install.sh
```

## Upgrade

### Upgrade software

```bash
# upgrade tmux and ranger by package manager
# upgrade kitty
./scripts/kitty-upgrade.sh
# upgrade neovim
./scripts/neovim-upgrade.sh
```

### Upgrade configuration

```bash
git pull
./scripts/install.sh
```
