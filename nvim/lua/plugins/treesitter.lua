return {
  {
    "nvim-treesitter/nvim-treesitter",
    keys = false,
    opts = {
      incremental_selection = {
        enable = false,
      },
      textobjects = {
        move = {
          enable = false,
        },
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["p"] = "@parameter.outer",
          },
          include_surrounding_whitespace = true,
        },
      },
    },
  },
}
