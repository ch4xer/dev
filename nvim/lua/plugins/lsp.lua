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
        cond = vim.g.is_not_large,
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
            vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
                vim.lsp.handlers.hover,
                { border = 'rounded' }
            )
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
}
