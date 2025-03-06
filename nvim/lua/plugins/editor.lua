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
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    -- stylua: ignore
    keys = {
      { "t", function() vim.cmd("Neotree reveal toggle") end, desc = "toggle neotree" },
    },
    config = function()
      require("neo-tree").setup({
        sources = {
          "filesystem",
        },
        hide_root_node = true,
        auto_clean_after_session_restore = true,
        close_if_last_window = true,
        -- stylua: ignore
        default_component_configs = {
          indent = { padding = 0, },
          type = { enabled = false, },
          last_modified = { enabled = false, },
        },
        window = {
          position = "float",
          auto_expand_width = true,
          mappings = {
            ["t"] = "toggle_node",
            ["<esc>"] = "cancel",
            ["r"] = "rename",
          },
        },
        filesystem = {
          follow_current_file = {
            enabled = true,
            leave_dirs_open = true,
          },
          hijack_netrw_behavior = "open_default",
          window = {
            mappings = {
              ["<2-LeftMouse>"] = "open",
              ["<cr>"] = "open",
              ["a"] = "add",
              ["."] = "toggle_hidden",
              ["y"] = "copy_to_clipboard",
              ["s"] = "open_split",
              ["v"] = "open_vsplit",
              ["x"] = "cut_to_clipboard",
              ["p"] = "paste_from_clipboard",
              ["d"] = "delete",
            },
          },
        },
      })
    end,
  },
  {
    "ibhagwan/fzf-lua",
    -- stylua: ignore
    keys = {
      { "sw", function() require("fzf-lua").live_grep() end,           desc = "search word" },
      { "sf", function() require("fzf-lua").files() end,               desc = "search file" },
      { "sd", function() require("fzf-lua").diagnostics_workspace() end,               desc = "search diagnostics" },
      { "z",  function() require("fzf-lua").buffers() end,             desc = "search buffer" },
      { "ga", function() require("fzf-lua").lsp_code_actions() end,    desc = "code action" },
      { "gr", function() require("fzf-lua").lsp_references() end,      desc = "find reference" },
      { "gs", function() require("fzf-lua").lsp_document_symbols() end,      desc = "find symbols" },
      { "gi", function() require("fzf-lua").lsp_implementations() end, desc = "find implementations" },
    },
  },
  {
    "snacks.nvim",
    opts = {
      styles = {
        terminal = {
          -- stylua: ignore
          keys = {
            -- override it
            term_normal = { "<esc>", "<cmd>close<cr>", mode = "t", desc = "hide terminal" },
          },
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "T", function() Snacks.terminal("/bin/zsh") end, desc = "Terminal (cwd)" },
    },
  },
  -- {
  --   "snacks.nvim",
  --   -- stylua: ignore
  --   keys = {
  --     { "z", function() Snacks.picker.buffers() end, desc = "Buffers" },
  --     { "sf", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
  --     { "sw", function() Snacks.picker.grep() end, desc = "Grep" },
  --     { "sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
  --     { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
  --     { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
  --     { "gi", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
  --     { "gs", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
  --   },
  -- },
  {
    "folke/todo-comments.nvim",
      -- stylua: ignore
    keys = {
      { "st", function() require("todo-comments.fzf").todo() end, desc = "find todo-comment" },
    },
  },
  {
    "MagicDuck/grug-far.nvim",
    enabled = false,
  },
}
