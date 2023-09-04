# Personal Development Toolkit 📡

![wallpaper](./wallpaper.png)

## Introduction

This repo contains my configuration of alacritty, tmux, ranger, zsh and neovim.

## Install

```bash
git clone https://github.com/ch3n9w/dev
cd dev
./scripts/install.sh
```

## Noteable Info

### Alacritty

1. use Firacode Nerd Font, Victor Mono Nerd Font and LXGW WenKai, see `fontconfig/fonts.conf`
2. define some keybindings to pass through to tmux, see `alacritty/alacritty.yml`

### Tmux

1. all keybindings does not require prefix key
2. Ctrl-hjkl and Ctrl-q can be used both in tmux and vim for window operations
3. use tmux-continuum and resurrect to restore workspaces
4. If you're using a window manager, you may get dizzy remembering shortcuts, in that case, I recommend you to forgive tmux and use your window manager to manage windows

### Zsh

1. it contains some useless alias for Personal use, you can delete them.

### Neovim

1. most keybindings are in `nvim/lua/keymap/init.lua`, some keybindings are in `cmp.lua`, `filetree.lua`, `dashboard.lua`, and `lspsaga.lua`
2. I write golang and python often, but not rust, even though my configuration include related lsp
3. neovim nightly is unstable, so keep caution when you use it

### Other

Highly recommended to install caps2esc, it's a great tool to remap capslock to esc and ctrl, see [caps2esc](https://gitlab.com/interception/linux/plugins/caps2esc)
