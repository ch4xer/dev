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

local ui = require("plugins.ui")
local utils = require("plugins.utils")
local lsp = require("plugins.lsp")
local cmp = require("plugins.cmp")
local treesitter = require("plugins.treesitter")
local neotree = require("plugins.neotree")

local concatenateTables = function(...)
    local result = {}
    for _, tableToConcatenate in ipairs({ ... }) do
        for i = 1, #tableToConcatenate do
            result[#result + 1] = tableToConcatenate[i]
        end
    end
    return result
end

local plugins = concatenateTables(ui, utils, lsp, cmp, treesitter, neotree)

require("lazy").setup(plugins, {
    defaults = {
        lazy = true,
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "2html_plugin",
                "tohtml",
                "getscript",
                "getscriptPlugin",
                "gzip",
                "logipat",
                "netrw",
                "netrwPlugin",
                "netrwSettings",
                "netrwFileHandlers",
                "matchit",
                "man",
                "tar",
                "tarPlugin",
                "rrhelper",
                "spellfile_plugin",
                "shada",
                "vimball",
                "vimballPlugin",
                "zip",
                "zipPlugin",
                "tutor",
                "rplugin",
                "syntax",
                "synmenu",
                "spellfile",
                "optwin",
                "compiler",
                "bugreport",
                "ftplugin",
                "editorconfig",
            },
        },
    },
})
