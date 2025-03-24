return {
  { "akinsho/bufferline.nvim", enabled = false },
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
          "filename",
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
    "snacks.nvim",
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
