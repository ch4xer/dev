local vim = vim

-- vim.api.nvim_set_hl(0, "@text.title1", { fg = "#7aa2f7", bold = true, italic = true })
-- vim.api.nvim_set_hl(0, "@text.title2", { fg = "#ff9e64", bold = true, italic = true })
-- vim.api.nvim_set_hl(0, "@text.title3", { fg = "#7dcfff", bold = true, italic = true })
-- vim.api.nvim_set_hl(0, "@text.title4", { fg = "#9ece6a", bold = true, italic = true })
-- vim.api.nvim_set_hl(0, "@text.title5", { fg = "#bb9af7", bold = true, italic = true })
-- vim.api.nvim_set_hl(0, "@text.title6", { fg = "#cfc9c2", bold = true, italic = true })
-- vim.api.nvim_set_hl(0, "@text.quote", { fg = "#bb9af7", bold = false, italic = true })
-- vim.api.nvim_set_hl(0, "@punctuation.special2", { fg = "#7dcfff", bold = false, italic = false })
-- vim.api.nvim_set_hl(0, "@text.todo.checked", { fg = "#7dcfff", bold = false, strikethrough=true})
-- vim.api.nvim_set_hl(0, "@text.todo.unchecked", { fg = "#7dcfff", bold = false, strikethrough=false})

local mark_item_done = function()
    local current_line = vim.api.nvim_get_current_line()
    local new_line
    if string.match(current_line, "- %[ %] ") then
        new_line = string.gsub(current_line, "- %[ %] ", "- %[x%] ");
        vim.api.nvim_set_current_line(new_line)
    elseif string.match(current_line, "- %[x%] ") then
        new_line = string.gsub(current_line, "- %[x%] ", "- ")
        vim.api.nvim_set_current_line(new_line)
    elseif string.match(current_line, "- ") then
        new_line = string.gsub(current_line, "- ", "- %[x%] ")
        vim.api.nvim_set_current_line(new_line)
    end
end

vim.keymap.set(
    'n',
    '<leader><Space>',
    mark_item_done
)
