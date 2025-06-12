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
    "Saghen/blink.cmp",
    event = "InsertEnter",
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
  -- {
  --   "olimorris/codecompanion.nvim",
  --   event = "BufRead",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --   },
  --   config = function()
  --     require("codecompanion").setup({
  --       opts = {
  --         language = "Chinese",
  --       },
  --       strategies = {
  --         chat = {
  --           adapter = "deepseek",
  --         },
  --       },
  --       display = {
  --         chat = {
  --           -- Options to customize the UI of the chat buffer
  --           window = {
  --             layout = "float", -- float|vertical|horizontal|buffer
  --             width = 0.8,
  --           },
  --         },
  --       },
  --     })
  --   end,
  --   keys = {
  --     { "<C-a>", mode = "n", "<CMD>CodeCompanionChat Toggle<CR>", desc = "CodeCompanion" },
  --   },
  -- },
  {
    "abecodes/tabout.nvim",
    event = "InsertEnter",
    config = true,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "Saghen/blink.cmp",
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
