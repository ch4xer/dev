M = function()
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
            project = {
                base_dirs = {
                    '~/Projects',
                    '~/Projects/go/src',
                }
            }
        }
    }
    require 'telescope'.load_extension('project')
end

return M
