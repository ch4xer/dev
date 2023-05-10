M = function()
    require('lspsaga').setup({
        ui = {
            code_action = "󱓈 ",
        },
        code_action = {
            keys = {
                quit = '<ESC>',
                exec = '<CR>',
            }
        },
        definition = {
            edit = '<CR>',
            vsplit = 'v',
            split = 's',
            tabe = 't',
            quit = '<ESC>',
        },
        rename = {
            quit = '<ESC>',
            exec = '<CR>',
        },
        finder = {
            max_height = 0.5,
            min_width = 30,
            force_max_height = false,
            keys = {
                jump_to = 'g',
                expand_or_jump = '<CR>',
                vsplit = 'v',
                split = 's',
                tabe = 't',
                quit = { 'q', '<ESC>' },
                close_in_preview = '<ESC>',
            },
        },
    })
end

return M
