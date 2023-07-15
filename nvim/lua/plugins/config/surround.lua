M = function()
    require("nvim-surround").setup({
        keymaps = {
            visual = "s",
            delete = "ds",
            change = "cs",
        },
    })
end

return M
