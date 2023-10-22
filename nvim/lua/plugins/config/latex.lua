M = function()
    vim.g.vimtex_view_method = 'zathura'
    vim.keymap.set("n", "gp", function()
        require("nabla").popup()
    end)
end

return M
