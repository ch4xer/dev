# Development Toolkit 📡

A comprehensive and user-friendly development toolkit to boost up your productivity 🚀.

- terminal emulator: [kitty](https://github.com/kovidgoyal/kitty)
- shell: [zsh](https://www.zsh.org/) + [starship](https://github.com/starship/starship)
- editor: [neovim](https://github.com/neovim/neovim)
- terminal filemanager: [lf](https://github.com/gokcehan/lf)
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
lf -> ~/.config/lf
zsh/zsh -> ~/.config/zsh
zsh/zshrc -> ~/.zshrc
starship/starship.toml -> ~/.config/starship.toml
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
|   zsh    |      C-r       |        execute lf filemanager         |
|   zsh    |      C-e       |         open filemanager-gui          |
|   zsh    |  C-Backspace   |         delete word backward          |
|    lf    |       gh       |            go to home (~)             |
|    lf    |       gd       |           go to ~/Documents           |
|    lf    |       gn       |           go to ~/Downloads           |
|    lf    |      H/L       | go to previous/next visited directory |
|    lf    |       a        |                 mkdir                 |
|    lf    |       t        |                 touch                 |
|    lf    |       r        |       rename file or directory        |
|    lf    |       o        |       open with custom software       |
|    lf    |       .        |           show hidden file            |
|    lf    |       ;        |         execute shell command         |
|    lf    |       y        |                 copy                  |
|    lf    |       d        |                  cut                  |
|    lf    |       p        |                 paste                 |
|    lf    |       D        |             move to trash             |
|    lf    |     Delete     |                  rm                   |
|    lf    |       f        |        fuzzy search using fzf         |
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
