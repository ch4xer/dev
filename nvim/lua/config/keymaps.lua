local del = vim.keymap.del
local set = vim.keymap.set

del("n", "<C-Up>")
del("n", "<C-Down>")
del("n", "<C-Left>")
del("n", "<C-Right>")

del({ "n", "i", "v" }, "<A-j>")
del({ "n", "i", "v" }, "<A-k>")

del("n", "<S-h>")
del("n", "<S-l>")
del("n", "[b")
del("n", "]b")
del("n", "<leader>bb")
del("n", "<leader>`")
del("n", "<leader>ur")
del("i", ",")
del("i", ".")
del("i", ";")

set({ "n", "v" }, "L", "g_", { desc = "go to end of line" })
set({ "n", "v" }, "H", "^", { desc = "go to begin of line" })
set("n", "<C-i>", "<C-i>", { desc = "fix conflict caused by <Tab> mapping" })
set("n", "<Tab>", "<C-w>W", { desc = "move to other window" })
set("i", "<C-BS>", "<C-W>", { desc = "delete word forward" })
set("n", "<BS>", "ciw", { desc = "delete word and edit in normal mode" })
set("v", "<BS>", "c", { desc = "delete and edit in visual mode" })

set("x", "i", "I", { desc = "column insert" })
set("x", "a", "A", { desc = "column append" })

set({ "n", "v" }, ";", ":", { nowait = true, desc = "enter commandline" })
set("n", "q", "<CMD>q!<CR>", { desc = "quit neovim" })
set("n", "Q", "q", { desc = "macro record" })

set("n", "yw", "yiw", { desc = "copy the word where cursor locates" })
set("n", "<C-S-v>", "<C-v>", { desc = "start visual mode blockwise" })

set("n", "<CR>", "za", { desc = "toggle fold" })
set("n", "<2-LeftMouse>", "za", { desc = "toggle fold" })

set("n", "<C-/>", "gcc", { desc = "Comment", remap = true })
set("n", "<C-_>", "gcc", { desc = "Comment", remap = true })
set("v", "<C-/>", "gc", { desc = "Comment", remap = true })
set("v", "<C-_>", "gc", { desc = "Comment", remap = true })

set({ "i", "n", "s" }, "<esc>", function()
  vim.cmd("noh")
  LazyVim.cmp.actions.snippet_stop()
  vim.cmd("stopinsert")
end, { expr = true, desc = "Escape and Clear hlsearch" })
