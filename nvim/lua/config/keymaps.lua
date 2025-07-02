local map = vim.keymap.set

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

map("n", "s", "<NOP>", { desc = "disable s" })
map({ "n", "v" }, "L", "g_", { desc = "go to end of line" })
map({ "n", "v" }, "H", "^", { desc = "go to begin of line" })
map("n", "<C-i>", "<C-i>", { desc = "fix conflict caused by <Tab> mapping" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- use :bw to really close the buffer
map("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map({ "i", "t" }, "<C-BS>", "<C-W>", { desc = "delete word forward" })
map("n", "<BS>", "ciw", { desc = "delete word and edit in normal mode" })
map("v", "<BS>", "c", { desc = "delete and edit in visual mode" })

map("x", "i", "I", { desc = "column insert" })
map("x", "a", "A", { desc = "column append" })

map({ "n", "v" }, ";", ":", { nowait = true, desc = "enter commandline" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

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

map("n", "q", smart_quit, { desc = "smart quit window" })
map("n", "Q", "q", { desc = "macro record" })

map("n", "yw", "yiw", { desc = "copy the word where cursor locates" })
map("n", "<C-S-v>", "<C-v>", { desc = "start visual mode blockwise" })

map("n", "<CR>", "za", { desc = "toggle fold" })
map("n", "<2-LeftMouse>", "za", { desc = "toggle fold" })
map(
  "n",
  "<LeftMouse>",
  ":let temp=&so<CR>:let &so=0<CR><LeftMouse>:let &so=temp<CR>",
  { noremap = true, silent = true, desc = "click without scrolloff" }
)

map("n", "<C-/>", "gcc", { desc = "Comment", remap = true })
map("n", "<C-_>", "gcc", { desc = "Comment", remap = true })
map("v", "<C-/>", "gc", { desc = "Comment", remap = true })
map("v", "<C-_>", "gc", { desc = "Comment", remap = true })

map({ "i", "n", "s" }, "<esc>", function()
  vim.cmd("noh")
  LazyVim.cmp.actions.snippet_stop()
  vim.cmd("stopinsert")
end, { expr = true, desc = "Escape and Clear hlsearch" })

if vim.g.neovide then
  map("i", "<C-v>", "<C-r>+", { desc = "paste from system clipboard, this is for neovim gui" })

  function LaunchKittyInCurrentPath()
    local current_dir_path = vim.fn.getcwd()
    local cmd = { "kitty", "--working-directory", current_dir_path }
    vim.fn.jobstart(cmd, {
      detach = true,
    })
  end

  map("n", "<C-n>", LaunchKittyInCurrentPath, { desc = "launch kitty with cwd, this is for neovim gui" })
end
