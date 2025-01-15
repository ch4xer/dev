return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "saghen/blink.cmp",
            "williamboman/mason.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            "stevearc/conform.nvim",
        },
        -- BufRead will skip empty new buffer
        lazy = false,
        cond = vim.g.is_not_large,
        config = function()
            require("mason").setup()
            require("mason-tool-installer").setup({
                ensure_installed = {
                    "rust-analyzer",
                    "gopls",
                    "clangd",
                    "lua-language-server",
                    "pyright",
                    "dockerfile-language-server",
                    "bash-language-server",
                    "marksman",
                    "json-lsp",
                    "isort",
                    "black",
                    "prettierd",
                    "vue-language-server",
                    "typescript-language-server",
                },
            })
            local mason_registry = require('mason-registry')
            local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path() ..
                '/node_modules/@vue/language-server'

            local lspconfig = require("lspconfig")
            local capabilities = require('blink.cmp').get_lsp_capabilities()
            lspconfig.clangd.setup({
                capabilities = capabilities,
                cmd = { "clangd", "--fallback-style=llvm", "--offset-encoding=utf-16" },
            })
            lspconfig.ts_ls.setup {
                capabilities = capabilities,
                init_options = {
                    plugins = {
                        {
                            name = '@vue/typescript-plugin',
                            location = vue_language_server_path,
                            languages = { 'vue' },
                        },
                    },
                },
                filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
            }
            lspconfig.volar.setup {}
            lspconfig.rust_analyzer.setup {
                capabilities = capabilities,
                settings = {
                    ['rust-analyzer'] = {
                        checkOnSave = {
                            command = "clippy",
                        },
                    }
                }
            }

            local other_servers = {
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
                }
            end
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover,
                { border = "rounded" })

            require("conform").setup({
                formatters_by_ft = {
                    python = { "isort", "black" },
                    javascript = { "prettierd" },
                    markdown = { "prettierd" },
                },
            })
            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        end,
    },
}
