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

set("n", "s", "<NOP>", { desc = "disable s" })
set({ "n", "v" }, "L", "g_", { desc = "go to end of line" })
set({ "n", "v" }, "H", "^", { desc = "go to begin of line" })
set("n", "<C-i>", "<C-i>", { desc = "fix conflict caused by <Tab> mapping" })
-- tab navigation
-- use :bw to really close the buffer
set("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
set("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
set({ "i", "t" }, "<C-BS>", "<C-W>", { desc = "delete word forward" })
set("n", "<BS>", "ciw", { desc = "delete word and edit in normal mode" })
set("v", "<BS>", "c", { desc = "delete and edit in visual mode" })

set("x", "i", "I", { desc = "column insert" })
set("x", "a", "A", { desc = "column append" })

set({ "n", "v" }, ";", ":", { nowait = true, desc = "enter commandline" })

local function is_file_window(win)
  local buf = vim.api.nvim_win_get_buf(win)
  if not vim.api.nvim_buf_is_valid(buf) then
    return false
  end
  local buftype = vim.api.nvim_get_option_value("buftype", { buf = buf })
  return buftype == ""
end

local function count_file_windows()
  local count = 0
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if is_file_window(win) then
      count = count + 1
    end
  end
  return count
end

local function is_current_window_file()
  local win = vim.api.nvim_get_current_win()
  return is_file_window(win)
end

local function smart_quit()
  if count_file_windows() == 1 and is_current_window_file() then
    vim.cmd("qall!")
  else
    vim.cmd("q!")
  end
end

set("n", "q", smart_quit, { desc = "smart quit window" })
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

set("i", "<C-v>", "<C-r>+", { desc = "paste from system clipboard, this is for neovim gui" })
