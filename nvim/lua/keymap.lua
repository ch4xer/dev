local vim = vim
local Base = {
    movement = {
        -- move cursor in wrapline paragraph
        { { 'n', 'v' }, 'j', "v:count == 0 ? 'gj' : 'j'",                       { expr = true, silent = true, desc = 'go to next wrapline' } },
        { { 'n', 'v' }, 'k', "v:count == 0 ? 'gk' : 'k'",                       { expr = true, silent = true, desc = 'go to previous wrapline' } },
        { { 'n', 'v' }, 'L', '$',                                               { desc = 'go to the end of line' } },
        { { 'n', 'v' }, 'H', '^',                                               { desc = 'go the begin of line' } },

        -- dont modify <Tab>, which will affect <C-i>
        { 'n',          'J', function() vim.api.nvim_command('bprevious!') end, { desc = 'go to previous buffer' } },
        { 'n',          'K', function() vim.api.nvim_command('bnext!') end,     { desc = 'go to next buffer' } },
        -- <PageUp>
        -- page scroll
        { { 'n', 'v' }, 'F', math.floor(vim.fn.winheight(0) / 2) .. '<C-u>',    { desc = 'scroll half page forward' } },
        { { 'n', 'v' }, 'f', math.floor(vim.fn.winheight(0) / 2) .. '<C-d>',    { desc = 'scroll half page backward' } },
    },
    edit = {
        { 'i', '<C-BS>',      '<C-W>',  { desc = 'delete word forward' } },
        { 'v', 'y',           '"*ygvy', { desc = 'copy' } },
        { 'n', 'yw',          'yiw',    { desc = 'copy the word where cursor locates' } },
        { 'n', '<C-S-v>',     '<C-v>',  { desc = 'start visual mode blockwise' } },
        { 'v', '>',           '>gv',    { desc = 'indent while keeping virtual mode after ' } },
        { 'v', '<',           '<gv',    { desc = 'indent while keeping virtual mode after ' } },
        { 'n', '<Backspace>', 'ciw',    { desc = 'delete word and edit in normal mode' } },
        { 'v', '<Backspace>', 'c',      { desc = 'delete and edit in visual mode' } },
    },
    cmd = {
        { { 'n', 'v' }, ';',         ':',            { nowait = true, desc = 'enter commandline mode' } },
        { 'n',          '<leader>q', 'q1',           { desc = 'record macro to register 1' } },
        { 'n',          '<C-q>',     vim.g.quit_win, { desc = 'quit window' } },
        { 'n',          'Q',         vim.g.wq_all,   { desc = 'quit all' } },
    },
    lsp = {
        { 'n', 'gn', vim.lsp.buf.rename,        { desc = 'rename symbol' } },
        { 'n', 'g=', vim.lsp.buf.format,        { desc = 'format document' } },
        { 'n', 'gh', vim.lsp.buf.hover,         { desc = 'show documentation' } },
        { 'n', 'ge', vim.diagnostic.open_float, { desc = 'show diagnostic' } },
    },
    fold = {
        { 'n', '<CR>',          'za', { desc = 'toggle fold' } },
        { 'n', '<2-LeftMouse>', 'za', { desc = 'toggle fold' } },
    },
    modeSwitch = {
        { 'i', '<ESC>', '<C-O><CMD>stopinsert<CR>', { desc = 'exit to normal mode while keeping cursor location' } },
    },
    comment = {
        { 'v', '<C-/>', 'gc',  { desc = 'comment', remap = true, silent = true } },
        { 'v', '<C-_>', 'gc',  { desc = 'comment', remap = true, silent = true } },
        { 'n', '<C-/>', 'gcc', { desc = 'comment', remap = true, silent = true } },
        { 'n', '<C-_>', 'gcc', { desc = 'comment', remap = true, silent = true } },
    },
}

local Plugin = {
    bufdelete = {
        { 'n', 'q', vim.g.delete_buf_or_quit, { desc = 'delete buffer or quit' } },
    },
    fzf = {
        { 'n', 'sw', function() require('fzf-lua').live_grep() end,             { desc = 'search word' } },
        { 'n', 'sf', function() require('fzf-lua').files() end,                 { desc = 'search file' } },
        { 'n', 'z',  function() require('fzf-lua').buffers() end,               { desc = 'search buffer' } },
        { 'n', 'sd', function() require('fzf-lua').diagnostics_workspace() end, { desc = 'search diagnostics' } },
        { 'n', 'ga', function() require('fzf-lua').lsp_code_actions() end,      { desc = 'code action' } },
        { 'n', 'gd', function() require('fzf-lua').lsp_references() end,        { desc = 'find reference' } },
    },
    neotree = {
        --- some keymaps are in configuration of neotree
        { 'n', '<leader>t', vim.g.toggle_tree, { desc = 'toggle neotree' } },
        { 'n', '<leader>c', '<CMD>cd %:h<CR>', { desc = 'change root directory' } },
    },
    dap = {
        { 'n', '<F1>', function() require("dap").toggle_breakpoint() end, { desc = 'toggle breakpoint' } },
        { 'n', '<F2>', function() require("dap").continue() end,          { desc = 'continue' } },
        { 'n', '<F3>', function() require("dap").step_over() end,         { desc = 'step over' } },
        { 'n', '<F4>', function() require("dap").step_into() end,         { desc = 'step into' } },
        { 'n', '<F5>', function() require("dapui").toggle() end,          { desc = 'toggle debug ui' } },
    },
    flash = {
        -- press '/' to jump in regular search
        { { "n", "x", "o" }, '?', function() require("flash").treesitter() end, { desc = 'search and select in treesitter' } }
    },
    markdown = {
        { 'n', '<leader>p', vim.g.preview_note,  { desc = 'preview markdown' } },
        { 'n', 'P',         vim.g.paste_as_link, { desc = 'paste image as link' } },
    },
    tmux = {
        { 'n', '<C-j>', function() require('nvim-tmux-navigation').NvimTmuxNavigateDown() end,  { desc = 'navigate in neovim windows and tmux windows' } },
        { 'n', '<C-k>', function() require('nvim-tmux-navigation').NvimTmuxNavigateUp() end,    { desc = 'navigate in neovim windows and tmux windows' } },
        { 'n', '<C-h>', function() require('nvim-tmux-navigation').NvimTmuxNavigateLeft() end,  { desc = 'navigate in neovim windows and tmux windows' } },
        { 'n', '<C-l>', function() require('nvim-tmux-navigation').NvimTmuxNavigateRight() end, { desc = 'navigate in neovim windows and tmux windows' } },

    },
    -- keymaps are in configuration of nvim-cmp
    cmp = {},
    -- keymaps are in configuration of nvim-surround
    surround = {},
}

vim.g.register_keymap(Base)
vim.g.register_keymap(Plugin)
