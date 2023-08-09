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
    { 'n',          '(',          '<ESC>^' },
    { 'n',          ')',          '<ESC>$' },
    { 'v',          '<C-l>',      '$' },
    { 'v',          '<C-h>',      '^' },

    -- other
    { 'i',          '<C-Down>',   '<C-O><C-E>' },
    { 'i',          '<C-Up>',     '<C-O><C-Y>' },

    -- tab switch
    { 'n',          '<Tab>',      '<CMD>bnext!<CR>' },
    { 'n',          '<S-Tab>',    '<CMD>bprevious!<CR>' },
    -- page scroll
    { { 'n', 'v' }, '<PageUp>',   math.floor(vim.fn.winheight(0) / 2) .. '<C-u>', { desc = 'scroll 1/3 size of page' } },
    { { 'n', 'v' }, '<PageDown>', math.floor(vim.fn.winheight(0) / 2) .. '<C-d>', { desc = 'scroll 1/3 size of page' } },
}

local Edit = {
    -- use Ctrl w in tmux to delete a word
    { 'i', '<C-BS>',      '<C-W>', { desc = 'delete word forward' } },
    -- remember to configure alacritty with:
    -- { key: Back, mods: Control, chars: "\x17"}
    -- and configure Ctrl+/-Backspace's output as \x17
    -- { 'i',                    '\x17',   '<C-W>' },

    -- { 'n', '<LeftRelease>', '<LeftRelease><cmd>startinsert<CR>'},
    -- { 'i', '<C-z>',       '<cmd>undo<CR>' },
    { 'v', '<C-c>',       '"*ygvy' },
    { 'v', 'y',           '"*ygvy' },
    -- useless, use kitty buildin paste instead.
    -- { { 'i', 'v', 'c', 't' }, '<C-v>',  '<C-R>+' },
    { 'i', '<C-v>',       '<C-R>+' },
    { 'v', '>',           '>gv',   { desc = 'keep virtual mode after indent' } },
    { 'v', '<',           '<gv',   { desc = 'keep virtual mode after indent' } },
    { 'n', '<Backspace>', 'ciw' },
    { 'v', '<Backspace>', 'c' },
}

local Cmd = {
    { 'n', ';',         ':',                                 { nowait = true } },
    { 'v', ';',         ':',                                 { nowait = true } },
    { 'n', '<leader>q', 'q1',                                { desc = 'macro record' } },
    { 'n', 'Q',         ':wqa<CR>',                          { desc = 'quit all' } },
    { 'n', 'g=',        vim.lsp.buf.format },
    { 'c', 'w!',        require('keymap.custom').sudo_write, { desc = 'save file as root' } },
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
    flash = {
        {
            { "n", "x", "o" },
            'm',
            function()
                if package.loaded['flash'] == nil then
                    return
                end
                require("flash").jump()
            end
        },
        {
            { "n", "x", "o" },
            'M',
            function()
                if package.loaded['flash'] == nil then
                    return
                end
                require("flash").treesitter()
            end
        }
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
        { 'n', 'go', require('neogen').generate },
    },
    dap = {
        { 'n', '<F1>', require "dap".toggle_breakpoint },
        { 'n', '<F2>', require "dap".continue },
        { 'n', '<F3>', require "dap".step_into },
        { 'n', '<F4>', require "dap".step_over },
        { 'n', '<F5>', require "dapui".toggle },
    },
    github_upload = {
        { 'n', '<C-p>', "<CMD>lua require('nvim-github-uploader').upload_img()<CR>" }
    },
    copilot = {
        { 'i', '<Right>', require('keymap.custom').accept_copilot_suggestion }
    },
    tmux = {
        { 'n', '<C-j>', '<CMD>TmuxNavigateDown<CR>' },
        { 'n', '<C-k>', '<CMD>TmuxNavigateUp<CR>' },
        { 'n', '<C-h>', '<CMD>TmuxNavigateLeft<CR>' },
        { 'n', '<C-l>', '<CMD>TmuxNavigateRight<CR>' },
    }
}

local Nop = {
    { { 'n', 'x' }, 's', 'Nop', { noremap = true, silent = true } },
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

for _, keymap_class in ipairs({ Movement, Edit, Cmd, Fold, ModeSwitch, Nop }) do
    for _, keymap in ipairs(keymap_class) do
        key_mapper(keymap[1], keymap[2], keymap[3], keymap[4])
    end
end

for _, plugin_keymap in pairs(Plugins) do
    for _, keymap in ipairs(plugin_keymap) do
        key_mapper(keymap[1], keymap[2], keymap[3], keymap[4])
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
