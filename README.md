# Development Toolkit 📡

A comprehensive and user-friendly development toolkit to boost up your productivity 🚀.

![Screenshot](https://ch3n9w.github.io/posts/tech-dev-2024/cover.png)

- terminal emulator: [kitty](https://github.com/kovidgoyal/kitty)
- shell: [zsh](https://www.zsh.org/)
- editor: [neovim](https://github.com/neovim/neovim)
- terminal filemanager: [yazi](https://github.com/sxyazi/yazi)
- multiplexers: [tmux](https://github.com/tmux/tmux) or [kitty](https://github.com/kovidgoyal/kitty)

## Try

```bash
docker run -it --rm --name dev ch4xer/dev:latest /bin/zsh
```

## Install

```bash
git clone https://github.com/ch3n9w/dev
cd dev
# install dependency software and install configuration
./scripts/install-software.sh
```

Alternatively (if you dont want to install all of them), you can copy the configuration directory you like to `XDG_CONFIG_HOME` (commonly `~/.config`), for example:

```
nvim -> ~/.config/nvim
kitty -> ~/.config/kitty
tmux -> ~/.config/tmux
yazi -> ~/.config/yazi
zsh/zsh -> ~/.config/zsh
zsh/zshrc -> ~/.zshrc
```

## Noteable Info

- Kitty
  - use `Ctrl` and `Shift` as modifier key for all shortcuts
  - use JetbrainMono Nerd Font and LXGW WenKai as font
- Tmux
  - use `Alt` and `Ctrl` as modifier key for all shortcuts
  - set `Alt-a` as prefix key instead of `Ctrl-b`
  - use tmux-continuum and resurrect to restore sessions.
- Zsh
  - you can add software settings in `zsh/zsh/software`
  - disable vim mode.
- Neovim
  - Only use <=30 plugins to make Neovim tiny and good enough for editing

## Keymap

| Software |      Key       |                Effect                 |
| :------: | :------------: | :-----------------------------------: |
|  kitty   |      C-t       |                new tab                |
|  kitty   |      C-CR      |              new window               |
|  kitty   |      C-w       |             delete window             |
|  kitty   |   C-h/j/k/l    |          focus other window           |
|  kitty   |  C-S-h/j/k/l   |              move window              |
|  kitty   |  C-PgUp/PgDn   |            goto other tab             |
|  kitty   | C-S-PgUp/PgDn  |               move tab                |
|  kitty   |     C-=/-      |           adjust font size            |
|  kitty   |       f1       |            search content             |
|  kitty   |      f11       |              toggle zoom              |
|   zsh    |      C-r       |           call filemanager            |
|   zsh    |      C-e       |         open filemanager-gui          |
|   zsh    |  C-Backspace   |         delete word backward          |
|   yazi   |       gh       |            go to home (~)             |
|   yazi   |       gd       |           go to ~/Documents           |
|   yazi   |       gn       |           go to ~/Downloads           |
|   yazi   |      H/L       | go to previous/next visited directory |
|   yazi   |       a        |            create file/dir            |
|   yazi   |       r        |       rename file or directory        |
|   yazi   |       .        |           show hidden file            |
|   yazi   |       ;        |         execute shell command         |
|   yazi   |       y        |                 copy                  |
|   yazi   |       d        |                  cut                  |
|   yazi   |       p        |                 paste                 |
|   yazi   |       D        |             move to trash             |
|   yazi   |     Delete     |                  rm                   |
|   yazi   |       f        |       search and jump with fzf        |
|   yazi   |       z        |           jump with zoxide            |
|   tmux   |      M-a       |              prefix key               |
|   tmux   |   M-h/j/k/l    |           go to other pane            |
|   tmux   |      M-q       |               kill pane               |
|   tmux   |    M-C-j/k     |         swap with other panes         |
|   tmux   |      M-x       |       split window horizontally       |
|   tmux   |     M-C-x      |        split window vertically        |
|   tmux   |      M-f       |              toggle zoom              |
|   tmux   |      M-t       |           create new window           |
|   tmux   |     M-C-t      |             rename window             |
|   tmux   |  M-PgUp/PgDn   |      go to previous/next window       |
|   tmux   | M-C-PgUp/PgDn  |    swap with previous/next window     |
|   tmux   |      M-s       |            choose session             |
|   tmux   |     M-C-s      |            rename session             |
|   tmux   |      M-n       |          create new session           |
|  neovim  |       q        |          quit window/neovim           |
|  neovim  |       Q        |             record macro              |
|  neovim  |      C-a       |       select all (normal mode)        |
|  neovim  |      H/L       |      go to the begin/end of line      |
|  neovim  |      Tab       |         move to other window          |
|  neovim  |       ;        |        enter commandline mode         |
|  neovim  |       g=       |            format document            |
|  neovim  | 2-LeftMouse/CR |              toggle fold              |
|  neovim  |       sw       |           fuzzy search word           |
|  neovim  |       sf       |         fuzzy search filename         |
|  neovim  |       z        |      fuzzy search opened buffers      |
|  neovim  |       ga       |           (lsp) code action           |
|  neovim  |       ge       |    (lsp) show diagnostics in line     |
|  neovim  |       gh       |          (lsp) get document           |
|  neovim  |       gn       |          (lsp) rename symbol          |
|  neovim  |       gd       |        (lsp) go to definition         |
|  neovim  |       gr       |         (lsp) find reference          |
|  neovim  |      C-/       |             comment line              |
|  neovim  |       f        |              flash jump               |
|  neovim  |   Tab/S-Tab    |           code completions            |
|  neovim  |       t        |               File Tree               |
