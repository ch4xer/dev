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
    branch = "main",
    lazy = false, -- neo-tree will lazily load itself
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
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup()
      local termNum = function()
        local count = 0
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_valid(buf) then
            local ft = vim.api.nvim_get_option_value("filetype", {
              buf = buf,
            })
            if ft == "toggleterm" then
              count = count + 1
            end
          end
        end
        return count
      end

      vim.api.nvim_create_user_command("Term", function()
        local termBufNum = termNum() + 1
        vim.cmd(termBufNum .. "ToggleTerm")
      end, { desc = "New Terminal" })
    end,
    -- stylua: ignore
    keys = {
      { "<esc>", mode = "t", "<C-\\><C-n>", desc = "Escape Terminal mode" },
      { "<C-h>", mode = "t", "<cmd>wincmd h<cr>", desc = "move cursor" },
      { "<C-j>", mode = "t", "<cmd>wincmd j<cr>", desc = "move cursor" },
      { "<C-k>", mode = "t", "<cmd>wincmd k<cr>", desc = "move cursor" },
      { "<C-l>", mode = "t", "<cmd>wincmd l<cr>", desc = "move cursor" },
      { "<C-`>", mode = { "n","t" },
        function ()
          local termNum = function ()
            local count = 0
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
              if vim.api.nvim_buf_is_valid(buf) then
                local ft = vim.api.nvim_get_option_value("filetype", {
                  buf = buf,
                })
                if ft == "toggleterm" then
                  count = count + 1
                end
              end
            end
            return count
          end

          local termBufNum = termNum()
          if termBufNum > 0 then
            vim.api.nvim_input("<Esc>")
            vim.cmd("ToggleTermToggleAll")
          else
            vim.cmd("ToggleTerm")
          end
        end, desc = "Toggle Terminal" },
    },
  },
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
