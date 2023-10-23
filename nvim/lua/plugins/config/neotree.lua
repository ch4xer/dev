M = function()
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
            width = 25,
            auto_expand_width = false,
            mappings = {
                ["<bs>"] = "next_source",
                ["<esc>"] = "cancel",
                ["r"] = "rename",
                ["q"] = "close_window",
                ["/"] = "fuzzy_finder",
            }
        },
        filesystem = {
            follow_current_file = {
                enabled = true,
                leave_dirs_open = false,
            },
            hijack_netrw_behavior = "open_default",
            window = {
                mappings = {
                    ["<2-LeftMouse>"] = "open",
                    ["<cr>"] = "open",
                    ["a"] = "add",
                    ["y"] = "copy_to_clipboard",
                    ["s"] = "open_split",
                    ["v"] = "open_vsplit",
                    ["."] = "set_root",
                    ["x"] = "cut_to_clipboard",
                    ["p"] = "paste_from_clipboard",
                    ["d"] = "delete",
                },
                fuzzy_finder_mappings = {
                    ["<down>"] = "move_cursor_down",
                    ["<up>"] = "move_cursor_up",
                },
            },
        },
        document_symbols = {
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
            }
        }
    })
end

return M
