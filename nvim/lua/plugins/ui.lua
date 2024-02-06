return {
    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                style = "storm",
                transparent = true,
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
                    colors.bg_statusline = colors.none
                    -- useless, may caused by bug
                    -- colors.Folded = {
                    --     bg = colors.none,
                    --     fg = colors.none,
                    -- }
                end,
            })
            vim.cmd("colorscheme tokyonight")
            vim.api.nvim_set_hl(0, "Folded", { guifg = nil, guibg = nil })
        end,
    },
    {
        'akinsho/bufferline.nvim',
        dependencies = {
            'folke/tokyonight.nvim',
        },
        event = 'UIEnter',
        config = function()
            require('bufferline').setup {
                options = {
                    close_command = "Bdelete %d",
                    indicator = {
                        style = 'none',
                    },
                    name_formatter = function(buf)
                        if buf.name:match('%.*') then
                            return vim.fn.fnamemodify(buf.name, ':t:r')
                        end
                    end,
                    diagnostics = "nvim_lsp",
                    offsets = { { filetype = "neo-tree", text = "Neotree", text_align = "center" } },
                    enforce_regular_tabs = true,
                    tab_size = 12,
                }
            }
        end,
    },
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
                    section_separators = { left = '', right = '' },
                },
                sections = {
                    lualine_a = {
                        -- this prevent the shrink from <C-o>:stopinsert when exit insert mode
                        {
                            'mode',
                            icons_enabled = true,
                            fmt = function(str)
                                local indicator = str:sub(1, 1)
                                if indicator == 'N' then
                                    return ''
                                end
                                if indicator == 'I' then
                                    return ''
                                end
                                if indicator == 'V' then
                                    return ''
                                end
                                return ''
                                -- return str:sub(1, 3)
                            end,
                        },
                    },
                    lualine_b = {
                        'branch',
                        'diagnostics'
                    },
                    lualine_c = { 'filename', 'diff' },
                    lualine_x = {},
                    lualine_y = { 'progress', 'location' },
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
            }
        end
    },
}
