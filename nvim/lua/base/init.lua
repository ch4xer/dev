local vim = vim

-- set title for alacritty
vim.opt.title = true
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.errorbells = false
vim.opt.mouse = 'a'
vim.opt.mousemodel = 'extend'
vim.opt.shell = '/bin/zsh'

-- hidden conceal char
-- vim.opt.conceallevel = 3

vim.opt.modifiable = true
-- auto save
vim.opt.autowriteall = true
-- the refresh time will affect lspsaga's reaction time
vim.opt.updatetime = 300
-- case settintg
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.cursorline = true

-- clipboard
vim.opt.clipboard = 'unnamedplus'

-- folder view setting
-- vim.opt.foldmethod = 'expr'
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.opt.foldlevel = 20
-- for ufo plugin
vim.opt.foldcolumn = '0' -- '0' is not bad
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

vim.opt.scrolloff = 5

-- indent setting
vim.opt.autoindent = true
vim.opt.smartindent = true

-- no additional files
vim.opt.swapfile = false
vim.opt.backup = false -- insert mode compeleting menu setting
vim.opt.completeopt = 'menuone,noinsert,noselect'

-- visual selection mode
vim.opt.sel = 'inclusive'

-- set tab to 4 spaces, could be override by ftplugin
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- show numbers
vim.opt.number = true
vim.opt.relativenumber = false

-- save space for window
vim.opt.signcolumn = 'yes'

-- wrap line when too long to display
vim.opt.wrap = true

-- key mappings
vim.g.mapleader = ' '

-- load preview view
vim.opt.viewoptions = 'folds,cursor,curdir'

-- setting for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- environment setup
vim.env.GOPATH = "/home/ch4ser/Projects/go"
vim.env.GOPROXY = "https://goproxy.cn"
vim.env.GO111MODULE = "on"
vim.env.CGO_ENABLED = "1"

vim.api.nvim_set_hl(0, "Comment", { bold = true, italic = true })
vim.api.nvim_set_hl(0, "TSComment", { bold = true, italic = true })
