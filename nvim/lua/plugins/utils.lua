return {
    {
        'alexghergh/nvim-tmux-navigation',
        config = true,
        lazy = false,
    },
    {
        'famiu/bufdelete.nvim',
        event = 'VeryLazy',
    },
    {
        'ojroques/nvim-osc52',
        config = function()
            require('osc52').setup {
                max_length = 0,    -- Maximum length of selection (0 for no limit)
                silent     = true, -- Disable message on successful copy
                trim       = true, -- Trim surrounding whitespaces before copy
            }
        end,
    },
    {
        'tpope/vim-obsession',
        lazy = false,
    },
    {
        'RRethy/vim-illuminate',
        event = 'VeryLazy',
    },
    -- {
    --     "shellRaining/hlchunk.nvim",
    --     event = { "UIEnter" },
    --     config = function()
    --         require("hlchunk").setup({
    --             chunk = {
    --                 notify = false,
    --                 style = {
    --                     { fg = "#7aa2f7" },
    --                     { fg = "#c21f30" }, -- this fg is used to highlight wrong chunk
    --                 },
    --             },
    --             line_num = {
    --                 enable = false,
    --             },
    --             blank = {
    --                 enable = false,
    --             },
    --             indent = {
    --                 enable = false,
    --             }
    --         })
    --     end
    -- },
    -- {
    --     'lukas-reineke/indent-blankline.nvim',
    --     main = "ibl",
    --     event = 'VeryLazy',
    --     config = function()
    --         require("ibl").setup {}
    --     end,
    -- },
    -- {
    --     'kevinhwang91/nvim-ufo',
    --     config = function()
    --         local handler = function(virtText, lnum, endLnum, width, truncate)
    --             local newVirtText = {}
    --             local suffix = ('  %d '):format(endLnum - lnum)
    --             local sufWidth = vim.fn.strdisplaywidth(suffix)
    --             local targetWidth = width - sufWidth
    --             local curWidth = 0
    --             for _, chunk in ipairs(virtText) do
    --                 local chunkText = chunk[1]
    --                 local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    --                 if targetWidth > curWidth + chunkWidth then
    --                     table.insert(newVirtText, chunk)
    --                 else
    --                     chunkText = truncate(chunkText, targetWidth - curWidth)
    --                     local hlGroup = chunk[2]
    --                     table.insert(newVirtText, { chunkText, hlGroup })
    --                     chunkWidth = vim.fn.strdisplaywidth(chunkText)
    --                     -- str width returned from truncate() may less than 2nd argument, need padding
    --                     if curWidth + chunkWidth < targetWidth then
    --                         suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
    --                     end
    --                     break
    --                 end
    --                 curWidth = curWidth + chunkWidth
    --             end
    --             table.insert(newVirtText, { suffix, 'MoreMsg' })
    --             return newVirtText
    --         end
    --         require('ufo').setup({
    --             provider_selector = function()
    --                 return { 'treesitter', 'indent' }
    --             end,
    --             fold_virt_text_handler = handler
    --         })
    --     end,
    --     dependencies = { 'kevinhwang91/promise-async' },
    --     event = "VeryLazy",
    -- },
    {
        "folke/flash.nvim",
        event = 'VeryLazy',
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
                    -- options used for remote flash
                    remote = {
                        remote_op = { restore = true, motion = true },
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
