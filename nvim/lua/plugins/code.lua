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
      enabled = function()
        if vim.g.hasfcitx5 == 1 then
          return vim.trim(vim.fn.system("fcitx5-remote --check")) == "1"
        end
        return true
      end,
    },
  },
  {
    "olimorris/codecompanion.nvim",
    event = "BufRead",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      {
        "zbirenbaum/copilot.lua",
        opts = {
          copilot_model = "gpt-4o-copilot",
        },
      },
      {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown", "codecompanion" },
        opts = {
          render_modes = true,
          file_types = { "markdown", "codecompanion" },
          heading = {
            width = "block",
          },
          code = {
            border = "thin",
            above = "━",
            below = "━",
            style = "normal",
            width = "block",
          },
        },
      },
      {
        "nvim-mini/mini.diff",
        config = function()
          local diff = require("mini.diff")
          diff.setup({
            -- Disabled by default
            source = diff.gen_source.none(),
            mappings = {
              apply = "",
            },
          })
        end,
      },
    },
    config = function()
      require("codecompanion").setup({
        -- opts = {
        --   language = "Chinese",
        -- },
        strategies = {
          chat = {
            adapter = "copilot",
          },
          inline = {
            adapter = "copilot",
          },
        },
        display = {
          chat = {
            -- Options to customize the UI of the chat buffer
            window = {
              layout = "float", -- float|vertical|horizontal|buffer
              width = 0.8,
            },
          },
        },
      })
    end,
    keys = {
      { "<C-a>", mode = "n", "<CMD>CodeCompanionChat Toggle<CR>", desc = "CodeCompanion" },
    },
  },
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
    "nvim-mini/mini.ai",
    enabled = false,
  },
  {
    "folke/ts-comments.nvim",
    enabled = false,
  },
}
