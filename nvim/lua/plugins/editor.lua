return {
  {
    "folke/flash.nvim",
    opts = {
      labels = "abcdefghijklmnopqrstuvwxyz0123456789",
      label = {
        rainbow = {
          enabled = true,
          -- number between 1 and 9
          shade = 5,
        },
        uppercase = false,
        distance = true,
      },
      modes = {
        -- options used when flash is activated through
        -- a regular search with `/` or `?`
        search = {
          enabled = true, -- enable flash for search
        },
        -- options used when flash is activated through
        -- `f`, `F`, `t`, `T`, `;` and `,` motions
        char = {
          enabled = false,
        },
        -- options used for treesitter selections
        -- `require("flash").treesitter()`
        treesitter = {
          enabled = false,
          labels = "abcdefghijklmnopqrstuvwxyz0123456789",
          label = { before = true, after = true, style = "inline" },
          jump = { pos = "range" },
          highlight = {
            backdrop = false,
            matches = false,
          },
        },
      },
      -- options for the floating window that shows the prompt,
      -- for regular jumps
      prompt = {
        enabled = false,
      },
      jump = {
        pos = "end",
        autojump = false,
      },
    },
    keys = false,
  },
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            auto_close = true,
            layout = { preset = "default", layout = { backdrop = false, min_width = 10 }, preview = false },
            win = {
              list = {
                keys = {
                  ["<BS>"] = "explorer_up",
                  ["a"] = "explorer_add",
                  ["d"] = "explorer_del",
                  ["r"] = "explorer_rename",
                  ["y"] = { "explorer_yank", mode = { "n", "x" } },
                  ["p"] = "explorer_paste",
                  ["."] = "toggle_ignored",
                  ["s"] = "edit_split",
                  ["v"] = "edit_vsplit",
                },
              },
            },
          },
        },
      },
    },
    -- stylua: ignore
    keys = function()
      return {
        { "sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics",   nowait = true },
        { "sw", function() Snacks.picker.grep() end,        desc = "Grep",          nowait = true },
        { "sf", function() Snacks.explorer() end,           desc = "File Explorer", nowait = true },
        { "ss", function() Snacks.picker.lsp_symbols() end, desc = "Symbols",       nowait = true },
        { "sb", function() Snacks.picker.buffers() end,     desc = "Buffers",       nowait = true },
      }
    end,
  },
  {
    "folke/todo-comments.nvim",
    optional = true,
    -- stylua: ignore
    keys = function()
      return {
        { "st", function() Snacks.picker.todo_comments() end, desc = "Todo", nowait = true },
      }
    end
,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.spec = {}
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = function(_, opts)
      opts.on_attach = function() end
      return opts
    end,
  },
  {
    "stevearc/oil.nvim",
    opts = {},
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    cmd = "Oil",
  },
  {
    "MagicDuck/grug-far.nvim",
    enabled = false,
  },
}
