return {
    {
        'windwp/nvim-autopairs',
        config = true,
        event = { 'InsertEnter' }
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
