return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "neovim/nvim-lspconfig",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "onsails/lspkind-nvim",
        },
        event = "InsertEnter",
        cond = vim.g.is_not_large,
        config = function()
            local vim = vim
            local cmp = require("cmp")
            local compare = require("cmp.config.compare")
            local lspkind = require("lspkind")
            local luasnip = require("luasnip")
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

            cmp.setup({
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
                enabled = function()
                    -- disable completion in comments
                    local context = require("cmp.config.context")
                    -- keep command mode completion enabled when cursor is in a comment
                    if vim.api.nvim_get_mode().mode == "c" then
                        return true
                    else
                        return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
                    end
                end,
                window = {
                    completion = {
                        border = border,
                    },
                    documentation = {
                        border = "rounded",
                    },
                },
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                formatting = {
                    format = lspkind.cmp_format({
                        mode = "symbol_text",
                        maxwidth = 50,
                        ellipsis_char = "...",
                    }),
                },
                mapping = {
                    ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
                        elseif luasnip.jumpable(1) then
                            luasnip.jump(1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.close()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<Up>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<Down>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<Left>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.close()
                        end
                        fallback()
                    end, { "i", "s" }),
                    ["<Right>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.close()
                        end
                        fallback()
                    end, { "i", "s" }),
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
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                }, {
                    { name = "buffer" },
                    { name = "path" }
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
                },
            })

            -- auto insert `(` after select function or method item
            cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
        end,
    },
}
