M = function()
    vim.keymap.set(
        { 'n', 'v' },
        's',
        'Nop',
        { noremap = true, silent = true }
    )
    require("nvim-surround").setup({
        keymaps = {
            visual = "s",
            delete = "ds",
            change = "cs",
        },
    })
end

return M
