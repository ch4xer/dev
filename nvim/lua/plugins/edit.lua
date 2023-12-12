return {
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup({
                mappings = {
                    ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
                    basic = false,
                    ---Extra mapping; `gco`, `gcO`, `gcA`
                    extra = false,
                },
            }
            )
        end,
        event = { 'VeryLazy' }
    },
    {
        'windwp/nvim-autopairs',
        config = true,
        event = { 'InsertEnter' }
    },
    {
        'abecodes/tabout.nvim',
        dependencies = {
            'nvim-treesitter/nvim-treesitter'
        },
        config = function()
            require('tabout').setup {
                -- tabkey = '<Tab>',
                -- backwards_tabkey = '<S-Tab>',
                tabkey = '',
                backwards_tabkey = '',
                act_as_tab = true,
                act_as_shift_tab = false,
                enable_backwards = true,
                completion = false,
                tabouts = {
                    { open = "'", close = "'" },
                    { open = '"', close = '"' },
                    { open = '`', close = '`' },
                    { open = '(', close = ')' },
                    { open = '[', close = ']' },
                    { open = '{', close = '}' }
                },
                ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
                exclude = {} -- tabout will ignore these filetypes
            }
        end,
        event = { 'InsertEnter' }
    },
    {
        'folke/todo-comments.nvim',
        dependencies = { "nvim-lua/plenary.nvim" },
        config = true,
        event = { 'VeryLazy' }
    },
    {
        'danymat/neogen',
        config = true,
    },
    {
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup {
                keymaps = {
                    visual = "s",
                    delete = "ds",
                    change = "cs",
                },
                surrounds = {
                    ["("] = {
                        add = { "(", ")" },
                        find = function()
                            return M.get_selection({ motion = "a(" })
                        end,
                        delete = "^(.?)().-(?.)()$",
                    },
                    ["{"] = {
                        add = { "{", "}" },
                        find = function()
                            return M.get_selection({ motion = "a{" })
                        end,
                        delete = "^(.?)().-(?.)()$",
                    },
                    ["["] = {
                        add = { "[", "]" },
                        find = function()
                            return M.get_selection({ motion = "a[" })
                        end,
                        delete = "^(.?)().-(?.)()$",
                    },
                }
            }
        end,
        event = "VeryLazy",
    },
}
