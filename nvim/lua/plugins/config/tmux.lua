M = function ()
    require("tmux").setup({
        copysync = {
            enable = false
        },
        resize = {
            enable_default_keybindings = false,
        }
    })
    
end

return M
