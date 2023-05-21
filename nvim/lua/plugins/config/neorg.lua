M = function ()
    require('neorg').setup {
        load = {
            ["core.defaults"] = {}, -- default behavior
            ["core.concealer"] = {}, -- add icon to documents
            ["core.completion"] = {
                config = {
                    engine = "nvim-cmp",
                },
            },
            ["core.export"] = {}, -- export to markdown
            ["core.integrations.treesitter"] = {},
            ["core.clipboard.code-blocks"] = {}, -- remove whitespace when copying code block
            -- ["core.esupports.hop"] = {}, -- press <CR> to follow a link
            ["core.esupports.indent"] = {}, -- auto indent based on treesitter

        }
    }
end

return M
