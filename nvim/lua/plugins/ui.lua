return {
    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                style = "night",
                styles = {
                    comments = { italic = true },
                    keywords = { italic = true },
                    functions = {},
                    variables = {},
                    sidebars = "transparent",
                    floats = "transparent",
                },

                on_colors = function(colors)
                    colors.border = "#565f89"
                    -- colors.bg_statusline = colors.none
                end,
                on_highlights = function(hl, c)
                    hl.Folded = {
                        fg = "#7aa2f7",
                        bg = nil,
                    }
                    hl.VerticalSplit = {
                        fg = "#565f89",
                        bg = nil,
                    }
                    -- popup menu transparent
                    hl.Pmenu = {
                        bg = nil,
                    }
                end,
            })
            vim.cmd("colorscheme tokyonight")
        end,
    },
    -- {
    --     'akinsho/bufferline.nvim',
    --     dependencies = {
    --         'folke/tokyonight.nvim',
    --     },
    --     event = 'UIEnter',
    --     config = function()
    --         require('bufferline').setup {
    --             options = {
    --                 close_command = "Bdelete %d",
    --                 indicator = {
    --                     style = 'none',
    --                 },
    --                 name_formatter = function(buf)
    --                     if buf.name:match('%.*') then
    --                         return vim.fn.fnamemodify(buf.name, ':t:r')
    --                     end
    --                 end,
    --                 diagnostics = "nvim_lsp",
    --                 diagnostics_indicator = function(count, level, diagnostics_dict, context)
    --                     local icon = level:match("error") and " " or " "
    --                     return icon .. count
    --                 end,
    --                 offsets = { { filetype = "neo-tree", text = "Neotree", text_align = "center" } },
    --                 enforce_regular_tabs = true,
    --                 tab_size = 12,
    --             }
    --         }
    --     end,
    -- },
    {
        'hoob3rt/lualine.nvim',
        dependencies = {
            'folke/tokyonight.nvim',
            'folke/noice.nvim',
        },
        event = 'UIEnter',
        config = function()
            require('lualine').setup {
                options = {
                    theme = 'tokyonight',
                    globalstatus = true,
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                },
                sections = {
                    lualine_a = {
                        -- this prevent the shrink from <C-o>:stopinsert when exit insert mode
                        -- {
                        --     'mode',
                        --     icons_enabled = true,
                        --     fmt = function(str)
                        --         local indicator = str:sub(1, 1)
                        --         if indicator == 'N' then
                        --             return ''
                        --         end
                        --         if indicator == 'I' then
                        --             return ''
                        --         end
                        --         if indicator == 'V' then
                        --             return ''
                        --         end
                        --         return ''
                        --         -- return str:sub(1, 3)
                        --     end,
                        -- },
                        -- 'buffers'
                    },
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
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        event = 'UIEnter',
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
                    {
                        filter = {
                            event = "msg_show",
                            find = "gitsigns",
                        },
                        opts = { skip = true },
                    },
                },
            }
        end
    },
}
