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
            width = 30,
            auto_expand_width = false,
            mappings = {
                ["<2-LeftMouse>"] = "open",
                ["<cr>"] = "open",
                ["<esc>"] = "cancel",
                ["P"] = { "toggle_preview", config = { use_float = true } },
                ["s"] = "open_split",
                ["v"] = "open_vsplit",
                ["t"] = "open_tabnew",
                ["r"] = "rename",
                ["q"] = "close_window",
                ["J"] = "prev_source",
                ["K"] = "next_source",
                ["?"] = "show_help",
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
                    ["a"] = "add",
                    ["<bs>"] = "navigate_up",
                    ["y"] = "copy_to_clipboard",
                    ["."] = "set_root",
                    ["x"] = "cut_to_clipboard",
                    ["p"] = "paste_from_clipboard",
                    ["H"] = "toggle_hidden",
                    ["d"] = "delete",
                    ["/"] = "fuzzy_finder",
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
            }
        }
    })
end

return M
