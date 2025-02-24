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
    os.execute("fcitx5-remote -c")
  end,
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
