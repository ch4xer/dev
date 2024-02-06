local vim = vim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local ui = require('plugins.ui')
local utils = require('plugins.utils')
local lsp = require('plugins.lsp')
local edit = require('plugins.edit')
local git = require('plugins.git')
local cmp = require('plugins.cmp')
local dap = require('plugins.dap')
local test = require('plugins.test')
local neotree = require('plugins.neotree')
local telescope = require('plugins.telescope')
local treesitter = require('plugins.treesitter')
local note = require('plugins.note')

local concatenateTables = function(...)
    local result = {}
    for _, tableToConcatenate in ipairs { ... } do
        for i = 1, #tableToConcatenate do
            result[#result + 1] = tableToConcatenate[i]
        end
    end
    return result
end

local plugins = concatenateTables(
    ui,
    utils,
    lsp,
    edit,
    note,
    git,
    cmp,
    dap,
    test,
    neotree,
    telescope,
    treesitter
)

require("lazy").setup(
    plugins,
    {
        defaults = {
            lazy = true,
        }
    }
)
