local vim = vim

vim.api.nvim_create_autocmd({ 'BufWinLeave' }, {
    command = 'silent! mkview'
})

vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
    command = 'silent! loadview'
})

vim.api.nvim_create_autocmd({ 'InsertLeave', 'BufCreate', 'BufEnter', 'BufLeave' }, {
    command = 'silent !fcitx5-remote -c'
})

vim.g.width_close_tree = 120

local close_tree = function()
    local get_filetree_window = function()
        for _, windowId in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
            local buffer = vim.api.nvim_win_get_buf(windowId)
            if vim.api.nvim_buf_get_option(buffer, 'ft') == 'neo-tree' then
                return windowId
            end
        end
        return nil
    end
    if vim.api.nvim_list_uis()[1].width <= vim.g.width_close_tree then
        if get_filetree_window() ~= nil then
            vim.cmd("Neotree action=close")
        end
    end
end

vim.api.nvim_create_autocmd({ 'VimResized' }, {
    pattern = { "*.*" },
    callback = function()
        -- keep the size of every window, very usful!
        vim.cmd.wincmd('=')
        close_tree()
    end
})

vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
        require('osc52').copy_register('+')
    end
})

vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
    pattern = { "*" },
    command = "silent! wall",
    nested = true,
})
