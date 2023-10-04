# Personal Development Toolkit 📡

![wallpaper](./wallpaper.png)

## Introduction

This repo contains my configuration of kitty, tmux, ranger, zsh and neovim.

## Install

```bash
git clone https://github.com/ch3n9w/dev
cd dev
# if you want to install in desktop environment
./scripts/install-desktop.sh
# if you only want to install in server environment
./scripts/install-server.sh
```

## Noteable Info

### Kitty

1. use Firacode Nerd Font and Victor Mono Nerd Font

### Tmux

1. all keybindings does not require prefix key, which can still be used though.
2. Ctrl-hjkl and Ctrl-q can be used both in tmux and vim for window operations.
3. use tmux-continuum and resurrect to restore workspaces.
4. If you get dizzy remembering shortcuts, just use your mouse.

### Zsh

1. it contains some useless alias for Personal use, you can delete them.

### Neovim

1. most keybindings are in `nvim/lua/keymap/init.lua`, some keybindings are in `cmp.lua`, `filetree.lua`, `dashboard.lua`, `lspsaga.lua`, `treesitter.lua` and `surround.lua`
2. I write golang and python often, but not rust, even though my configuration include related lsp

### Other

Highly recommended to install key, it's a great tool to remap capslock to esc and ctrl, see [keyd](https://github.com/rvaiya/keyd)
