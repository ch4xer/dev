M = function()
    require('lspsaga').setup({
        ui = {
            code_action = "󱓈 ",
        },
        code_action = {
            keys = {
                quit = { 'q', '<ESC>' },
                exec = '<CR>',
            }
        },
        definition = {
            keys = {
                edit = '<CR>',
                vsplit = 'v',
                split = 's',
                tabe = 't',
                -- can only use string here
                quit = '<ESC>',
            }
        },
        rename = {
            keys = {
                quit = '<ESC>',
                exec = '<CR>',
            }
        },
        finder = {
            max_height = 0.5,
            min_width = 30,
            force_max_height = false,
            keys = {
                jump_to = 'g',
                toggle_or_open = '<CR>',
                vsplit = 'v',
                split = 's',
                tabe = 't',
                quit = { 'q', '<ESC>' },
            },
        },
    })
end

return M
