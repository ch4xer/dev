M = function()
    require('osc52').setup {
        max_length = 0,     -- Maximum length of selection (0 for no limit)
        silent     = true, -- Disable message on successful copy
        trim       = true, -- Trim surrounding whitespaces before copy
    }
end


return M
