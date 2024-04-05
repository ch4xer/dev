return {
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
        build = ':TSUpdate',
        event = 'VeryLazy',
        config = function()
            require('nvim-treesitter.configs').setup {
                -- dont install latex, it's too slow
                ensure_installed = {
                    "c",
                    "lua",
                    "vim",
                    "vimdoc",
                    "go",
                    "rust",
                    "java",
                    "json",
                    "python",
                    "dockerfile",
                    "php",
                    "cpp",
                    "bash",
                    "yaml",
                    "toml",
                    "xml",
                    "markdown",
                    "markdown_inline",
                },
                -- switch to buildin syntax highlighting
                highlight = {
                    enable = true,
                    disable = function(lang, buf)
                        local max_filesize = 100 * 1024 -- 100 KB
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,
                    additional_vim_regex_highlighting = false,
                },
                indent = {
                    enable = true,
                },
                incremental_selection = {
                    enable = false,
                    -- keymaps = {
                    --     init_selection = '<CR>',
                    --     node_incremental = '<CR>',
                    --     node_decremental = '<BS>',
                    --     scope_incremental = '<TAB>',
                    -- }
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["p"] = "@parameter.outer",
                        },
                        include_surrounding_whitespace = true,
                    },
                },
            }
        end
    },
}
