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
                        dos = '', -- e70f
                        mac = '', -- e711
                    }
                },
                'mode'
            },
            -- lualine_b = {'branch', 'diff', 'diagnostics'},
            lualine_b = { 'diff', 'diagnostics' },
            lualine_c = { 'filename' },
            lualine_x = { 'encoding', 'filetype' },
            lualine_y = { 'progress' },
            lualine_z = { 'location' }
        }
    }
end

return M
