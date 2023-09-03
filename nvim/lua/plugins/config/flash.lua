M = function()
    -- vim.cmd("highlight FlashLabel guifg=#ffffff guibg=#24283b gui=bold")
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
                enabled = false, -- enable flash for search
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
end

return M
