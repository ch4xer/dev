# Personal Development Toolkit 📡

This repo contains my configuration of kitty, tmux, lf, zsh and neovim.

## Try

You can try my configuration in docker container.

```bash
git clone https://github.com/ch3n9w/dev
cd dev
docker build . -t dev:latest
docker run -it dev:latest /bin/zsh
```

## Install

```bash
git clone https://github.com/ch3n9w/dev
cd dev
# install dependency software and install configuration
./scripts/install-software.sh
```

Alternatively (if you dont want to install all of them), you can copy the configuration directory you like to XDG_CONFIG_HOME, for example:

```
nvim -> ~/.config/nvim
kitty -> ~/.config/kitty
tmux -> ~/.config/tmux
lf -> ~/.config/lf
zsh/zsh -> ~/.config/zsh
zsh/zshrc -> ~/.zshrc
```

## Noteable Info

- Kitty
  - use JetbrainMono Nerd Font and LXGW WenKai
- Tmux
  - use with `kitty --config ~/.config/kitty/tmux-mode.conf`, otherwise some keybindings will conflict with kitty.
  - use tmux-continuum and resurrect to restore sessions.
- Zsh
  - you can add software settings in `zsh/zsh/software`
  - disable vim mode.
- Neovim
  - Only use <=30 plugins to make Neovim tiny and good enough for simple editing

## Keymap

|     Software      |       Key       |              Effect              |
| :---------------: | :-------------: | :------------------------------: |
| kitty(kitty.conf) |       C-t       |             new tab              |
| kitty(kitty.conf) |      C-CR       |            new window            |
| kitty(kitty.conf) |       C-w       |          delete window           |
| kitty(kitty.conf) |    C-h/j/k/l    |        focus other window        |
| kitty(kitty.conf) |   C-S-h/j/k/l   |           move window            |
| kitty(kitty.conf) |   C-PgUp/PgDn   |          goto other tab          |
| kitty(kitty.conf) |  C-S-PgUp/PgDn  |             move tab             |
| kitty(kitty.conf) |      C-=/-      |         adjust font size         |
| kitty(kitty.conf) |       f1        |          search content          |
| kitty(kitty.conf) |       f11       |           toggle zoom            |
|        zsh        |       C-r       |      execute lf filemanager      |
|        zsh        |   C-backspace   |       delete word backward       |
|        lf         |       gh        |          go to home (~)          |
|        lf         |       gd        |        go to ~/Documents         |
|        lf         |       gn        |        go to ~/Downloads         |
|        lf         |        H        | go to previous visited directory |
|        lf         |        L        |   go to next visited directory   |
|        lf         |        a        |              mkdir               |
|        lf         |        t        |              touch               |
|        lf         |        r        |     rename file or directory     |
|        lf         |        o        |    open with custom software     |
|        lf         |        .        |         show hidden file         |
|        lf         |        ;        |      execute shell command       |
|        lf         |        y        |               copy               |
|        lf         |        d        |               cut                |
|        lf         |        p        |              paste               |
|        lf         |        D        |          move to trash           |
|        lf         |    <delete>     |                rm                |
|        lf         |        f        |      fuzzy search using fzf      |
|       tmux        |    C-h/j/k/l    |         go to other pane         |
|       tmux        |       C-q       |            kill pane             |
|       tmux        |     C-S-j/k     |      swap with other panes       |
|       tmux        |       C-x       |    split window horizontally     |
|       tmux        |      C-S-x      |     split window vertically      |
|       tmux        |       C-f       |           toggle zoom            |
|       tmux        |       C-t       |        create new window         |
|       tmux        |      C-S-t      |          rename window           |
|       tmux        |     C-PgUp      |      go to previous window       |
|       tmux        |     C-PgDn      |        go to next window         |
|       tmux        |    C-S-PgUp     |    swap with previous window     |
|       tmux        |    C-S-PgDn     |      swap with next window       |
|       tmux        |       C-s       |          choose session          |
|       tmux        |      C-S-s      |          rename session          |
|       tmux        |       C-n       |        create new session        |
|      neovim       |        q        |         quit window/neovim       |
|      neovim       |        Q        |            record macro          |
|      neovim       |       H/L       |    go to the begin/end of line   |
|      neovim       |      <TAB>      |      move to other window        |
|      neovim       |        ;        |      enter commandline mode      |
|      neovim       |       g=        |         format document          |
|      neovim       | 2-LeftMouse/<CR>|           toggle fold            |
|      neovim       |       sw        |        fuzzy search word         |
|      neovim       |       sf        |      fuzzy search filename       |
|      neovim       |        z        |   fuzzy search opened buffers    |
|      neovim       |       ga        |        (lsp) code action         |
|      neovim       |       ge        |  (lsp) show diagnostics in line  |
|      neovim       |       gh        |        (lsp) get document        |
|      neovim       |       gn        |       (lsp) rename symbol        |
|      neovim       |       gd        |      (lsp) go to definition      |
|      neovim       |       gr        |       (lsp) find reference       |
|      neovim       |       C-/       |           comment line           |
|      neovim       |       f         |           flash jump             |
|      neovim       |  <Tab>/<S-Tab>  |         code completions         |
|      neovim       |    <leader>t    |             File Tree            |
