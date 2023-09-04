M = function ()
    require('bufferline').setup {
        options = {
            close_command = "Bdelete %d",
            buffer_close_icon = '',
            modified_icon = '●',
            close_icon = '',
            indicator = {
                icon = '>',
                style = 'underline',
            },
            name_formatter = function(buf)
                if buf.name:match('%.*') then
                    return vim.fn.fnamemodify(buf.name, ':t:r')
                end
            end,
            diagnostics = "nvim_lsp",
            offsets = {{filetype = "NvimTree", text = "File Explorer", text_align = "center"}},
            enforce_regular_tabs = true,
        }
    }
end

return M
