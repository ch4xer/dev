M = function()
    require('mason').setup()
    require('mason-tool-installer').setup {
        ensure_installed = {
            'bash-language-server',
            'clangd',
            'clang-format',
            'gopls',
            'delve',
            'intelephense',
            'lua-language-server',
            'marksman',
            'markdown-toc',
            'prettier',
            'pyright',
            'black',
            -- 'mypy',
            -- 'ruff',
            -- 'isort',
            'rome',
            'rust-analyzer',
            'rustfmt',
            'yaml-language-server',
            'yamlfmt',
            'dockerfile-language-server'
        },

        auto_update = true,
        run_on_start = true,
        start_delay = 3000, -- 3 second delay
        debounce_hours = 5, -- at least 5 hours between attempts to install/update
    }
end

return M
