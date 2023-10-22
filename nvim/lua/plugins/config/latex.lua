M = function()
    vim.g.vimtex_view_method = 'zathura'
    vim.keymap.set("n", "<leader>p", function()
        require("nabla").popup()
    end)
end

return M
