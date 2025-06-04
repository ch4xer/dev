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
          -- function()
          --   if require("minuet.virtualtext").action.is_visible() then
          --     LazyVim.create_undo()
          --     require("minuet.virtualtext").action.accept()
          --     return true
          --   end
          -- end,
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
  --   event = "BufRead *.*",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --   },
  --   config = function()
  --     require("codecompanion").setup({
  --       strategies = {
  --         chat = {
  --           adapter = "deepseek",
  --         },
  --         inline = {
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
  -- {
  --   "echasnovski/mini.diff",
  --   config = function()
  --     local diff = require("mini.diff")
  --     diff.setup({
  --       -- Disabled by default
  --       source = diff.gen_source.none(),
  --     })
  --   end,
  -- },
  -- {
  --   "milanglacier/minuet-ai.nvim",
  --   event = "BufRead *.*",
  --   config = function()
  --     require("minuet").setup({
  --       request_timeout = 60,
  --       provider = "openai_compatible",
  --       provider_options = {
  --         openai_compatible = {
  --           end_point = "https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions",
  --           model = "deepseek-r1",
  --           api_key = "QWEN_API_KEY",
  --           name = "qwen",
  --           optional = {
  --             max_tokens = 256,
  --             top_p = 0.9,
  --           },
  --         },
  --       },
  --       virtualtext = {
  --         auto_trigger_ft = { "*" },
  --         show_on_completion_menu = true,
  --       },
  --       n_completions = 1,
  --     })
  --   end,
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
