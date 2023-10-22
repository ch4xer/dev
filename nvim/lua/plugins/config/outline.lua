M = function()
    require("aerial").setup({
        layout = {
            max_width = { 30, 0.2 },
        },
        keymaps = {
            ["<2-LeftMouse>"] = "actions.jump",
            ["<CR>"] = "actions.jump",
            ["q"] = "actions.close",
            ["<BS>"] = "actions.tree_toggle",
        }
    })
end
return M
