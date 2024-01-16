return {
    {
        'williamboman/mason.nvim',
        dependencies = {
            'WhoIsSethDaniel/mason-tool-installer.nvim',
            'neovim/nvim-lspconfig',
            'hrsh7th/cmp-nvim-lsp',
        },
        build = ":MasonUpdate",
        config = function()
            require('mason').setup()
            require('mason-tool-installer').setup {
                ensure_installed = {
                    'bash-language-server',
                    'gopls',
                    "clangd",
                    'delve',
                    'intelephense',
                    'lua-language-server',
                    'marksman',
                    'markdown-toc',
                    'prettier',
                    'pyright',
                    'ruff-lsp',
                    'black',
                    'rust-analyzer',
                    'yaml-language-server',
                    'yamlfmt',
                    'dockerfile-language-server'
                },

                auto_update = true,
                run_on_start = true,
                start_delay = 3000, -- 3 second delay
                debounce_hours = 5, -- at least 5 hours between attempts to install/update
            }
            local lspconfig = require('lspconfig')
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            lspconfig.intelephense.setup {
                capabilities = capabilities,
                init_options = {
                    -- for intelephense
                    licenceKey = '/home/ch4ser/.config/nvim/intelephense',
                    globalStoragePath = '/home/ch4ser/.config',
                },
            }
            lspconfig.gopls.setup {
                capabilities = capabilities,
                root_dir = lspconfig.util.root_pattern("go.mod"),
                settings = {
                    gopls = {
                        experimentalPostfixCompletions = true,
                        analyses = {
                            unusedparams = true,
                            shadow = true,
                        },
                        staticcheck = true,
                        usePlaceholders = false,
                    },
                },
            }
            lspconfig.rust_analyzer.setup {
                capabilities = capabilities,
                settings = {
                    ["rust-analyzer"] = {
                        checkOnSave = {
                            command = "clippy",
                        },
                    },
                }
            }
            lspconfig.clangd.setup {
                capabilities = capabilities,
                cmd = { "clangd", "--fallback-style=llvm", "--offset-encoding=utf-16" },
            }
            local other_servers = { "pyright", "lua_ls", "marksman", "dockerls", "bashls", "texlab" }
            for _, server in ipairs(other_servers) do
                lspconfig[server].setup {
                    capabilities = capabilities,
                }
            end

            lspconfig.ruff_lsp.setup {}
            -- pylance has some issues in neovim, like not report importMissing.
            -- local pylance = "/home/ch4ser/Tools/Other/pylance/server.bundle.js"
            -- if vim.fn.filereadable(pylance) ~= 0 then
            --     lspconfig.pyright.setup {
            --         capabilities = capabilities,
            --         cmd = { "node", pylance, "--stdio" },
            --     }
            -- else
            --     lspconfig.pyright.setup {
            --         capabilities = capabilities,
            --     }
            -- end
        end,
        event = 'BufRead',
    },
    {
        'nvimtools/none-ls.nvim',
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.prettier,
                    null_ls.builtins.formatting.black,
                },
            })
        end,
        event = 'BufRead',
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
                    }
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
        event = 'LspAttach'
    },
}
