return {
    {
        'windwp/nvim-autopairs',
        config = true,
        event = { 'InsertEnter' }
    },
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        config = true,
        cmd = {"ToggleTerm"}
    },
    {
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup {
                keymaps = {
                    visual = "s",
                    normal = "ys",
                    delete = "ds",
                    change = "cs",
                },
                surrounds = {
                    ["("] = {
                        add = { "(", ")" },
                        find = function()
                            return M.get_selection({ motion = "a(" })
                        end,
                        delete = "^(.?)().-(?.)()$",
                    },
                    ["{"] = {
                        add = { "{", "}" },
                        find = function()
                            return M.get_selection({ motion = "a{" })
                        end,
                        delete = "^(.?)().-(?.)()$",
                    },
                    ["["] = {
                        add = { "[", "]" },
                        find = function()
                            return M.get_selection({ motion = "a[" })
                        end,
                        delete = "^(.?)().-(?.)()$",
                    },
                    ["<"] = {
                        add = { "<", ">" },
                        find = function()
                            return M.get_selection({ motion = "a<" })
                        end,
                        delete = "^(.?)().-(?.)()$",
                    },
                }
            }
        end,
        event = "User Lazyest",
    },
    {
        "kdheepak/lazygit.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        cmd = { "LazyGit", },
    },
    {
        "iamcco/markdown-preview.nvim",
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
        config = function()
            vim.g.mkdp_browser = 'min-browser'
            vim.g.mkdp_auto_close = 0
            vim.g.mkdp_combine_preview = 1
        end,
    },
    {
        'lervag/vimtex',
        ft = "tex",
        config = function()
            vim.g.vimtex_view_method = 'zathura'
            vim.g.vimtex_quickfix_ignore_filters = { "Underfull", "Overfull", "Missing" }
        end,
    },
    {
        'alexghergh/nvim-tmux-navigation',
        config = true,
        lazy = false,
    },
    {
        'echasnovski/mini.bufremove',
        version = false,
        config = true,
        lazy = false
    },
    {
        'echasnovski/mini.sessions',
        version = false,
        lazy = false,
        config = true,
        opts = {
            -- Hook functions for actions. Default `nil` means 'do nothing'.
            hooks = {
                pre = { write = function() vim.cmd("Neotree close") end },
                post = { read = nil, write = nil, delete = nil },
            },
        }
    },
    {
        'echasnovski/mini.cursorword',
        version = false,
        event = 'User Lazyest',
        config = true
    },
    {
        'echasnovski/mini.hipatterns',
        version = false,
        event = 'User Lazyest',
        config = function()
            local hipatterns = require('mini.hipatterns')
            hipatterns.setup({
                highlighters = {
                    hex_color = hipatterns.gen_highlighter.hex_color(),
                },
            })
        end
    },
    {
        -- ufo can prevent blocking nvim with treesitter fold method
        -- which is weird when switching to a buffer with large file
        'kevinhwang91/nvim-ufo',
        dependencies = { 'kevinhwang91/promise-async' },
        event = "User Lazyest",
        config = function()
            local handler = function(virtText, lnum, endLnum, width, truncate)
                local newVirtText = {}
                local suffix = ('  %d '):format(endLnum - lnum)
                local sufWidth = vim.fn.strdisplaywidth(suffix)
                local targetWidth = width - sufWidth
                local curWidth = 0
                for _, chunk in ipairs(virtText) do
                    local chunkText = chunk[1]
                    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    if targetWidth > curWidth + chunkWidth then
                        table.insert(newVirtText, chunk)
                    else
                        chunkText = truncate(chunkText, targetWidth - curWidth)
                        local hlGroup = chunk[2]
                        table.insert(newVirtText, { chunkText, hlGroup })
                        chunkWidth = vim.fn.strdisplaywidth(chunkText)
                        -- str width returned from truncate() may less than 2nd argument, need padding
                        if curWidth + chunkWidth < targetWidth then
                            suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                        end
                        break
                    end
                    curWidth = curWidth + chunkWidth
                end
                table.insert(newVirtText, { suffix, 'MoreMsg' })
                return newVirtText
            end
            require('ufo').setup({
                provider_selector = function()
                    return { 'treesitter', 'indent' }
                end,
                fold_virt_text_handler = handler
            })
        end,
    },
    {
        "folke/flash.nvim",
        event = 'User Lazyest',
        config = function()
            require('flash').setup {
                labels = "abcdefghijklmnopqrstuvwxyz0123456789",
                label = {
                    rainbow = {
                        enabled = true,
                        -- number between 1 and 9
                        shade = 5,
                    },
                    uppercase = false,
                },
                modes = {
                    -- options used when flash is activated through
                    -- a regular search with `/` or `?`
                    search = {
                        enabled = true, -- enable flash for search
                    },
                    -- options used when flash is activated through
                    -- `f`, `F`, `t`, `T`, `;` and `,` motions
                    char = {
                        enabled = false,
                    },
                    -- options used for treesitter selections
                    -- `require("flash").treesitter()`
                    treesitter = {
                        labels = "abcdefghijklmnopqrstuvwxyz0123456789",
                        label = { before = true, after = true, style = "inline" },
                        jump = { pos = "range" },
                        highlight = {
                            backdrop = false,
                            matches = false,
                        },
                    },
                },
                -- options for the floating window that shows the prompt,
                -- for regular jumps
                prompt = {
                    enabled = false,
                },
                jump = {
                    pos = "end",
                    autojump = false,
                }
            }
        end,
    },
}
