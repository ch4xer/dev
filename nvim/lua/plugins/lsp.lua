return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'williamboman/mason.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',
        },
        -- BufRead will skip empty new buffer
        lazy = false,
        cond = vim.g.is_not_large,
        config = function()
            require('mason').setup()
            require('mason-tool-installer').setup {
                ensure_installed = {
                    'rust-analyzer',
                    'gopls',
                    'clangd',
                    'lua-language-server',
                    'pyright',
                    'dockerfile-language-server',
                    'bash-language-server',
                    'marksman',
                    'json-lsp',
                }
            }
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
    }
}
