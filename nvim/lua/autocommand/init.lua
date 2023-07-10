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

vim.g.firstBufferOrDashboard = 1
vim.g.dashboard = 0
vim.g.width_open_tree = 100


local toggle_tree = function()
    -- if there is no nvim-tree plugin, just exit
    if package.loaded['nvim-tree'] == nil then
        return
    end
    local open_tree_without_focus = function()
        require('nvim-tree.api').tree.toggle(false, true)
        -- require("neo-tree.command")._command("filesystem")
    end

    -- decide whether to open nvim-tree according to the window size
    if vim.api.nvim_list_uis()[1].width > vim.g.width_open_tree then
        if require('nvim-tree.view').is_visible() then
            return
        end
        vim.fn.timer_start(2, open_tree_without_focus)
    else
        if require('nvim-tree.view').is_visible() then
            require('nvim-tree.api').tree.close()
        end
    end
end

vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
    -- vim.api.nvim_create_autocmd({ 'VimEnter' }, {
    callback = function()
        if vim.g.firstBufferOrDashboard ~= 1 then
            if vim.g.dashboard == 1 then
                vim.g.dashboard = 0
                toggle_tree()
            end
            return
        end

        vim.g.firstBufferOrDashboard = 0
        -- start without filename
        if vim.fn.argc() == 0 and vim.fn.line2byte('$') == -1 then
            local ok, _ = pcall(
                function()
                    require('dashboard'):instance()
                end
            )
            if ok then
                vim.g.dashboard = 1
            end
        else
            -- start with filename, check whether to open nvim-tree
            vim.g.dashboard = 0
            toggle_tree()
        end
    end
})

vim.api.nvim_create_autocmd({ 'VimResized' }, {
    callback = function()
        -- keep the size of every window, very usful!
        vim.cmd('wincmd =')
        -- will not take effect before dashboard end
        if vim.g.firstBufferOrDashboard == 1 or vim.g.dashboard == 1 then
            return
        end
        -- if there is no nvim-tree, just exit
        if package.loaded['nvim-tree'] == nil then
            return
        end
        -- decide whether to open nvim-tree according to the window size
        if vim.api.nvim_list_uis()[1].width > vim.g.width_open_tree then
            -- if the number of valid window > 1, then dont start tree
            local is_valid_window = function(winnr)
                local bufnr = vim.api.nvim_win_get_buf(winnr)
                if not bufnr or bufnr < 1 then return false end
                local exists = vim.api.nvim_buf_is_valid(bufnr)
                return vim.bo[bufnr].buflisted and exists
            end
            if #vim.tbl_filter(is_valid_window, vim.api.nvim_list_wins()) > 1 then
                return
            end
            if require('nvim-tree.view').is_visible() then
                return
            else
                require('nvim-tree.api').tree.toggle(false, true)
            end
        else
            if require('nvim-tree.view').is_visible() then
                require('nvim-tree.api').tree.close()
            end
            -- if outline is open, close it
            require('aerial').close_all()
        end
    end
})

-- becase neovim behaviors changed in nightly
vim.api.nvim_create_autocmd("WinLeave", {
    callback = function()
        if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
        end
    end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- inlay hint support
vim.api.nvim_create_autocmd("LspAttach", {
    pattern = { "*.go" },
    callback = function()
        if vim.lsp.inlay_hint ~= nil and vim.bo.ft ~= "TelescopePrompt" then
            vim.cmd.highlight('default link LspInlayHint Comment')
            vim.lsp.inlay_hint(0, true)
        end
    end,
})
