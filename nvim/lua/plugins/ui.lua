return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        lazy = false,
        config = function()
            require("catppuccin").setup({
                term_colors = false,         -- sets terminal colors (e.g. `g:terminal_color_0`)
                styles = {                   -- Handles the styles of general hi groups (see `:h highlight-args`):
                    comments = { "italic" }, -- Change the style of comments
                    conditionals = { "italic" },
                    functions = { "italic" },
                    properties = { "italic" },
                },
                integrations = {
                    neotree = true,
                },
            })

            vim.cmd.colorscheme "catppuccin"
        end
    },
    -- {
    --     'folke/tokyonight.nvim',
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         require("tokyonight").setup({
    --             -- storm, night, day are similar, moon is specially soft
    --             style = "moon",
    --             styles = {
    --                 comments = { italic = true },
    --                 keywords = { italic = true },
    --                 functions = { italic = true },
    --                 variables = {},
    --                 sidebars = "transparent",
    --                 floats = "transparent",
    --             },
    --
    --             on_colors = function(colors)
    --                 colors.border = "#565f89"
    --                 -- use night bg color
    --                 -- colors.bg = "#1a1b26"
    --             end,
    --             on_highlights = function(hl, c)
    --                 hl.Folded = {
    --                     fg = "#7aa2f7",
    --                     bg = nil,
    --                 }
    --                 hl.VerticalSplit = {
    --                     fg = "#565f89",
    --                     bg = nil,
    --                 }
    --                 -- popup menu transparent
    --                 hl.Pmenu = {
    --                     bg = nil,
    --                 }
    --             end,
    --         })
    --         vim.cmd("colorscheme tokyonight")
    --     end,
    -- },
    {
        'hoob3rt/lualine.nvim',
        -- `User Lazyest` will cause display issue, werid
        event = "UIEnter",
        config = function()
            require('lualine').setup {
                options = {
                    globalstatus = true,
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                    ignore_focus = { "neo-tree" }
                },
                sections = {
                    lualine_a = {},
                    lualine_b = {
                        {
                            'buffers',
                            hide_filename_extension = true,
                            symbols = {
                                modified = '',
                                alternate_file = '',
                            },
                        }
                    },
                    lualine_c = {},
                    lualine_x = {
                        'diagnostics',
                        'branch',
                    },
                    lualine_y = {
                        {
                            'progress',
                            fmt = function(str)
                                local str1 = str:gsub(' ', '')
                                return ' ' .. str1
                            end,
                        }
                    },
                    lualine_z = {}
                },
            }
        end
    },
    {
        'lewis6991/gitsigns.nvim',
        config = true,
        event = 'User Lazyest',
    },
    {
        'glepnir/dashboard-nvim',
        event = 'UIEnter',
        cond = function() return #vim.v.argv == 2 end,
        config = function()
            local version = vim.version()
            local header = {
                "",
                "   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ",
                "    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ",
                "          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ",
                "           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ",
                "          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ",
                "   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ",
                "  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ",
                " ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ",
                " ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ",
                "      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ",
                "       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ",
                "N E O V I M - v " .. version.major .. "." .. version.minor,
                "",
            }
            local center = {
                {
                    desc = "Find File                     ",
                    keymap = "",
                    key = "f",
                    icon = " ",
                    action = "lua require('fzf-lua').files()",
                },
                {
                    desc = "New File",
                    keymap = "",
                    key = "n",
                    icon = " ",
                    action = "enew",
                },
                {
                    desc = "Restore Session Of CWD",
                    keymap = "",
                    key = "s",
                    icon = "󰚰 ",
                    action = "source Session.vim",
                },
                {
                    desc = "Update Plugins",
                    keymap = "",
                    key = "u",
                    icon = " ",
                    action = "Lazy update",
                },
                {
                    desc = "Config",
                    keymap = "",
                    key = "c",
                    icon = " ",
                    action = "lua require('fzf-lua').files({cwd='~/.config/nvim'})",
                },
                {
                    desc = "Exit",
                    keymap = "",
                    key = "q",
                    icon = " ",
                    action = "exit",
                },
            }
            local custom_footer = { "The quieter you become", "The more you are able to hear" }
            vim.api.nvim_create_autocmd("Filetype", {
                pattern = "dashboard",
                group = vim.api.nvim_create_augroup("Dashboard_au", { clear = true }),
                callback = function()
                    vim.cmd([[
            setlocal buftype=nofile
            setlocal nonumber norelativenumber nocursorline noruler
        ]])
                end,
            })

            require('dashboard').setup({
                theme = 'doom',
                config = {
                    header = header,
                    center = center,
                    footer = custom_footer,
                },

            })
        end,
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        event = 'User Lazyest',
        config = function()
            require('noice').setup {
                cmdline = {
                    view = "cmdline",
                },
                messages = {
                    view = "mini"
                },
                notify = {
                    enabled = false,
                },
                presets = {
                    bottom_search = true,   -- use a classic bottom cmdline for search
                    lsp_doc_border = false, -- add a border to hover docs and signature help
                },
                routes = {
                    {
                        filter = {
                            event = "msg_show",
                            kind = "",
                            find = "written",
                        },
                        opts = { skip = true },
                    },
                },
            }
        end
    },
    {
        'nvim-tree/nvim-web-devicons',
        config = function()
            require 'nvim-web-devicons'.setup {
                override_by_extension = {
                    ["go"] = {
                        icon = "󰟓",
                        color = "#519aba",
                        cterm_color = "74",
                        name = "Go",
                    },
                    ["py"] = {
                        icon = "",
                        color = "#7aa2f7",
                        cterm_color = "214",
                        name = "Py",
                    },
                },
            }
        end
    }
}
