M = function()
    require('persistence').setup {
        dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
        options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals" }
    }
end

return M
