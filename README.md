# Personal Development Toolkit

<!--toc:start-->

- [Personal Development Toolkit](#personal-development-toolkit)
  - [Introduction](#introduction)
  - [Install](#install)
  <!--toc:end-->

## Introduction

This repo contains my configuration of kitty, tmux, zsh and neovim.

## Install

```bash
# make sure you have kitty, tmux, neovim(nightly) installed
git clone https://github.com/ch3n9w/dev
cd dev
./scripts/install.sh
```

## Upgrade

### Upgrade software

```bash
# upgrade tmux by package manager
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
