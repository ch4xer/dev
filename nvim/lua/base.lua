local vim = vim

vim.o.title = true
vim.o.titlestring = 'nvim %{expand("%:p:h:t")}'
vim.o.termguicolors = true
vim.o.background = "dark"
vim.o.mouse = "a"
vim.o.mousemodel = "extend"
vim.o.cmdheight = 0
vim.o.showmode = false

-- split window setting
vim.o.splitbelow = true
vim.o.splitright = true

-- hidden conceal char
-- vim.o.conceallevel = 3
vim.o.modifiable = true
-- case settintg
vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.cursorline = true

vim.o.clipboard = "unnamedplus"
if os.getenv("SSH_TTY") ~= nil then
    vim.g.clipboard = {
        name = 'OSC 52',
        copy = {
            ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
            ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
        },
        paste = {
            ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
            ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
        },
    }
end

vim.o.foldcolumn = "0"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.o.scrolloff = 0

-- indent setting
vim.o.autoindent = true
vim.o.smartindent = true

-- no additional files
vim.o.swapfile = false
vim.o.backup = false -- insert mode compeleting menu setting
vim.o.completeopt = "menuone,noinsert,noselect"

-- visual selection mode
vim.o.sel = "inclusive"

-- set tab to 4 spaces, could be override by ftplugin
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- show numbers
vim.o.number = true
vim.o.relativenumber = false

-- save space for window
vim.o.signcolumn = "number"

-- wrap line when too long to display
vim.o.wrap = true
vim.o.smoothscroll = true

vim.g.mapleader = " "

vim.o.viewoptions = "folds,cursor,curdir"

-- save undo history, slow startup with large file
if vim.g.is_not_large() then
    vim.o.undofile = true
end

vim.g.python3_host_prog = vim.fn.exepath("python3")

vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
