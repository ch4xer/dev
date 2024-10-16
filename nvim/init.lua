vim.loader.enable()

-- When you do require("foo.bar"), Neovim will try to load one of these file patterns:
-- lua/foo/bar.lua
-- lua/foo/bar/init.lua

-- register global functions first
require("utils")
require("base")
require("plugins")
require("autocmd")
require("keymap")
