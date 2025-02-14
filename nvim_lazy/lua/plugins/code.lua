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
            gap = 1,
            columns = { { "kind_icon" }, { "label", "kind", gap = 1 } },
            components = {
              kind_icon = {
                ellipsis = false,
                text = function(ctx)
                  local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                  return kind_icon
                end,
                -- highlight will be provided by catppuccin
              },
            },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
          window = { border = "rounded" },
        },
      },
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
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
      sources = {
        default = function(ctx)
          local success, node = pcall(vim.treesitter.get_node_at_cursor)
          if vim.bo.filetype == "markdown" then
            return { "buffer", "path" }
          elseif success and node and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type()) then
            return { "buffer", "path" }
          else
            return { "lsp", "path", "snippets", "buffer" }
          end
        end,
        cmdline = {},
      },
    },
  },
  {
    "echasnovski/mini.ai",
    enabled = false,
  },
}
