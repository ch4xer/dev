M = function()
    local vim = vim
    require('edgy').setup({
        animate = {
            enabled = false,
        },
        left = {
            {
                title = "files",
                ft = "neo-tree",
                filter = function(buf)
                    return vim.b[buf].neo_tree_source == "filesystem"
                end,
                size = { height = 0.5 },
            },
            {
                title = "symbols",
                ft = "neo-tree",
                filter = function(buf)
                    return vim.b[buf].neo_tree_source == "document_symbols"
                end,
                pinned = true,
                open = "Neotree position=right document_symbols"
            },
            "neo-tree",
        },
    })
end

return M
