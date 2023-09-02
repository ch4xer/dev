M = function()
    require("nvim-surround").setup{
        keymaps = {
            visual = "r",
            delete = "dr",
            change = "cr",
        },
    }
end

return M
