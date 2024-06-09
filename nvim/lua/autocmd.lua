local vim = vim

vim.api.nvim_create_autocmd({ 'BufWinLeave' }, {
    command = "silent! mkview"
})

vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
    command = "silent! loadview"
})

vim.api.nvim_create_autocmd({ 'InsertLeave' }, {
    callback = function()
        -- prevent statusline flinker
        os.execute("fcitx5-remote -c")
    end
})

vim.g.width_close_tree = 120
vim.api.nvim_create_autocmd({ 'VimResized' }, {
    pattern = { "*.*" },
    callback = function()
        -- keep the size of every window, very usful!
        vim.cmd.wincmd('=')
        vim.g.close_tree()
    end
})

vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
        local copy_to_unnamedplus = require('vim.ui.clipboard.osc52').copy('+')
        copy_to_unnamedplus(vim.v.event.regcontents)
        local copy_to_unnamed = require('vim.ui.clipboard.osc52').copy('*')
        copy_to_unnamed(vim.v.event.regcontents)
    end
})

vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
    pattern = { "*" },
    command = "silent! wa"
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "yml", "yaml", "json", "html", "css", "javascript", "typescript", "sh", "sql", "vue", "markdown" },
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
    end,
})

vim.api.nvim_create_autocmd("BufEnter", {
    callback = function(ctx)
        local root = vim.fs.root(ctx.buf, { ".git", ".svn", "Makefile", "mvnw", "package.json", "go.mod", "Cargo.toml" })
        if root and root ~= "." and root ~= vim.fn.getcwd() then
            vim.cmd.cd(root)
        end
    end,
})

vim.api.nvim_create_autocmd("User", {
    pattern = { "VeryLazy" },
    callback = function()
        local _trigger = function()
            vim.api.nvim_exec_autocmds("User", { pattern = "Lazyest" })
        end

        -- BufRead will not avoid plugin loading in dashboard
        if vim.bo.filetype == "dashboard" then
            vim.api.nvim_create_autocmd("BufRead", {
                once = true,
                callback = _trigger
            })
        else
            if vim.g.is_large() == false then
                _trigger()
            end
        end
    end
})
