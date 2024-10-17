local vim = vim
M = {}

vim.g.is_not_large = function()
    -- will not trigger if file size is larger than 1000 KB
    local max_filesize = 1000 * 1024 -- 1000 KB
    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(0))
    if ok and stats and stats.size > max_filesize then
        return false
    end
    return true
end

vim.g.exec_on_small = function(func, ...)
    if vim.g.is_not_large() then
        func(...)
    end
end

vim.g.format = function()
    require 'conform'.format({ lsp_format = 'fallback' })
end

vim.g.register_keymap = function(keySet)
    for _, set in pairs(keySet) do
        for _, keymap in ipairs(set) do
            if keymap[4] == nil then
                keymap[4] = { noremap = true, silent = true }
            end
            if keymap[3] ~= nil then
                vim.keymap.set(keymap[1], keymap[2], keymap[3], keymap[4])
            end
        end
    end
end
