return {
    {
        'saghen/blink.cmp',
        dependencies = {
            'rafamadriz/friendly-snippets',
        },
        version = '*',
        event = "InsertEnter",
        cond = vim.g.is_not_large,
        opts = {
            completion = {
                menu = {
                    min_width = 5,
                    border = 'single',
                    draw = {
                        padding = 0,
                        gap = 1,
                        columns = { { 'kind_icon' }, { 'label', 'kind', gap = 1 } },
                        components = {
                            kind_icon = {
                                ellipsis = false,
                                text = function(ctx)
                                    local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                                    return kind_icon
                                end,
                                -- highlight will be provided by catppuccin
                            }
                        }
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 500,
                    window = { border = 'rounded' },
                },
            },
            -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
            keymap = {
                preset = 'super-tab',
                ['<CR>'] = { 'accept', 'fallback' },
                ['<Tab>'] = {
                    'accept',
                    function()
                        if require("copilot.suggestion").is_visible() then
                            require("copilot.suggestion").accept()
                            return true
                        end
                    end,
                    'snippet_forward',
                    'fallback'
                },
                ['<S-Tab>'] = {
                    'hide',
                    function()
                        if require("copilot.suggestion").is_visible() then
                            require("copilot.suggestion").dismiss()
                            return true
                        end
                    end,
                    'snippet_backward',
                    'fallback'
                },
            },
            sources = {
                default = function(ctx)
                    local success, node = pcall(vim.treesitter.get_node_at_cursor)
                    if vim.bo.filetype == 'markdown' then
                        return { 'buffer', 'path' }
                    elseif success and node and vim.tbl_contains({ 'comment', 'line_comment', 'block_comment' }, node:type()) then
                        return { 'buffer', 'path' }
                    else
                        return { 'lsp', 'path', 'snippets', 'buffer' }
                    end
                end,
                cmdline = {},

            },
        },
    },
    {
        'zbirenbaum/copilot.lua',
        event = "InsertEnter",
        cond = vim.g.is_not_large,
        config = function()
            require('copilot').setup({
                panel = {
                    enabled = false,
                },
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    debounce = 75,
                    keymap = {
                        accept = false,
                    },
                },
                filetypes = {
                    yaml = true,
                    markdown = false,
                    help = false,
                    gitcommit = false,
                    gitrebase = false,
                    hgcommit = false,
                    ["."] = false,
                    ["Dockerfile"] = true,
                },
                copilot_node_command = 'node', -- Node.js version must be > 16.x
                server_opts_overrides = {},
            })
        end
    },
}
