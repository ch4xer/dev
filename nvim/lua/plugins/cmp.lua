return {
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'L3MON4D3/LuaSnip',
            'rafamadriz/friendly-snippets',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-buffer',
            'onsails/lspkind-nvim',
        },
        event = "InsertEnter",
        config = function()
            local vim = vim
            local cmp = require('cmp')
            local compare = require('cmp.config.compare')
            local lspkind = require('lspkind')
            local luasnip = require 'luasnip'
            local border = {
                { "┌", "FloatBorder" },
                { "─", "FloatBorder" },
                { "┐", "FloatBorder" },
                { "│", "FloatBorder" },
                { "┘", "FloatBorder" },
                { "─", "FloatBorder" },
                { "└", "FloatBorder" },
                { "│", "FloatBorder" },
            }

            -- -- https://github.com/L3MON4D3/LuaSnip/issues/780
            luasnip.setup({
                update_events = { "TextChanged", "TextChangedI" },
                region_check_events = { "CursorMoved", "CursorHold", "InsertEnter", "CursorMovedI" },
                history = true,
            })
            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/snippets" })
            require('neogen').setup({ snippet_engine = "luasnip" })

            cmp.setup({
                completion = {
                    completeopt = 'menu,menuone,noinsert',
                },
                enabled = function()
                    -- disable completion in comments
                    local context = require 'cmp.config.context'
                    -- keep command mode completion enabled when cursor is in a comment
                    if vim.api.nvim_get_mode().mode == 'c' then
                        return true
                    else
                        return not context.in_treesitter_capture("comment")
                            and not context.in_syntax_group("Comment")
                    end
                end,
                window = {
                    completion = {
                        border = border,
                    },
                    documentation = {
                        border = 'rounded'
                    }
                },
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                formatting = {
                    format = lspkind.cmp_format({
                        mode = 'symbol_text',
                        maxwidth = 50,
                        ellipsis_char = '...',
                    }),
                },
                mapping = {
                    ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
                        elseif require("copilot.suggestion").is_visible() then
                            require("copilot.suggestion").accept()
                        elseif luasnip.jumpable(1) then
                            luasnip.jump(1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.close()
                        elseif require("copilot.suggestion").is_visible() then
                            require("copilot.suggestion").dismiss()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<Up>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<Down>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<Left>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.close()
                        end
                        fallback()
                    end, { 'i', 's' }),
                    ['<Right>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.close()
                        end
                        fallback()
                    end, { 'i', 's' }),
                },
                matching = {
                    disallow_fuzzy_matching = true,
                    disallow_fullfuzzy_matching = true,
                    disallow_partial_fuzzy_matching = false,
                    disallow_partial_matching = false,
                    disallow_prefix_unmatching = true,
                },
                preselect = cmp.PreselectMode.None,
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                }, {
                    { name = 'buffer' },
                }),
                sorting = {
                    priority_weight = 1.0,
                    comparators = {
                        compare.locality,
                        compare.sort_text,
                        -- compare.scopes,
                        compare.score,
                        compare.exact,
                        compare.recently_used,
                        compare.offset,
                        compare.kind,
                        compare.sort_text,
                        compare.length,
                        compare.order,
                    },
                }
            })

            -- auto insert `(` after select function or method item
            cmp.event:on(
                'confirm_done',
                require('nvim-autopairs.completion.cmp').on_confirm_done()
            )
        end,
    },
    {
        'zbirenbaum/copilot.lua',
        event = "InsertEnter",
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
