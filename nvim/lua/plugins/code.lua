return {
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        keymaps = {
          visual = "s",
          normal = "ys",
          delete = "ds",
          change = "cs",
        },
        surrounds = {
          ["("] = false,
          ["["] = false,
        },
        -- remove leading and trailing whitespace
        aliases = {
          ["("] = ")",
          ["["] = "]",
        },
      })
    end,
  },
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        menu = {
          min_width = 5,
          border = "single",
          draw = {
            padding = 0,
            gap = 0,
            columns = { { "kind_icon" }, { "label", "kind", gap = 1 } },
          },
        },
        documentation = {
          window = { border = "rounded" },
        },
      },
      keymap = {
        preset = "super-tab",
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = {
          "accept",
          function()
            if require("copilot.suggestion").is_visible() then
              LazyVim.create_undo()
              require("copilot.suggestion").accept()
              return true
            end
          end,
          "snippet_forward",
          "fallback",
        },
        ["<S-Tab>"] = {
          "hide",
          "snippet_backward",
          "fallback",
        },
      },
    },
  },
  {
    "echasnovski/mini.ai",
    enabled = false,
  },
  {
    "folke/ts-comments.nvim",
    enabled = false,
  },
}
