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
    {
        'numToStr/Comment.nvim',
        config = config.comment,
        event = { 'VeryLazy' }
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
        event = { 'VeryLazy' }
    },
    {
        'glepnir/dashboard-nvim',
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
    {
        -- dont lazy
        'akinsho/bufferline.nvim',
        config = config.bufferline,
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        event = 'VeryLazy',
        config = config.indent
    },
    {
        'RRethy/vim-illuminate',
        event = 'VeryLazy',
    },
    {
        'hoob3rt/lualine.nvim',
        event = 'VeryLazy',
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
        lazy = true,
        config = config.outline,
        cmd = { 'AerialToggle' }
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
        event = 'VeryLazy',
        config = config.treesitter
    },
    {
        'williamboman/mason.nvim',
        dependencies = {
            'WhoIsSethDaniel/mason-tool-installer.nvim'
        },
        build = ":MasonUpdate",
        config = config.mason,
        event = 'VeryLazy'
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'neovim/nvim-lspconfig',
            'hrsh7th/cmp-nvim-lsp',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-buffer',
        },
        event = "VeryLazy",
        config = config.cmp,
    },
    {
        'zbirenbaum/copilot.lua',
        event = "InsertEnter",
        config = config.copilot,
    },
    {
        'jose-elias-alvarez/null-ls.nvim',
        dependencies = { 'williamboman/mason.nvim' },
        config = config.nullls,
        event = 'BufRead',
    },
    {
        'kevinhwang91/nvim-ufo',
        config = config.fold,
        dependencies = { 'kevinhwang91/promise-async' },
        event = 'BufRead'
    },
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'rcarriga/nvim-dap-ui',
            'theHamsta/nvim-dap-virtual-text'
        },
        lazy = true,
        config = config.dap,
    },
    {
        'glepnir/lspsaga.nvim',
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = config.lspsaga,
        event = 'VeryLazy'
    },
    {
        'onsails/lspkind-nvim',
        event = 'VeryLazy'
    },
    {
        'lewis6991/gitsigns.nvim',
        config = true,
        event = 'BufRead'
    },
    {
        'folke/persistence.nvim',
        config = config.session,
        event = 'BufReadPre'
    },
    {
        "folke/flash.nvim",
        config = config.flash,
        event = "VeryLazy",
    },
    {
        'christoomey/vim-tmux-navigator',
        lazy = false,
    },
    {
        "kylechui/nvim-surround",
        config = config.surround,
        event = "VeryLazy",
    },
    {
        'nvim-neorg/neorg',
        build = ":Neorg sync-parsers",
        config = config.neorg,
        ft = 'norg',
        event = "VeryLazy",
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
}

require("lazy").setup(plugins)
