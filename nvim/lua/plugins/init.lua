local vim = vim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local config = require('plugins.config.init')
local plugins = {
    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
        config = config.theme
    },
    { "dstein64/vim-startuptime", cmd = "StartupTime" },
    {
        'numToStr/Comment.nvim',
        config = config.comment,
        event = { 'BufRead' }
    },
    {
        'windwp/nvim-autopairs',
        config = true,
        event = { 'InsertEnter' }
    },
    {
        'abecodes/tabout.nvim',
        dependencies = {
            'nvim-treesitter/nvim-treesitter'
        },
        config = config.tabout,
        event = { 'InsertEnter' }
    },
    {
        'folke/todo-comments.nvim',
        dependencies = { "nvim-lua/plenary.nvim" },
        config = true,
        event = { 'BufRead' }
    },
    {
        "folke/zen-mode.nvim",
        config = true,
        event = { 'BufRead' }
    },
    {
        'glepnir/dashboard-nvim',
        -- event = 'VimEnter',
        lazy = true,
        config = config.dashboard,
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-project.nvim',
        },
        cmd = { 'Telescope' },
        config = config.telescope,
    },
    { 'akinsho/bufferline.nvim',  config = config.bufferline },
    {
        'lukas-reineke/indent-blankline.nvim',
        event = 'BufRead',
        config = config.indent
    },
    {
        'RRethy/vim-illuminate',
        event = 'BufRead',
    },
    {
        'hoob3rt/lualine.nvim',
        event = 'BufRead',
        config = config.lualine
    },
    { 'famiu/bufdelete.nvim' },
    {
        'kyazdani42/nvim-tree.lua',
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
        config = config.filetree,
    },
    {
        'stevearc/aerial.nvim',
        config = config.outline,
        cmd = { 'AerialToggle' }
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
        event = 'BufRead',
        config = config.treesitter
    },
    {
        'williamboman/mason.nvim',
        dependencies = {
            'williamboman/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim'
        },
        build = ":MasonUpdate",
        config = config.mason,
        event = 'BufRead'
    },
    {
        -- dont use any event, which will cause bugs
        'hrsh7th/nvim-cmp',
        dependencies = {
            'neovim/nvim-lspconfig',
            'hrsh7th/cmp-nvim-lsp',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-buffer',
        },
        config = config.cmp,
    },
    {
        'j-hui/fidget.nvim',
        tag = 'legacy',
        config = true,
    },
    {
        'zbirenbaum/copilot.lua',
        event = "InsertEnter",
        config = config.copilot,
    },
    -- format
    {
        'jose-elias-alvarez/null-ls.nvim',
        event = 'BufReadPre',
        dependencies = { 'williamboman/mason.nvim' },
        config = config.nullls
    },
    {
        'kevinhwang91/nvim-ufo',
        config = config.fold,
        dependencies = { 'kevinhwang91/promise-async' },
        event = 'BufRead'
    },
    {
        'mfussenegger/nvim-dap',
        lazy = true,
        dependencies = {
            'rcarriga/nvim-dap-ui',
            'theHamsta/nvim-dap-virtual-text'
        },
        config = config.dap,
        ft = { 'go', 'c', 'rust', 'python' }
    },
    {
        'glepnir/lspsaga.nvim',
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = config.lspsaga,
        event = 'BufRead'
    },
    { 'onsails/lspkind-nvim' },
    { 'lewis6991/gitsigns.nvim', config = true,           event = 'BufRead' },
    { 'folke/persistence.nvim',  config = config.session, event = 'BufReadPre' },
    -- { 'smoka7/hop.nvim',         config = config.hop,     event = 'BufRead' },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        config = config.flash,
    },
}

require("lazy").setup(plugins)
