M = function()
    local trans
    local dims
    local theme
    local tree_theme
    -- if start nvim-qt with NVIM_GUI, then the background will not be transparent
    if os.getenv("NVIM_GUI") == "1" then
        trans = false
        dims = false
        tree_theme = "dark"
        theme = 'night'
    elseif os.getenv("NVIM_GUI") == "2" then
        trans = false
        dims = false
        tree_theme = "dark"
        theme = 'storm'
    elseif os.getenv("NVIM_GUI") == "3" then
        trans = false
        dims = false
        tree_theme = "light"
        theme = "day"
    else
        trans = true
        dims = true
        tree_theme = "transparent"
        theme = 'storm'
    end

    
    require("tokyonight").setup({
        style = theme,
        transparent = trans,
        terminal_colors = true,
        styles = {
            comments = { italic = true },
            keywords = { italic = true },
            functions = {},
            variables = {},
            sidebars = tree_theme,
            floats = "dark",
        },
        sidebars = { "qf", "help" },
        day_brightness = 0.1,
        hide_inactive_statusline = false,
        dim_inactive = dims,
        lualine_bold = true,

        on_colors = function(colors)
            colors.border = "#565f89"
        end,
        on_highlights = function(highlights, colors) end,
    })


    require('lualine').setup {
        options = {
            theme = 'tokyonight'
        }
    }

    vim.cmd("colorscheme tokyonight")
    -- vim.cmd("colorscheme tokyonight-night")
end

return M

