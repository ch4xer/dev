return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
      icons = {
        diagnostics = {
          Error = " ",
          Warn = " ",
          Hint = " ",
          Info = " ",
        },
      },
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    config = function()
      require("catppuccin").setup({
        transparent_background = true,
        term_colors = false,
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          functions = { "italic" },
          properties = { "italic" },
        },
        custom_highlights = function(colors)
          return {
            Folded = {
              fg = colors.lavender,
              bg = colors.none,
            },
          }
        end,
        integrations = {
          blink_cmp = true,
        },
      })
    end,
  },
}
