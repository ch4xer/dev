return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        lazy = false,
        config = function()
            require("catppuccin").setup({
                transparent_background = true,
                term_colors = false,
                styles = {
                    comments = { "italic" },
                    conditionals = { "italic" },
                    functions = { "italic" },
                    properties = { "italic" },
                },
                custom_highlights = function(colors)
                    return {
                        Folded = { bg = colors.none },
                    }
                end,
                integrations = {
                    blink_cmp = true,
                }
            })

            vim.cmd.colorscheme("catppuccin")
        end,
    },
    {
        "hoob3rt/lualine.nvim",
        event = "User Lazyest",
        config = function()
            require("lualine").setup({
                options = {
                    globalstatus = true,
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                },
                sections = {
                    lualine_a = {
                        {
                            "mode",
                            icons_enabled = true,
                            fmt = function(str)
                                local indicator = str:sub(1, 1)
                                if indicator == "N" then
                                    return ""
                                end
                                if indicator == "I" then
                                    return ""
                                end
                                if indicator == "V" then
                                    return ""
                                end
                                return ""
                                -- return str:sub(1, 3)
                            end,
                        },
                    },
                    lualine_b = {
                        "filename",
                        -- {
                        --     'buffers',
                        --     hide_filename_extension = true,
                        --     symbols = {
                        --         modified = '',
                        --         alternate_file = '',
                        --     },
                        -- }
                    },
                    lualine_c = {
                        "diagnostics",
                    },
                    lualine_x = {
                        "diff",
                        "branch",
                    },
                    lualine_y = {
                        {
                            "progress",
                            fmt = function(str)
                                local str1 = str:gsub(" ", "")
                                return " " .. str1
                            end,
                        },
                    },
                    lualine_z = {},
                },
            })
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        config = true,
        event = "User Lazyest",
    },
    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        event = "User Lazyest",
        config = function()
            require("noice").setup({
                cmdline = {
                    view = "cmdline",
                },
                messages = {
                    view = "mini",
                },
                notify = {
                    enabled = false,
                },
                presets = {
                    bottom_search = true,   -- use a classic bottom cmdline for search
                    lsp_doc_border = false, -- add a border to hover docs and signature help
                },
                lsp = {
                    hover = {
                        enabled = false,
                    },
                    signature = {
                        enabled = false
                    }
                },
                routes = {
                    {
                        filter = {
                            event = 'msg_show',
                            any = {
                                { find = 'Agent service not initialized' },
                                { find = 'Not authenticated: NotSignedIn' },
                                { find = 'Client network socket disconnected' },
                                { find = 'written' },
                                { find = 'api.github.com' },
                            },
                        },
                        opts = { skip = true },
                    },
                },
            })
        end,
    },
    -- {
    --     "nvim-tree/nvim-web-devicons",
    --     config = true,
    -- },
    {
        "echasnovski/mini.icons",
        init = function()
            package.preload["nvim-web-devicons"] = function()
                require("mini.icons").mock_nvim_web_devicons()
                return package.loaded["nvim-web-devicons"]
            end
        end,
    },
}
