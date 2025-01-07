local vim = vim

vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
    callback = function()
        vim.g.exec_on_small(vim.cmd, "silent! mkview")
    end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    callback = function()
        vim.g.exec_on_small(vim.cmd, "silent! loadview")
    end,
})

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
    callback = function()
        if vim.fn.executable("fcitx5-remote") == 1 then
            os.execute("fcitx5-remote -c")
        end
    end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = vim.highlight.on_yank
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = vim.g.format,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
    callback = function()
        local current_tab = vim.fn.tabpagenr()
        vim.cmd("tabdo wincmd =")
        vim.cmd("tabnext " .. current_tab)
    end,
})

vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
    pattern = { "*" },
    command = "silent! wa",
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
        local root =
            vim.fs.root(ctx.buf, { ".git", ".svn", "Makefile", "mvnw", "package.json", "go.mod", "Cargo.toml" })
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
                callback = _trigger,
            })
        else
            vim.g.exec_on_small(_trigger)
        end
    end,
})
