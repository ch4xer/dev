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
    { 'numToStr/Comment.nvim',    config = config.comment },
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
    },
    {
        'folke/todo-comments.nvim',
        dependencies = { "nvim-lua/plenary.nvim" },
        config = true
    },
    {
        "folke/zen-mode.nvim",
        config = true
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
    { 'akinsho/bufferline.nvim', config = config.bufferline },
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
    -- {
    --     'nvim-neo-tree/neo-tree.nvim',
    --     branch = "v2.x",
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --         "nvim-tree/nvim-web-devicons",
    --         "MunifTanjim/nui.nvim",
    --     },
    --     config = config.neotree,
    -- },
    -- {
    --     'folke/edgy.nvim',
    --     event = "VeryLazy",
    --     config = config.edgy,
    -- },
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
        config = config.cmp,
    },
    {
        'zbirenbaum/copilot.lua',
        event = "InsertEnter",
        config = config.copilot,
    },
    -- {
    --     'zbirenbaum/copilot-cmp',
    --     dependencies = {
    --         'zbirenbaum/copilot.lua',
    --     },
    --     event = "InsertEnter"
    -- },
    -- {
    --     'tzachar/cmp-tabnine',
    --     build = './install.sh',
    --     dependencies = 'hrsh7th/nvim-cmp',
    --     ft = {'go', 'rust', 'c', 'python'},
    -- },
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
        dependencies = { 'kevinhwang91/promise-async' }
    },
    -- {
    --     'nvim-neorg/neorg',
    --     build = ":Neorg sync-parsers",
    --     config = config.neorg,
    --     ft = 'norg',
    --     dependencies = { 'nvim-lua/plenary.nvim' }
    -- },
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
    },
    { 'onsails/lspkind-nvim' },
    { 'lewis6991/gitsigns.nvim', config = true },
    { 'phaazon/hop.nvim',        config = config.hop, },
}

require("lazy").setup(plugins)
