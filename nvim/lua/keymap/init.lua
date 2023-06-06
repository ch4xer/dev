local vim = vim
local Movement = {
    -- move cursor in wrapline paragraph
    { 'n',          'j',          "v:count == 0 ? 'gj' : 'j'",                    { expr = true, silent = true } },
    { 'n',          'k',          "v:count == 0 ? 'gk' : 'k'",                    { expr = true, silent = true } },
    -- move cursor to the start and the end of paragraph
    { 'i',          '<C-j>',      '<ESC>o', },
    { 'i',          '<C-k>',      '<ESC>O', },
    { 'i',          '<C-h>',      '<ESC>I' },
    { 'i',          '<C-l>',      '<ESC>A' },

    { 'n',          '<C-h>',      '<ESC>^' },
    { 'n',          '<C-l>',      '<ESC>$' },
    { 'n',          '(',          '<ESC>^' },
    { 'n',          ')',          '<ESC>$' },
    { 'v',          '<C-l>',      '$' },
    { 'v',          '<C-h>',      '^' },

    -- other
    { 'i',          '<C-Down>',   '<C-O><C-E>' },
    { 'i',          '<C-Up>',     '<C-O><C-Y>' },

    -- move cursor between window
    { 'n',          '<leader>h',  '<C-w>h' },
    { 'n',          '<leader>j',  '<C-w>j' },
    { 'n',          '<leader>k',  '<C-w>k' },
    { 'n',          '<leader>l',  '<C-w>l' },

    -- tab switch
    { 'n',          '<Tab>',      '<CMD>bnext!<CR>' },
    { 'n',          '<S-Tab>',    '<CMD>bprevious!<CR>' },
    -- page scroll
    { { 'n', 'v' }, '<PageUp>',   math.floor(vim.fn.winheight(0) / 2) .. '<C-u>', { desc = 'scroll 1/3 size of page' } },
    { { 'n', 'v' }, '<PageDown>', math.floor(vim.fn.winheight(0) / 2) .. '<C-d>', { desc = 'scroll 1/3 size of page' } },
}

local Edit = {
    { 'i', '<C-BS>',          '<C-W>',        { desc = 'delete word forward' } },
    -- remember to configure alacritty with:
    -- { key: Back, mods: Control, chars: "\x17"}
    -- and configure Ctrl+/-Backspace's output as \x17
    -- { 'i',                    '\x17',   '<C-W>' },

    -- { 'n', '<LeftRelease>', '<LeftRelease><cmd>startinsert<CR>'},
    { 'i', '<C-z>',           '<cmd>undo<CR>' },
    { 'v', '<C-c>',           '"*ygvy' },
    { 'v', 'y',               '"*ygvy' },
    -- useless, use kitty buildin paste instead.
    -- { { 'i', 'v', 'c', 't' }, '<C-v>',  '<C-R>+' },
    { 'i', '<C-v>',           '<C-R>+' },
    { 'v', '>',               '>gv',          { desc = 'keep virtual mode after indent' } },
    { 'v', '<',               '<gv',          { desc = 'keep virtual mode after indent' } },
    { 'n', '<leader><Space>', 'ciw' },
}

local Cmd = {
    { 'n',               ';',     ':',                                 { nowait = true } },
    { 'v',               ';',     ':',                                 { nowait = true } },
    { { 'n', 'i', 'v' }, '<C-s>', '<CMD>w<CR>',                        { desc = 'save' } },
    { 'n',               'Q',     'q',                                 { desc = 'macro record' } },
    { 'n',               'g=',    vim.lsp.buf.format },
    { 'c',               'w!',    require('keymap.custom').sudo_write, { desc = 'save file as root' } },
}

local Fold = {
    { 'n', '<CR>',          'za', { desc = 'toggle fold' } },
    { 'n', '<2-LeftMouse>', 'za' },
}

local ModeSwitch = {
    { 'n', '<RightMouse>', 'a' },
    { 'i', '<ESC>', '<C-O>:stopinsert<CR>', {
        desc =
        'back to normal mode without moving cursor'
    } },
}

-- keymaps that need plugin context are not included, like nvim-cmp
local Plugins = {
    bufdelete = {
        { 'n', 'q', require('keymap.custom').DeleteWinOrBuf },
    },
    telescope = {
        { 'n', 'sw', '<CMD>Telescope grep_string<CR>' },
        { 'n', 'sf', '<CMD>Telescope find_files<CR>' },
    },
    nvim_tree = {
        { 'n', '<leader>t', '<CMD>NvimTreeToggle<CR>' },
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
    hop = {
        -- { 'n', 'm', '<CMD>HopWord<CR>' },
        { 'n', 'm', function()
            require 'hop'.hint_words({ direction = require 'hop.hint'.HintDirection.AFTER_CURSOR })
        end },
        { 'n', 'M', function()
            require 'hop'.hint_words({ direction = require 'hop.hint'.HintDirection.BEFORE_CURSOR })
        end },
    },
    lspsaga = {
        { 'n',          'ga',    '<CMD>Lspsaga code_action<CR>',          { silent = true } },
        { 'n',          'ge',    '<CMD>Lspsaga show_line_diagnostics<CR>' },
        { 'n',          'gh',    '<CMD>Lspsaga hover_doc<CR>' },
        { 'n',          'gn',    '<CMD>Lspsaga rename<CR>' },
        { 'n',          'gd',    '<CMD>Lspsaga goto_definition<CR>' },
        { 'n',          'gp',    '<CMD>Lspsaga peek_definition<CR>' },
        { 'n',          'gr',    '<CMD>Lspsaga lsp_finder<CR>', },
        { { 'n', 't' }, 'ss',    '<CMD>Lspsaga term_toggle<CR>' },
        { { 't' },      '<ESC>', '<CMD>Lspsaga term_toggle<CR>' },
    },
    dap = {
        { 'n', '<F1>', '<CMD>lua require"dap".toggle_breakpoint()<CR>' },
        { 'n', '<F2>', '<CMD>lua require"dap".continue()<CR>' },
        { 'n', '<F3>', '<CMD>lua require"dap".step_into()<CR>' },
        { 'n', '<F4>', '<CMD>lua require"dap".step_over()<CR>' },
        { 'n', '<F5>', '<CMD>lua require"dapui".toggle()<CR>' },
    },
    zen = {
        { 'n', '<leader>f', '<CMD>lua require("zen-mode").toggle({window = {width = 1}})<CR>',
            { desc = 'toggle window fullscreen' },
        }
    },
    github_upload = {
        { 'n', '<C-p>', "<CMD>lua require('nvim-github-uploader').upload_img()<CR>" }
    }
}

local key_mapper = function(mode, key, result, config)
    if nil == config then
        config = { noremap = true, silent = true }
    end
    vim.keymap.set(
        mode,
        key,
        result,
        config
    )
end

for _, keymap_class in ipairs({ Movement, Edit, Cmd, Fold, ModeSwitch }) do
    for _, keymap in ipairs(keymap_class) do
        if keymap[4] ~= nil then
            key_mapper(keymap[1], keymap[2], keymap[3], keymap[4])
        else
            key_mapper(keymap[1], keymap[2], keymap[3])
        end
    end
end


for _, plugin_keymap in pairs(Plugins) do
    for _, keymap in ipairs(plugin_keymap) do
        if keymap[4] ~= nil then
            key_mapper(keymap[1], keymap[2], keymap[3], keymap[4])
        else
            key_mapper(keymap[1], keymap[2], keymap[3])
        end
    end
end


vim.api.nvim_create_user_command(
    "Typora",
    require('keymap.custom').Typora,
    { desc = "start typora" }
)

vim.api.nvim_create_user_command(
    "ViewImage",
    require('keymap.custom').view_net_image,
    { desc = "view network image" }
)
