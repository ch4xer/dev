-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  pattern = { "*" },
  command = "silent! wa",
})

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  callback = function()
    if vim.g.hasfcitx5 == 1 then
      os.execute("fcitx5-remote -c")
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
  pattern = "*.*",
  command = "silent! mkview",
})

vim.api.nvim_create_autocmd({ "BufRead" }, {
  pattern = "*.*",
  command = "silent! loadview",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "yml", "yaml", "json", "html", "css", "javascript", "typescript", "sh", "sql", "vue", "markdown", "lua" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function(ctx)
    local root = vim.fs.root(ctx.buf, { ".git", ".svn", "Makefile", "mvnw", "package.json", "go.mod", "Cargo.toml" })
    if root and root ~= "." and root ~= vim.fn.getcwd() then
      vim.cmd.cd(root)
    end
  end,
})

-- watch external file changes every 2 seconds
-- useful when files are changed by AI agents
local interval_ms = 2000

local timer = vim.uv.new_timer()
timer:start(
  interval_ms,
  interval_ms,
  vim.schedule_wrap(function()
    -- only trigger in normal mode
    if vim.fn.mode() ~= "n" then
      return
    end
    -- avoid nofile / terminal and other special buffers
    if vim.bo.buftype ~= "" then
      return
    end
    vim.cmd("checktime")
  end)
)

-- control cursor shape and blinking
vim.api.nvim_create_autocmd({ "VimEnter", "VimResume" }, {
  callback = function()
    vim.opt.guicursor = "n-v-c:block-blinkon0," -- normal/visual/cmd: Block, no blink
      .. "i-ci-ve:ver25-blinkon0," -- insert: Beam, no blink
      .. "r-cr:hor20-blinkon0," -- replace: underline, no blink
      .. "o:hor50-blinkon0," -- operator: half block, no blink
      .. "sm:block-blinkon0" -- showmatch: block, no blink
  end,
})

vim.api.nvim_create_autocmd({ "VimLeave", "VimSuspend" }, {
  callback = function()
    vim.opt.guicursor = "a:ver25-blinkwait700-blinkoff400-blinkon250"
  end,
})
