M = function()
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
            bottom_search = true,         -- use a classic bottom cmdline for search
            lsp_doc_border = false,       -- add a border to hover docs and signature help
        },
    }
end

return M
