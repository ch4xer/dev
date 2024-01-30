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

vim.g.width_open_tree = 120
vim.g.bufenter_check = false

local toggle_tree = function()
    local get_filetree_window = function()
        for _, windowId in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
            local buffer = vim.api.nvim_win_get_buf(windowId)
            if vim.api.nvim_buf_get_option(buffer, 'ft') == 'neo-tree' then
                return windowId
            end
        end
        return nil
    end
    if vim.api.nvim_list_uis()[1].width > vim.g.width_open_tree then
        local is_valid_window = function(winnr)
            local bufnr = vim.api.nvim_win_get_buf(winnr)
            if not bufnr or bufnr < 1 then return false end
            local exists = vim.api.nvim_buf_is_valid(bufnr)
            return vim.bo[bufnr].buflisted and exists
        end
        if #vim.tbl_filter(is_valid_window, vim.api.nvim_list_wins()) > 1 then
            return
        end
        if get_filetree_window() ~= nil then
            return
        end
        local open_tree_without_focus = function()
            vim.cmd("Neotree show last")
            vim.cmd.wincmd("=")
        end
        vim.fn.timer_start(1, open_tree_without_focus)
    else
        if get_filetree_window() ~= nil then
            vim.cmd("Neotree action=close")
        end
    end
end

vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
    pattern = { "*.*" },
    callback = function()
        -- only execute at the first time entering buffer
        if vim.g.bufenter_check == false then
            toggle_tree()
            vim.g.bufenter_check = true
        end
    end
})

vim.api.nvim_create_autocmd({ 'VimResized' }, {
    pattern = { "*.*" },
    callback = function()
        -- keep the size of every window, very usful!
        vim.cmd.wincmd('=')
        toggle_tree()
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

-- prevent telescope from opening in insert mode
vim.api.nvim_create_autocmd("WinLeave", {
    callback = function()
        if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
        end
    end,
})

vim.api.nvim_create_autocmd("User", {
    pattern = "LazyCheck",
    callback = function()
        require('lazy').sync({ wait = false, show = false })
    end,
})
