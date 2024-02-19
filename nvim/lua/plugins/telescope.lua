return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-fzf-native.nvim',
        },
        config = function()
            local actions = require('telescope.actions')
            require('telescope').setup {
                defaults = {
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                        "--hidden",
                        "--glob",
                        "!**/.git/*",
                    },
                    mappings = {
                        i = {
                            ["<esc>"] = actions.close,
                            ["<C-x>"] = actions.select_vertical,
                            ["<Tab>"] = actions.select_vertical,
                            ["<CR>"] = actions.select_default,
                        }
                    }
                },
                pickers = {
                    find_files = {
                        -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
                        find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,           -- false will only do exact matching
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true, -- override the file sorter
                        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                        -- the default case_mode is "smart_case"
                    }
                }
            }
            require('telescope').load_extension('fzf')
        end,
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
    },

}
