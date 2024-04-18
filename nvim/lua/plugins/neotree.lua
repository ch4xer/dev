return {
    {
        'nvim-neo-tree/neo-tree.nvim',
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
            's1n7ax/nvim-window-picker',
        },
        config = function()
            require 'window-picker'.setup({
                filter_rules = {
                    include_current_win = false,
                    autoselect_one = true,
                    -- filter using buffer options
                    bo = {
                        -- if the file type is one of following, the window will be ignored
                        filetype = { 'neo-tree', "neo-tree-popup", "notify", "noice" },
                        -- if the buffer type is one of following, the window will be ignored
                        buftype = { 'terminal', "quickfix" },
                    },
                },
                selection_chars = 'ABCDEFGHI',
                highlights = {
                    statusline = {
                        unfocused = {
                            fg = '#ededed',
                            bg = '#7aa2f7',
                            bold = true,
                        },
                    },
                }
            })
            require("neo-tree").setup({
                sources = {
                    'filesystem',
                    'document_symbols',
                },
                source_selector = {
                    winbar = true,
                    sources = {
                        { source = "filesystem" },
                        { source = "document_symbols" },
                    },
                },
                hide_root_node = true,
                auto_clean_after_session_restore = true,
                close_if_last_window = true,
                default_component_configs = {
                    indent = {
                        padding = 0,
                    },
                    file_size = {
                        enabled = false,
                    },
                    type = {
                        enabled = false,
                    },
                    last_modified = {
                        enabled = false,
                    },
                },
                window = {
                    width = 20,
                    auto_expand_width = false,
                    mappings = {
                        ["t"] = "toggle_node",
                        ["<tab>"] = "next_source",
                        ["<esc>"] = "cancel",
                        ["r"] = "rename",
                    }
                },
                filesystem = {
                    follow_current_file = {
                        enabled = true,
                        leave_dirs_open = true,
                    },
                    hijack_netrw_behavior = "open_default",
                    window = {
                        mappings = {
                            ["<2-LeftMouse>"] = "open_with_window_picker",
                            ["<cr>"] = "open_with_window_picker",
                            ["a"] = "add",
                            ["."] = "toggle_hidden",
                            ["y"] = "copy_to_clipboard",
                            ["s"] = "split_with_window_picker",
                            ["v"] = "vsplit_with_window_picker",
                            ["x"] = "cut_to_clipboard",
                            ["p"] = "paste_from_clipboard",
                            ["d"] = "delete",
                        },
                    },
                },
                document_symbols = {
                    follow_cursor = true,
                    renderers = {
                        root = {
                            { "icon", default = "C" },
                            { "name", zindex = 10 },
                        },
                        symbol = {
                            { "indent",    with_expanders = true },
                            { "kind_icon", default = "?" },
                            {
                                "container",
                                content = {
                                    { "name", zindex = 10 },
                                }
                            }
                        },
                    },
                    window = {
                        mappings = {
                            ["<cr>"] = "jump_to_symbol",
                            ["<2-LeftMouse>"] = "jump_to_symbol",
                        }
                    },
                    kinds = {
                        Namespace = { icon = "", hl = "Include" },
                        Package = { icon = "", hl = "Label" },
                        Class = { icon = "", hl = "Include" },
                        Method = { icon = "", hl = "Function" },
                        Property = { icon = "", hl = "@property" },
                        Field = { icon = "", hl = "@field" },
                        Enum = { icon = "", hl = "@number" },
                        Interface = { icon = "", hl = "Type" },
                        Function = { icon = "󰡱", hl = "Function" },
                        Variable = { icon = "", hl = "@variable" },
                        Constant = { icon = "", hl = "Constant" },
                        String = { icon = "󰅳", hl = "String" },
                        Array = { icon = "󰅨", hl = "Type" },
                        Object = { icon = "", hl = "Type" },
                        Key = { icon = "", hl = "Constant" },
                        Null = { icon = "󰟢", hl = "Constant" },
                        EnumMember = { icon = "", hl = "Number" },
                        Struct = { icon = "", hl = "Type" },
                        Event = { icon = "", hl = "Constant" },
                        Operator = { icon = "", hl = "Operator" },
                        TypeParameter = { icon = "", hl = "Type" },
                    }

                },
            })
        end,
        cmd = { "Neotree" },
    },

}
