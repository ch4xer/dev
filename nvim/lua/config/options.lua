-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.snacks_animate = false
vim.g.ai_cmp = false
vim.g.lazyvim_python_lsp = "basedpyright"

local opt = vim.opt

opt.title = true
opt.titlestring = 'nvim %{expand("%:p:h:t")}'

opt.relativenumber = false
opt.signcolumn = "number"
opt.statuscolumn = ""

opt.tabstop = 4
opt.shiftwidth = 4
opt.linebreak = false
opt.listchars = "tab:  ,trail:-,nbsp:+"

-- visual selection mode
opt.sel = "inclusive"

opt.wrap = true

opt.clipboard = "unnamedplus"
if os.getenv("SSH_TTY") ~= nil then
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
      ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
    },
  }
end
opt.conceallevel = 0

if vim.g.neovide then
  -- mocha colors
  -- https://github.com/neovide/neovide/issues/2050#issuecomment-2571258610
  vim.g.terminal_color_0 = "#45475a"
  vim.g.terminal_color_1 = "#f38ba8"
  vim.g.terminal_color_2 = "#a6e3a1"
  vim.g.terminal_color_3 = "#f9e2af"
  vim.g.terminal_color_4 = "#89b4fa"
  vim.g.terminal_color_5 = "#f5c2e7"
  vim.g.terminal_color_6 = "#94e2d5"
  vim.g.terminal_color_7 = "#bac2de"
  vim.g.terminal_color_8 = "#585b70"
  vim.g.terminal_color_9 = "#f38ba8"
  vim.g.terminal_color_10 = "#a6e3a1"
  vim.g.terminal_color_11 = "#f9e2af"
  vim.g.terminal_color_12 = "#89b4fa"
  vim.g.terminal_color_13 = "#f5c2e7"
  vim.g.terminal_color_14 = "#94e2d5"
  vim.g.terminal_color_15 = "#a6adc8"
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_cursor_animate_command_line = false
  vim.g.neovide_cursor_animate_in_insert_mode = false
  vim.g.neovide_scroll_animation_far_lines = 0
  vim.g.neovide_floating_shadow = false
  vim.env.CGO_ENABLED = 1
  vim.env.GOPATH = vim.fn.expand("$HOME/Projects/go")
  vim.env.GO111MODULE = "on"
  vim.env.PATH = vim.fn.expand("$PATH") .. ":" .. vim.fn.expand("$GOPATH/bin") .. ":" .. vim.fn.expand("$GOROOT/bin")
end
