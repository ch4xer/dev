-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.snacks_animate = false
vim.g.ai_cmp = false

local opt = vim.opt

opt.swapfile = false
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
  -- vim.o.guifont = "JetBrainsMono Nerd Font Mono,LXGW WenKai Medium:h22"
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_cursor_animate_command_line = false
  vim.g.neovide_cursor_animate_in_insert_mode = false
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_cursor_short_animation_length = 0
  vim.g.neovide_position_animation_length = 0
  vim.g.neovide_scroll_animation_far_lines = 0
  vim.g.neovide_scroll_animation_length = 0
  vim.g.neovide_floating_shadow = false
  vim.env.CGO_ENABLED = 1
  vim.env.GOPATH = vim.fn.expand("$HOME/.go")
  vim.env.GO111MODULE = "on"
  vim.env.PATH = vim.fn.expand("$PATH") .. ":" .. vim.fn.expand("$GOPATH/bin") .. ":" .. vim.fn.expand("$GOROOT/bin")
end
