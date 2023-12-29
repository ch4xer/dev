return {
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
        build = ':TSUpdate',
        event = 'BufRead',
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = {
                    "c",
                    "lua",
                    "vim",
                    "vimdoc",
                    "query",
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
                    "latex",
                },
                -- switch to buildin syntax highlighting
                highlight = {
                    enable = true,
                    disable = function(lang, bufnr)
                        return lang == "" or vim.api.nvim_buf_line_count(bufnr) > 2000
                    end,
                    -- additional_vim_regex_highlighting = {"yaml"},
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
