M = function()
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
    require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/snippets" })
    require('neogen').setup({ snippet_engine = "luasnip" })

    cmp.setup({
        completion = {
            completeopt = 'menu,menuone,noinsert',
        },
        window = {
            completion = {
                border = border,
                scrollbar = '║',
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
            }),
        },
        mapping = {
            ['<CR>'] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = false,
            }),
            ['<C-j>'] = cmp.mapping(function(fallback)
                if luasnip.expand_or_locally_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, { 'i', 's' }),
            ['<C-k>'] = cmp.mapping(function(fallback)
                if luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { 'i', 's' }),
            ['<Left>'] = cmp.mapping.close(),
            ['<Down>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
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
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
    )

    local lspconfig = require('lspconfig')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    lspconfig.intelephense.setup {
        capabilities = capabilities,
        init_options = {
            -- for intelephense
            licenceKey = '/home/ch4ser/.config/nvim/intelephense_license_key',
            globalStoragePath = '/home/ch4ser/.config',
        },
        single_file_mode = true
    }
    lspconfig.gopls.setup {
        capabilities = capabilities,
        single_file_mode = false,
        root_dir = lspconfig.util.root_pattern("go.mod"),
        settings = {
            gopls = {
                experimentalPostfixCompletions = true,
                analyses = {
                    unusedparams = true,
                    shadow = true,
                },
                staticcheck = true,
                hints = {
                    assignVariableTypes = true,
                    compositeLiteralFields = true,
                    compositeLiteralType = true,
                    constantValues = true,
                    functionTypeParameters = true,
                    parameterNames = true,
                    rangeVariableTypes = false,
                }
            },
        },
        init_options = {
            usePlaceholders = true,
        }
    }
    lspconfig.rust_analyzer.setup {
        capabilities = capabilities,
        single_file_mode = false,
        root_dir = lspconfig.util.root_pattern("Cargo.toml", "rust-project.json"),
        settings = {
            rust_analyzer = {
                cargo = {
                    fullFeatures = true,
                },
            }
        }
    }

    local other_servers = { "pyright", "rome", "lua_ls", "marksman", "dockerls", "bashls" }
    for _, server in ipairs(other_servers) do
        lspconfig[server].setup {
            capabilities = capabilities,
            single_file_mode = true,
        }
    end
    -- for clangd
    capabilities.offsetEncoding = { "utf-16" }
    lspconfig.clangd.setup {
        capabilities = capabilities
    }
    -- for python virtual projects, if using pyright or pylance(vscode only), create pyrightconfig.json file at the root of folder, contains something like:
    -- {
    -- "venvPath": "/home/ch4ser/.local/share/virtualenvs",
    -- "venv": "simple-monitor-hgrutBFy"
    -- }
    -- pylsp is unable to find virtualenvs according to single config file in project
    -- lspconfig.pylsp.setup {
    --     settings = {
    --         pylsp = {
    --             plugins = {
    --                 pycodestyle = {
    --                     ignore = { 'E501' }
    --                 },
    --                 pylint = {
    --                     enabled = true
    --                 },
    --                 flake8 = {
    --                     enabled = true
    --                 }
    --             }
    --         }
    --     }
    --     
    -- }
    -- marksman 's root directory is where .git folder exists
end

return M
