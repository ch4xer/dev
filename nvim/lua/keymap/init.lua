local vim = vim
local custom = require('keymap.custom')
local Base = {
    movement = {
        -- move cursor in wrapline paragraph
        { 'n',          'j',       "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true } },
        { 'n',          'k',       "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true } },
        { { 'n', 'v' }, 'L',       '$' },
        { { 'n', 'v' }, 'H',       '^' },

        -- tab switch, dont modify <Tab>, which will affect <C-i>
        { 'n',          'J',       '<CMD>bprevious!<CR>' },
        { 'n',          'K',       '<CMD>bnext!<CR>' },

        -- move window
        { 'n',          '<C-S-h>', '<C-w>H' },
        { 'n',          '<C-S-j>', '<C-w>J' },
        { 'n',          '<C-S-k>', '<C-w>K' },
        { 'n',          '<C-S-l>', '<C-w>L' },

        -- page scroll
        { { 'n', 'v' }, '<PageUp>', math.floor(vim.fn.winheight(0) / 2) .. '<C-u>',
            {
                desc =
                'scroll 1/2 size of page'
            } },
        { { 'n', 'v' }, '<PageDown>', math.floor(vim.fn.winheight(0) / 2) .. '<C-d>',
            {
                desc =
                'scroll 1/2 size of page'
            } },
    },
    edit = {
        { 'i', '<C-BS>',      '<C-W>', { desc = 'delete word forward' } },
        { 'v', '<C-c>',       '"*ygvy' },
        { 'v', 'y',           '"*ygvy' },
        { 'v', '>',           '>gv',   { desc = 'keep virtual mode after indent' } },
        { 'v', '<',           '<gv',   { desc = 'keep virtual mode after indent' } },
        { 'n', '<Backspace>', 'ciw' },
        { 'v', '<Backspace>', 'c' },
    },
    cmd = {
        { { 'n', 'v' }, ';',         ':',                 { nowait = true } },
        { 'n',          '<leader>q', 'q1',                { desc = 'record macro' } },
        { 'n',          '<C-q>',     ':q<CR>',            { desc = 'quit window' } },
        { 'n',          'Q',         custom.WriteQuitAll, { desc = 'quit all' } },
        { 'n',          'g=',        custom.format },
        { 'c',          'w!',        custom.sudo_write,   { desc = 'save file as root' } },
    },
    fold = {
        { 'n', '<CR>',          'za', { desc = 'toggle fold' } },
        { 'n', '<2-LeftMouse>', 'za', { desc = 'toggle fold' } },
    },
    modeSwitch = {
        { 'n', '<RightMouse>', 'a' },
        { 'i', '<ESC>', '<C-O>:stopinsert<CR>', {
            desc =
            'back to normal mode without moving cursor'
        } },
    }
}

local Plugin = {
    bufdelete = {
        { 'n', 'q', function() custom.DeleteWinOrBuf() end },
    },
    telescope = {
        { 'n', 'sw', function() require('telescope.builtin').live_grep() end },
        { 'n', 'sf', function() require('telescope.builtin').find_files() end },
    },
    --- some keymaps are in filetree.lua
    nvim_tree = {
        { 'n', '<leader>t', function() require('nvim-tree.api').tree.toggle() end },
        { 'n', '<leader>c', '<CMD>cd %:h<CR>' },
    },
    aerial = {
        { 'n', '<leader>s', '<CMD>AerialToggle<CR>' },
    },
    comment = {
        { 'v', '<C-_>', '<Plug>(comment_toggle_linewise_visual)' },
        { 'v', '<C-/>', '<Plug>(comment_toggle_linewise_visual)' },
        { 'n', '<C-_>', '<Plug>(comment_toggle_linewise_current)' },
        { 'n', '<C-/>', '<Plug>(comment_toggle_linewise_current)' },
    },
    flash = {
        { { "n", "x", "o" }, 'f', function() require("flash").jump() end },
        { { "n", "x", "o" }, 'F', function() require("flash").treesitter() end }
    },
    lspsaga = {
        { 'n',          'ga',    '<CMD>Lspsaga code_action<CR>',          { silent = true } },
        { 'n',          'ge',    '<CMD>Lspsaga show_line_diagnostics<CR>' },
        { 'n',          'gh',    '<CMD>Lspsaga hover_doc<CR>' },
        { 'n',          'gn',    '<CMD>Lspsaga rename<CR>' },
        { 'n',          'gd',    '<CMD>Lspsaga peek_definition<CR>' },
        { 'n',          'gr',    '<CMD>Lspsaga finder<CR>', },
        { { 'n', 't' }, 'ss',    '<CMD>Lspsaga term_toggle<CR>' },
        { { 't' },      '<ESC>', '<CMD>Lspsaga term_toggle<CR>' },
    },
    neogen = {
        { 'n', 'go', function() require('neogen').generate() end },
    },
    dap = {
        { 'n', '<F1>', function() require "dap".toggle_breakpoint() end },
        { 'n', '<F2>', function() require "dap".continue() end },
        { 'n', '<F3>', function() require "dap".step_into() end },
        { 'n', '<F4>', function() require "dap".step_over() end },
        { 'n', '<F5>', function() require "dapui".toggle() end },
    },
    copilot = {
        { 'i', '<Right>', function() custom.accept_copilot_suggestion() end }
    },
    tmux = {
        { 'n', '<C-j>', '<CMD>TmuxNavigateDown<CR>' },
        { 'n', '<C-k>', '<CMD>TmuxNavigateUp<CR>' },
        { 'n', '<C-h>', '<CMD>TmuxNavigateLeft<CR>' },
        { 'n', '<C-l>', '<CMD>TmuxNavigateRight<CR>' },
    },
    --- keymaps of nvim-cmp are in cmp.lua
    cmp = {},
    --- keymaps of dashboard are in dashboard.lua
    dashboard = {},
    --- keymaps of vim-surround are in surround.lua
    surround = {},
    --- keymaps of tabout are in tabout.lua
    tabout = {},
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


vim.api.nvim_create_user_command(
    "ViewImage",
    custom.view_net_image,
    { desc = "view network image" }
)
