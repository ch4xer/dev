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
                    normal = "ys",
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
                    ["<"] = {
                        add = { "<", ">" },
                        find = function()
                            return M.get_selection({ motion = "a<" })
                        end,
                        delete = "^(.?)().-(?.)()$",
                    },
                }
            }
        end,
        event = "VeryLazy",
    },
}
