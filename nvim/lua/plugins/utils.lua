return {
    {
        'mrjones2014/smart-splits.nvim',
        build = './kitty/install-kittens.bash',
        lazy = false,
    },
    {
        "ibhagwan/fzf-lua",
        config = true,
    },
    {
        "windwp/nvim-autopairs",
        config = true,
        event = { "InsertEnter" },
    },
    {
        "echasnovski/mini.cursorword",
        version = false,
        event = "User Lazyest",
        config = true,
    },
    {
        "echasnovski/mini.hipatterns",
        version = false,
        event = "User Lazyest",
        config = function()
            local hipatterns = require("mini.hipatterns")
            hipatterns.setup({
                highlighters = {
                    hex_color = hipatterns.gen_highlighter.hex_color(),
                },
            })
        end,
    },
    {
        -- ufo can prevent blocking nvim with treesitter fold method
        -- which is weird when switching to a buffer with large file
        "kevinhwang91/nvim-ufo",
        dependencies = { "kevinhwang91/promise-async" },
        event = "User Lazyest",
        config = function()
            local handler = function(virtText, lnum, endLnum, width, truncate)
                local newVirtText = {}
                local suffix = ("  %d "):format(endLnum - lnum)
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
                            suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
                        end
                        break
                    end
                    curWidth = curWidth + chunkWidth
                end
                table.insert(newVirtText, { suffix, "MoreMsg" })
                return newVirtText
            end
            require("ufo").setup({
                provider_selector = function()
                    return { "treesitter", "indent" }
                end,
                fold_virt_text_handler = handler,
            })
        end,
    },
    {
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup({
                keymaps = {
                    visual = "s",
                    normal = "ys",
                    delete = "ds",
                    change = "cs",
                },
                surrounds = {
                    ["("] = false,
                    ["["] = false,
                },
                -- remove leading and trailing whitespace
                aliases = {
                    ["("] = ")",
                    ["["] = "]",
                },
            })
        end,
        event = "User Lazyest",
    },
    {
        "folke/flash.nvim",
        event = "User Lazyest",
        config = function()
            require("flash").setup({
                labels = "abcdefghijklmnopqrstuvwxyz0123456789",
                label = {
                    rainbow = {
                        enabled = true,
                        -- number between 1 and 9
                        shade = 5,
                    },
                    uppercase = false,
                    distance = true,
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
                        enabled = false,
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
                },
            })
        end,
    },
}
