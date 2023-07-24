M = function()
    local function ts_disable(_, bufnr)
        return vim.api.nvim_buf_line_count(bufnr) > 2000
    end
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
            "php",
            "cpp",
            "bash",
            "yaml",
            "markdown",
            "markdown_inline",
        },
        -- switch to buildin syntax highlighting
        highlight = {
            enable = true,
            disable = function(lang, bufnr)
                return lang == "" or ts_disable(lang, bufnr)
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
            -- move = {
            --     enable = true,
            --     set_jumps = true, -- whether to set jumps in the jumplist
            --     -- goto_next_start = {
            --     --     ["<C-j>"] = "@parameter.inner",
            --     -- },
            --     -- goto_previous_start = {
            --     --     ["<C-k>"] = "@parameter.inner",
            --     -- },
            -- },
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner",
                    ["ap"] = "@parameter.outer",
                    ["ip"] = "@parameter.inner"
                },
                include_surrounding_whitespace = false,
            },
        }
    }
end

return M
