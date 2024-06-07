return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'williamboman/mason.nvim',
        },
        -- BufRead will not avoid loading in dashboard
        -- while keeping lazy false
        event = "BufRead",
        config = function()
            require('mason').setup()
            local lspconfig = require('lspconfig')
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            lspconfig.clangd.setup {
                capabilities = capabilities,
                cmd = { "clangd", "--fallback-style=llvm", "--offset-encoding=utf-16" },
            }
            local other_servers = {
                "rust_analyzer",
                "gopls",
                "pyright",
                "lua_ls",
                "dockerls",
                "bashls",
                "texlab",
                "jsonls",
                "marksman",
            }
            for _, server in ipairs(other_servers) do
                lspconfig[server].setup {
                    capabilities = capabilities,
                    settings = {
                        rust_analyzer = {
                            checkOnSave = {
                                command = "clippy",
                            },
                        },
                        gopls = {
                            hints = {
                                assignVariableTypes = true,
                                compositeLiteralFields = true,
                                compositeLiteralTypes = true,
                                constantValues = true,
                                functionTypeParameters = true,
                                parameterNames = true,
                                rangeVariableTypes = true,
                            },
                        },
                    }
                }
            end
            vim.lsp.inlay_hint.enable()
        end,
    },
    {
        'nvimtools/none-ls.nvim',
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.prettier,
                    null_ls.builtins.formatting.black,
                    null_ls.builtins.formatting.gofumpt,
                    null_ls.builtins.diagnostics.golangci_lint,
                },
            })
        end,
        event = 'LspAttach',
    },
    {
        'glepnir/lspsaga.nvim',
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require('lspsaga').setup({
                ui = {
                    code_action = "󱓈 ",
                    colors = {
                        normal_bg = "NONE",
                    },
                },
                symbol_in_winbar = {
                    separator = "›",
                    hide_keyword = true,
                },
                lightbulb = {
                    sign = false,
                    virtual_text = false,
                },
                code_action = {
                    keys = {
                        quit = { 'q', '<ESC>' },
                        exec = '<CR>',
                    }
                },
                definition = {
                    keys = {
                        edit = '<CR>',
                        vsplit = 'v',
                        split = 's',
                        tabe = 't',
                        -- can only use string here
                        quit = '<ESC>',
                    }
                },
                rename = {
                    keys = {
                        quit = '<ESC>',
                        exec = '<CR>',
                    }
                },
                finder = {
                    max_height = 0.5,
                    min_width = 30,
                    force_max_height = false,
                    keys = {
                        jump_to = 'g',
                        toggle_or_open = '<CR>',
                        vsplit = 'v',
                        split = 's',
                        tabe = 't',
                        quit = { 'q', '<ESC>' },
                    },
                },
            })
        end,
        -- to use lspsaga terminal whenever lsp is attached
        event = 'User Lazyest'
    },
}
