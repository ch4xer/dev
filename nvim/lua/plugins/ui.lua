return {
  { "akinsho/bufferline.nvim", enabled = false },
  {
    "b0o/incline.nvim",
    event = "BufReadPre",
    enabled = true,
    config = function()
      local colors = require("catppuccin.palettes").get_palette("mocha")
      require("incline").setup({
        hide = {
          cursorline = true,
          focused_win = true,
        },
        highlight = {
          groups = {
            InclineNormal = { guibg = colors.surface1, guifg = colors.text },
            InclineNormalNC = { guibg = colors.crust, guifg = colors.text },
          },
        },
        window = { margin = { vertical = 0, horizontal = 0 } },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        hover = {
          enabled = false,
        },
        signature = {
          enabled = false,
        },
      },
      cmdline = {
        view = "cmdline",
      },
      messages = {
        view = "mini",
        view_error = "mini",
        view_warn = "mini",
      },
      notify = {
        enabled = false,
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "Agent service not initialized" },
              { find = "Not authenticated: NotSignedIn" },
              { find = "Client networksocket disconnected" },
              { find = "written" },
              { find = "api.github.com" },
            },
          },
          opts = { skip = true },
        },
      },
      presets = {
        command_palette = false,
      },
    },
    keys = false,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      sections = {
        lualine_a = {
          {
            "mode",
            icons_enabled = true,
            fmt = function(str)
              local indicator = str:sub(1, 1)
              if indicator == "N" then
                return ""
              end
              if indicator == "I" then
                return ""
              end
              if indicator == "V" then
                return ""
              end
              if indicator == "T" then
                return ""
              end
              return ""
              -- return str:sub(1, 3)
            end,
          },
        },
        lualine_b = {
          -- "filename",
          {
            "buffers",
            section_separators = { left = "", right = "" },
            component_separators = { left = "", right = "" },
            hide_filename_extension = true,
            show_modified_status = false,
            use_mode_colors = true,
            symbols = {
              alternate_file = "", -- Text to show to identify the alternate file
            },
          },
        },
        lualine_c = { "diagnostics" },
        lualine_x = { "diff", { "branch", icon = "" } },
        lualine_y = {
          {
            "progress",
            fmt = function(str)
              local str1 = str:gsub(" ", "")
              return " " .. str1
            end,
          },
        },
        lualine_z = {},
      },
    },
    config = function(_, opts)
      if vim.g.trouble_lualine and LazyVim.has("trouble.nvim") then
        local trouble = require("trouble")
        local symbols = trouble.statusline({
          mode = "symbols",
          groups = {},
          title = false,
          filter = { range = true },
          format = "{kind_icon}{symbol.name:Normal}",
          hl_group = "lualine_c_normal",
        })
        table.insert(opts.sections.lualine_c, {
          symbols and symbols.get,
          cond = function()
            return vim.b.trouble_lualine ~= false and symbols.has()
          end,
        })
      end
      require("lualine").setup(opts)
    end,
  },
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        width = 30,
        preset = {
          pick = function(cmd, opts)
            return LazyVim.pick(cmd, opts)()
          end,
          header = [[
  ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆         
   ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦      
         ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄    
          ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄   
         ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀  
  ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄ 
 ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄  
⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄ 
⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄
     ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆    
      ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃    ]],
          keys = {
            { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 2 },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
    },
  },
}
