return {
    {
        'christoomey/vim-tmux-navigator',
        lazy = false,
    },
    {
        'famiu/bufdelete.nvim',
        lazy = false
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
        lazy = false,
    },
    {
        'tpope/vim-obsession',
        lazy = false,
    },
    {
        'lambdalisue/suda.vim',
        lazy = false,
    },
    {
        'RRethy/vim-illuminate',
        event = 'VeryLazy',
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        main = "ibl",
        event = 'VeryLazy',
        config = function()
            require("ibl").setup {}
        end,
    },
    {
        'kevinhwang91/nvim-ufo',
        config = function()
            local handler = function(virtText, lnum, endLnum, width, truncate)
                local newVirtText = {}
                local suffix = (' 󰁂 %d '):format(endLnum - lnum)
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
            vim.api.nvim_set_hl(0, "Folded", { guifg = nil, guibg = nil })
        end,
        dependencies = { 'kevinhwang91/promise-async' },
        event = 'VeryLazy'
    },
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
                    autojump = true,
                }
            }
        end,
    },
}
