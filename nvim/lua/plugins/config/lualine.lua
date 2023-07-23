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
                -- this prevent the shrink from <C-o>:stopinsert when exit insert mode
                { 'mode', icons_enabled = true, fmt = function(str) return str:sub(1, 3) end },
                -- 'branch',
                'diff',
                'diagnostics'
            },
            lualine_c = { 'filename' },
            lualine_x = { 'encoding', 'filetype' },
            lualine_y = { 'progress', 'location' },
            lualine_z = {}
        },
    }
end

return M
