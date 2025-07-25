return {
  {
    "LazyVim/LazyVim",
    opts = {
      defaults = {
        keymaps = false,
      },
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
    opts = {
      term_colors = true,
      flavour = "latte",
      transparent_background = true,
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
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
