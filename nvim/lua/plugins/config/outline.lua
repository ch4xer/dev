M = function()
    require("aerial").setup({
        layout = {
            max_width = { 30, 0.2 },
            placement = "edge",
        },
        attach_mode = "global",
        keymaps = {
            ["<2-LeftMouse>"] = "actions.jump",
            ["<CR>"] = "actions.jump",
            ["q"] = "actions.close",
            ["<BS>"] = "actions.tree_toggle",
        }
    })
end
return M
