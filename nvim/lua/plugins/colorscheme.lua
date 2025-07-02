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
    opts = {
      term_colors = true,
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
      if vim.g.neovide then
        opts.flavour = "macchiato"
      else
        opts.flavour = "mocha"
      end
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
