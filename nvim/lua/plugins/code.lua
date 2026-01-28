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
    "kawre/neotab.nvim",
    event = "InsertEnter",
    config = true,
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
