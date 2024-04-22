local vim = vim
local utils = require('utils')
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
        { 'n',          'F', math.floor(vim.fn.winheight(0) / 2) .. '<C-u>',    { desc = 'scroll half page forward' } },
        { 'n',          'f', math.floor(vim.fn.winheight(0) / 2) .. '<C-d>',    { desc = 'scroll half page backward' } },
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
        { { 'n', 'v' }, ']',         '*',            { nowait = true, desc = 'search forward for the word where the cursor is located' } },
        { { 'n', 'v' }, '[',         '#',            { nowait = true, desc = 'search backward for the word where the cursor is located' } },
        { 'n',          '<leader>q', 'q1',           { desc = 'record macro to register 1' } },
        { 'n',          '<C-q>',     utils.quit_win, { desc = 'quit window' } },
        { 'n',          'Q',         utils.wq_all,   { desc = 'quit all' } },
        { 'n',          'g=',        utils.format,   { desc = 'format document' } },
    },
    fold = {
        { 'n', '<CR>',          'za', { desc = 'toggle fold' } },
        { 'n', '<2-LeftMouse>', 'za', { desc = 'toggle fold' } },
    },
    modeSwitch = {
        { 'i', '<ESC>', '<C-O><CMD>stopinsert<CR>', { desc = 'exit to normal mode while keeping cursor location' } },
    }
}

local Plugin = {
    bufdelete = {
        { 'n', 'q', function() utils.delete_buf_or_quit() end, { desc = 'delete buffer or quit' } },
    },
    fzf = {
        { 'n', 'sw', function() require('fzf-lua').live_grep() end,             { desc = 'search word' } },
        { 'n', 'sf', function() require('fzf-lua').files() end,                 { desc = 'search file' } },
        { 'n', 'z',  function() require('fzf-lua').buffers() end,               { desc = 'search buffer' } },
        { 'n', 'sd', function() require('fzf-lua').diagnostics_workspace() end, { desc = 'search diagnostics' } },
    },
    neotree = {
        --- some keymaps are in neotree.lua
        { 'n', '<leader>t', utils.toggle_tree, { desc = 'toggle neotree' } },
        { 'n', '<leader>c', '<CMD>cd %:h<CR>', { desc = 'change root directory' } },
    },
    lspsaga = {
        { 'n', 'ss',    function() vim.api.nvim_command('Lspsaga term_toggle') end,           { desc = 'toggle terminal' } },
        { 't', '<ESC>', function() vim.api.nvim_win_close(0, true) end,                       { desc = 'close terminal' } },
        { 'n', 'ga',    function() vim.api.nvim_command('Lspsaga code_action') end,           { silent = true, desc = 'code action' } },
        { 'n', 'ge',    function() vim.api.nvim_command('Lspsaga show_line_diagnostics') end, { desc = 'show diagnostics in line' } },
        { 'n', 'gh',    function() vim.api.nvim_command('Lspsaga hover_doc') end,             { desc = 'get document' } },
        { 'n', 'gn',    function() vim.api.nvim_command('Lspsaga rename') end,                { desc = 'rename symbol' } },
        { 'n', 'gd',    function() vim.api.nvim_command('Lspsaga peek_definition') end,       { desc = 'peek definition' } },
        { 'n', 'gr',    function() vim.api.nvim_command('Lspsaga finder') end,                { desc = 'find reference' } },
    },
    neogen = {
        { 'n', 'go', function() require('neogen').generate() end, { desc = 'generate doc comment' } },
    },
    lazygit = {
        { 'n', 'gi', function() vim.api.nvim_command('LazyGit') end, { desc = 'toggle lazygit' } },
    },
    neotest = {
        { 'n', 'tt', function() require('neotest').run.run() end,     { desc = 'run test' } },
        { 'n', 'ts', function() require('neotest').output.open() end, { desc = 'show test output' } },
    },
    dap = {
        { 'n', '`',    function() require("dap").toggle_breakpoint() end, { desc = 'toggle breakpoint' } },
        { 'n', '<F1>', function() require("dap").continue() end,          { desc = 'continue' } },
        { 'n', '<F2>', function() require("dap").step_over() end,         { desc = 'step over' } },
        { 'n', '<F3>', function() require("dap").step_into() end,         { desc = 'step into' } },
        { 'n', '<F4>', function() require("dapui").toggle() end,          { desc = 'toggle debug ui' } },
    },
    comment = {
        { 'v', '<C-_>', '<Plug>(comment_toggle_linewise_visual)',  { desc = 'comment' } },
        { 'v', '<C-/>', '<Plug>(comment_toggle_linewise_visual)',  { desc = 'comment' } },
        { 'n', '<C-_>', '<Plug>(comment_toggle_linewise_current)', { desc = 'comment' } },
        { 'n', '<C-/>', '<Plug>(comment_toggle_linewise_current)', { desc = 'comment' } },
    },
    flash = {
        -- press '/' to search and jump
        { { "n", "x", "o" }, '?', function() require("flash").treesitter() end, { desc = 'search and select in treesitter' } }
    },
    markdown = {
        { 'n', '<leader>p', utils.preview_note,  { desc = 'preview markdown' } },
        { 'n', 'P',         utils.paste_as_link, { desc = 'paste image as link' } },
    },
    tmux = {
        { 'n', '<C-j>', require('nvim-tmux-navigation').NvimTmuxNavigateDown,  { desc = 'navigate in neovim windows and tmux windows' } },
        { 'n', '<C-k>', require('nvim-tmux-navigation').NvimTmuxNavigateUp,    { desc = 'navigate in neovim windows and tmux windows' } },
        { 'n', '<C-h>', require('nvim-tmux-navigation').NvimTmuxNavigateLeft,  { desc = 'navigate in neovim windows and tmux windows' } },
        { 'n', '<C-l>', require('nvim-tmux-navigation').NvimTmuxNavigateRight, { desc = 'navigate in neovim windows and tmux windows' } },

    },
    --- keymaps of nvim-cmp are in cmp.lua
    cmp = {},
    --- keymaps of nvim-surround are in edit.lua
    surround = {},
}

local keyMapper = function(keySet)
    for _, set in pairs(keySet) do
        for _, keymap in ipairs(set) do
            if keymap[4] == nil then
                keymap[4] = { noremap = true, silent = true }
            end
            if keymap[3] ~= nil then
                vim.keymap.set(
                    keymap[1],
                    keymap[2],
                    keymap[3],
                    keymap[4]
                )
            end
        end
    end
end

keyMapper(Base)
keyMapper(Plugin)
