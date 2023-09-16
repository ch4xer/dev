M = function()
    require('mason').setup()
    require('mason-tool-installer').setup {
        ensure_installed = {
            'bash-language-server',
            'gopls',
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
                hints = {
                    assignVariableTypes = true,
                    compositeLiteralFields = true,
                    compositeLiteralType = true,
                    constantValues = true,
                    functionTypeParameters = true,
                    parameterNames = true,
                    rangeVariableTypes = false,
                },
                usePlaceholders = false,
            },
        },
    }
    lspconfig.ruff_lsp.setup {}
    local other_servers = {"rust_analyzer", "lua_ls", "marksman", "dockerls", "bashls" }
    for _, server in ipairs(other_servers) do
        lspconfig[server].setup {
            capabilities = capabilities,
            single_file_support = true,
        }
    end

    local pylance = "/home/ch4ser/Tools/Other/pylance/server.bundle.js"
    if vim.fn.filereadable(pylance) ~= 0 then
        lspconfig.pyright.setup {
            capabilities = capabilities,
            cmd = { "node", pylance, "--stdio" },
        }
    else
        lspconfig.pyright.setup {
            capabilities = capabilities,
        }
    end

    local null_ls = require("null-ls")
    null_ls.setup({
        sources = {
            null_ls.builtins.formatting.prettier,
            null_ls.builtins.formatting.black,
        },
    })
end

return M
