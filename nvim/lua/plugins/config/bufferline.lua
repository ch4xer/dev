M = function ()
    require('bufferline').setup {
        options = {
            -- numbers = "buffer_id",
            -- instead, use bufdelete plugin
            -- close_command = "bdelete! %d",
            close_command = "Bdelete %d",
            -- right_mouse_command = "Bdelete %d",
            left_mouse_command = "buffer %d",
            middle_mouse_command = nil,
            buffer_close_icon = '',
            modified_icon = '●',
            close_icon = '',
            left_trunc_marker = '',
            right_trunc_marker = '',
            indicator = {
                icon = '>',
                style = 'underline',
            },
            name_formatter = function(buf)
                if buf.name:match('%.md') then
                    return vim.fn.fnamemodify(buf.name, ':t:r')
                end
            end,
            max_name_length = 18,
            max_prefix_length = 15,
            tab_size = 18,
            diagnostics = "nvim_lsp",
            diagnostics_indicator = function(count, level, diagnostics_dict, context)
                return "("..count..")"
            end,
            -- NOTE: this will be called a lot so don't do any heavy processing here
            custom_filter = function(buf_number)
                -- filter out filetypes you don't want to see
                if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
                    return true
                end
                -- filter out by buffer name
                if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
                    return true
                end
                -- filter out based on arbitrary rules
                -- e.g. filter out vim wiki buffer from tabline in your work repo
                if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
                    return true
                end
            end,
            offsets = {{filetype = "NvimTree", text = "File Explorer"}},
            show_buffer_icons = true,
            show_buffer_close_icons = true,
            show_close_icon = false,
            show_tab_indicators = true,
            persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
            -- can also be a table containing 2 custom separators
            -- [focused and unfocused]. eg: { '|', '|' }
            enforce_regular_tabs = true,
            always_show_bufferline = true,
            sort_by = 'id'
        }
    }
end

return M
