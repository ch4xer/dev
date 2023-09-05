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

vim.g.width_open_tree = 150

local toggle_tree = function()
    -- if there is no nvim-tree plugin, just exit
    if package.loaded['nvim-tree'] == nil then
        return
    end
    local open_tree_without_focus = function()
        require('nvim-tree.api').tree.toggle(false, true)
    end
    -- decide whether to open nvim-tree according to the window size
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
        if require('nvim-tree.view').is_visible() then
            return
        end
        vim.fn.timer_start(1, open_tree_without_focus)
    else
        if require('nvim-tree.view').is_visible() then
            require('nvim-tree.api').tree.close()
        end
        require('aerial').close_all()
    end
end

vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
    pattern = { "*.*" },
    callback = function()
        toggle_tree()
    end
})

vim.api.nvim_create_autocmd({ 'VimResized' }, {
    pattern = { "*.*" },
    callback = function()
        -- keep the size of every window, very usful!
        vim.cmd('wincmd =')
        toggle_tree()
    end
})

-- inlay hint support
vim.api.nvim_create_autocmd("LspAttach", {
    pattern = { "*.go", "*.rs", ".py" },
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client.name == "copilot" or client.name == "null-ls" then
            return
        end
        if vim.lsp.inlay_hint ~= nil and vim.bo.ft ~= "TelescopePrompt" then
            vim.cmd.highlight('default link LspInlayHint Comment')
            vim.lsp.inlay_hint(0, true)
        end
    end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
        if package.loaded['osc52'] == nil then
            return
        end
        require('osc52').copy_register('+')
    end
})
