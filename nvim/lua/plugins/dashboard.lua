return {
    {
        'glepnir/dashboard-nvim',
        event = 'UIEnter',
        cond = function() return #vim.v.argv == 2 end,
        config = function()
            local version = vim.version()
            local header = {
                "",
                "   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ",
                "    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ",
                "          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ",
                "           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ",
                "          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ",
                "   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ",
                "  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ",
                " ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ",
                " ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ",
                "      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ",
                "       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ",
                "N E O V I M - v " .. version.major .. "." .. version.minor,
                "",
            }
            local center = {
                {
                    desc = "Find File                     ",
                    keymap = "",
                    key = "f",
                    icon = " ",
                    action = "lua require('fzf-lua').files()",
                },
                {
                    desc = "New File",
                    keymap = "",
                    key = "n",
                    icon = " ",
                    action = "enew",
                },
                {
                    desc = "Restore Session Of CWD",
                    keymap = "",
                    key = "s",
                    icon = "󰚰 ",
                    action = "source Session.vim",
                },
                {
                    desc = "Update Plugins",
                    keymap = "",
                    key = "u",
                    icon = " ",
                    action = "Lazy update",
                },
                {
                    desc = "Config",
                    keymap = "",
                    key = "c",
                    icon = " ",
                    action = "lua require('fzf-lua').files({cwd='~/.config/nvim'})",
                },
                {
                    desc = "Exit",
                    keymap = "",
                    key = "q",
                    icon = " ",
                    action = "exit",
                },
            }
            local custom_footer = { "The quieter you become", "The more you are able to hear" }
            vim.api.nvim_create_autocmd("Filetype", {
                pattern = "dashboard",
                group = vim.api.nvim_create_augroup("Dashboard_au", { clear = true }),
                callback = function()
                    vim.cmd([[
            setlocal buftype=nofile
            setlocal nonumber norelativenumber nocursorline noruler
        ]])
                end,
            })

            require('dashboard').setup({
                theme = 'doom',
                config = {
                    header = header,
                    center = center,
                    footer = custom_footer,
                },

            })
        end,
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
}
