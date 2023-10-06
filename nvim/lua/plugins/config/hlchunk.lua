M = function()
    require("hlchunk").setup({
        blank = { enable = false },
        line_num = { enable = false, },
        indent = { enable = false, },
        chunk = {
            -- not default symbols
            chars = {
                horizontal_line = "━",
                vertical_line = "┃",
                left_top = "┏",
                left_bottom = "┗",
                right_arrow = ">",
            },
            style = {
                { fg = "#C678DD" },
                { fg = "#c21f30" }, -- this fg is used to highlight wrong chunk
            },
        }
    })
end

return M
