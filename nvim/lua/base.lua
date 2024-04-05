local vim = vim

-- disable statusline, set splitline for windows
vim.opt.laststatus = 0
local str = string.rep('-', vim.api.nvim_win_get_width(0))
vim.opt.statusline = '%#VerticalSplit#'..str..'%*'
-- set cmd height, set by noice.nvim
-- vim.opt.cmdheight = 0

vim.opt.title = true
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.errorbells = false
vim.opt.mouse = 'a'
vim.opt.mousemodel = 'extend'

-- split window setting
vim.opt.splitbelow = true
vim.opt.splitright = true

-- hidden conceal char
-- vim.opt.conceallevel = 3

vim.opt.modifiable = true
-- the refresh time will affect lspsaga's reaction time
vim.opt.updatetime = 300
-- case settintg
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.cursorline = true

-- clipboard
vim.opt.clipboard = 'unnamedplus'

-- folder
vim.opt.foldcolumn = '0' -- '0' is not bad
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

vim.opt.scrolloff = 0

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
vim.opt.signcolumn = 'number'

-- wrap line when too long to display
vim.opt.wrap = true

vim.g.mapleader = ' '

vim.opt.viewoptions = 'folds,cursor,curdir'

-- save undo history
vim.opt.undofile = true

vim.g.python3_host_prog = vim.fn.exepath("python3")

vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })
