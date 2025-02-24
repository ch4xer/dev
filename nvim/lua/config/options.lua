-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.snacks_animate = false
vim.g.ai_cmp = false

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
opt.wrap = true
