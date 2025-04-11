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
          draw = {
            padding = 1,
            gap = 0,
            columns = { { "kind_icon" }, { "label", "kind", gap = 1 } },
          },
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
    "zbirenbaum/copilot.lua",
    opts = {
      copilot_model = "gpt-4o-copilot",
    },
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false,
    opts = {
      provider = "copilot",
      behaviour = {
        auto_apply_diff_after_generation = true,
      },
      hints = { enabled = true },
      -- editor: ours = "co", theirs = "ct",
      -- sidebar: apply_all = "A", apply = "a"
    },
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "ibhagwan/fzf-lua",
      "zbirenbaum/copilot.lua",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
          heading = {
            width = "block",
          },
          code = {
            style = 'normal',
            width = "block",
          },
        },
        ft = { "markdown", "Avante" },
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
