return {
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
        build = ':TSUpdate',
        event = 'User Lazyest',
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
                    "comment",
                },
                -- switch to buildin syntax highlighting
                highlight = {
                    enable = true,
                    disable = function(lang, buf)
                        local max_filesize = 100 * 1024 -- 100 KB
                        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
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

            -- only enable this autocmd after treesitter is loaded
            vim.api.nvim_create_autocmd("BufNew", {
                callback = function()
                    if vim.g.is_large() then
                        vim.opt.foldmethod = "manual"
                        return
                    end
                    vim.o.foldcolumn = '0'
                    vim.o.foldlevel = 99
                    vim.o.foldlevelstart = 99
                    vim.o.foldenable = true
                    if require("nvim-treesitter.parsers").get_parser() then
                        vim.opt.foldmethod = "expr"
                        vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
                    end
                end,
            })
        end
    },
}
