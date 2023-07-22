M = function()
    require('lualine').setup {
        options = {
            globalstatus = true,
            section_separators = { left = '', right = '' },
        },
        sections = {
            lualine_a = {
                {
                    'fileformat',
                    symbols = {
                        unix = '', -- e712
                        -- unix = '', -- e712
                        dos = '', -- e70f
                        mac = '', -- e711
                    }
                },
            },
            lualine_b = {
                'mode',
                -- 'branch',
                'diff',
                'diagnostics'
            },
            lualine_c = { 'filename' },
            lualine_x = { 'encoding', 'filetype' },
            lualine_y = { 'progress', 'location' },
            lualine_z = {}
        }
    }
end

return M
