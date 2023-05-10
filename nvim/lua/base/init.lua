local vim = vim

-- set title for alacritty
vim.o.title = true
vim.o.termguicolors = true
vim.o.background = "dark"
vim.o.errorbells = false
vim.o.mouse = 'a'
vim.o.mousemodel = 'extend'
vim.o.shell = '/bin/zsh'

vim.o.modifiable = true
-- auto save
vim.o.autowriteall = true
-- the refresh time will affect lspsaga's reaction time
vim.o.updatetime = 300
-- case settintg
vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.cursorline = true

-- clipboard
vim.o.clipboard = 'unnamedplus'

-- folder view setting
-- vim.o.foldmethod = 'expr'
-- vim.o.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.o.foldlevel = 20
-- for ufo plugin
vim.o.foldcolumn = '0' -- '0' is not bad
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.o.scrolloff = 0
-- wait PR to be merged, then all things will be better
vim.o.smoothscroll = true

-- indent setting
vim.o.autoindent = true
vim.o.smartindent = true

-- no additional files
vim.o.swapfile = false
vim.o.backup = false -- insert mode compeleting menu setting
vim.o.completeopt = 'menuone,noinsert,noselect'

-- visual selection mode
vim.o.sel = 'inclusive'

-- set tab to 4 spaces, could be override by ftplugin
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- show numbers
vim.o.number = true
vim.o.relativenumber = true

-- save space for window
vim.o.signcolumn = 'yes'

-- wrap line when too long to display
vim.o.wrap = true

-- key mappings
vim.g.mapleader = ','

-- load preview view
vim.o.viewoptions = 'folds,cursor,curdir'

-- setting for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- environment setup
vim.env.GOPATH = "/home/ch4ser/Projects/go"
vim.env.GOPROXY = "https://goproxy.cn"
vim.env.GO111MODULE = "on"
vim.env.CGO_ENABLED = "1"

-- neovide setting
vim.o.guifont = 'Hack Nerd Font:h20'
-- vim.o.guifont = 'Hack:h20'
vim.g.neovide_transparency = 1
vim.g.neovide_cursor_vfx_mode = "wireframe"
-- adjust this to disable animation
vim.g.neovide_cursor_animation_length = 0
vim.g.neovide_cursor_trail_size = 0
