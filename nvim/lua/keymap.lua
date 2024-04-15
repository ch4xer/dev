local vim = vim
local utils = require('utils')
local Base = {
    movement = {
        -- move cursor in wrapline paragraph
        { { 'n', 'v' }, 'j',       "v:count == 0 ? 'gj' : 'j'",                      { expr = true, silent = true } },
        { { 'n', 'v' }, 'k',       "v:count == 0 ? 'gk' : 'k'",                      { expr = true, silent = true } },
        { { 'n', 'v' }, 'L',       '$' },
        { { 'n', 'v' }, 'H',       '^' },

        -- tab switch, dont modify <Tab>, which will affect <C-i>
        { 'n',          'J',       function() vim.api.nvim_command('bprevious!') end },
        { 'n',          'K',       function() vim.api.nvim_command('bnext!') end },

        -- move window
        { 'n',          '<C-S-h>', '<C-w>H' },
        { 'n',          '<C-S-j>', '<C-w>J' },
        { 'n',          '<C-S-k>', '<C-w>K' },
        { 'n',          '<C-S-l>', '<C-w>L' },

        -- page scroll
        { 'n',          'F',       math.floor(vim.fn.winheight(0) / 2) .. '<C-u>' },
        { 'n',          'f',       math.floor(vim.fn.winheight(0) / 2) .. '<C-d>' },
    },
    edit = {
        { 'i', '<C-BS>',      '<C-W>', { desc = 'delete word forward' } },
        { 'v', '<C-c>',       '"*ygvy' },
        { 'n', 'yw',          'yiw' },
        { 'n', '<C-S-v>',     '<C-v>' },
        { 'v', 'y',           '"*ygvy' },
        { 'v', '>',           '>gv',   { desc = 'keep virtual mode after indent' } },
        { 'v', '<',           '<gv',   { desc = 'keep virtual mode after indent' } },
        { 'n', '<Backspace>', 'ciw' },
        { 'v', '<Backspace>', 'c' },
    },
    cmd = {
        { { 'n', 'v' }, ';',         ':',            { nowait = true } },
        { { 'n', 'v' }, ']',         '*',            { nowait = true } },
        { { 'n', 'v' }, '[',         '#',            { nowait = true } },
        { 'n',          '<leader>q', 'q1',           { desc = 'record macro' } },
        { 'n',          '<C-q>',     utils.quit_win, { desc = 'quit window' } },
        { 'n',          'Q',         utils.wq_all,   { desc = 'quit all' } },
        { 'n',          'g=',        utils.format },
    },
    fold = {
        { 'n', '<CR>',          'za', { desc = 'toggle fold' } },
        { 'n', '<2-LeftMouse>', 'za', { desc = 'toggle fold' } },
    },
    modeSwitch = {
        { 'i', '<ESC>', '<C-O><CMD>stopinsert<CR>' },
    }
}

local Plugin = {
    bufdelete = {
        { 'n', 'q', function() utils.delete_buf_or_quit() end },
    },
    fzf = {
        { 'n', 'sw', function() require('fzf-lua').live_grep() end },
        { 'n', 'sf', function() require('fzf-lua').files() end },
        { 'n', 'sd', function() require('fzf-lua').diagnostics_workspace() end },
    },
    --- some keymaps are in neotree.lua
    neotree = {
        { 'n', '<leader>t', utils.toggle_tree },
        { 'n', '<leader>c', '<CMD>cd %:h<CR>' },
    },
    lspsaga = {
        { 'n', 'ss',    function() vim.api.nvim_command('Lspsaga term_toggle') end },
        { 't', '<ESC>', function() vim.api.nvim_win_close(0, true) end },
        { 'n', 'ga',    function() vim.api.nvim_command('Lspsaga code_action') end,          { silent = true } },
        { 'n', 'ge',    function() vim.api.nvim_command('Lspsaga show_line_diagnostics') end },
        { 'n', 'gh',    function() vim.api.nvim_command('Lspsaga hover_doc') end },
        { 'n', 'gn',    function() vim.api.nvim_command('Lspsaga rename') end },
        { 'n', 'gd',    function() vim.api.nvim_command('Lspsaga peek_definition') end },
        { 'n', 'gr',    function() vim.api.nvim_command('Lspsaga finder') end },
    },
    neogen = {
        { 'n', 'go', function() require('neogen').generate() end },
    },
    neotest = {
        { 'n', 'tt', function() require('neotest').run.run() end },
        { 'n', 'ts', function() require('neotest').output.open() end },
    },
    dap = {
        { 'n', '<F1>', function() require("dap").toggle_breakpoint() end },
        { 'n', '<F2>', function() require("dap").continue() end },
        { 'n', '<F3>', function() require("dap").step_into() end },
        { 'n', '<F4>', function() require("dap").step_over() end },
        { 'n', '<F5>', function() require("dapui").toggle() end },
    },
    comment = {
        { 'v', '<C-_>', '<Plug>(comment_toggle_linewise_visual)' },
        { 'v', '<C-/>', '<Plug>(comment_toggle_linewise_visual)' },
        { 'n', '<C-_>', '<Plug>(comment_toggle_linewise_current)' },
        { 'n', '<C-/>', '<Plug>(comment_toggle_linewise_current)' },
    },
    flash = {
        -- press '/' to search and jump
        -- press '?' to search and select in treesitter
        { { "n", "x", "o" }, '?', function() require("flash").treesitter() end }
    },
    markdown = {
        { 'n', '<leader>p', utils.preview_note },
        { 'n', 'P',         utils.paste_as_link },
    },
    tmux = {
        { 'n', '<C-j>', require('nvim-tmux-navigation').NvimTmuxNavigateDown },
        { 'n', '<C-k>', require('nvim-tmux-navigation').NvimTmuxNavigateUp },
        { 'n', '<C-h>', require('nvim-tmux-navigation').NvimTmuxNavigateLeft },
        { 'n', '<C-l>', require('nvim-tmux-navigation').NvimTmuxNavigateRight },

    },
    --- keymaps of nvim-cmp are in cmp.lua
    cmp = {},
    --- keymaps of dashboard are in dashboard.lua
    dashboard = {},
    --- keymaps of vim-surround are in edit.lua
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
