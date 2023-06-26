M = function()
    require('persistence').setup {
        dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
        options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals" }
    }
    -- require("auto-session").setup {
    --     log_level = "error",
    --     auto_session_suppress_dirs = { "~/Projects", "~/Projects/go/src"},
    --     cwd_change_handling = {
    --         restore_upcoming_session = true, -- already the default, no need to specify like this, only here as an example
    --         pre_cwd_changed_hook = nil, -- already the default, no need to specify like this, only here as an example
    --         post_cwd_changed_hook = function() -- example refreshing the lualine status line _after_ the cwd changes
    --             require("lualine").refresh() -- refresh lualine so the new session name is displayed in the status bar
    --         end,
    --     },
    -- }
end

return M
