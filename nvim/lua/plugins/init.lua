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

local config = require('plugins.config.init')
local plugins = {
    {
        'folke/tokyonight.nvim',
        dependencies = {
            'akinsho/bufferline.nvim',
            'hoob3rt/lualine.nvim',
        },
        lazy = false,
        priority = 1000,
        config = config.ui
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
        event = 'VimEnter',
        config = config.dashboard,
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-project.nvim',
            'nvim-telescope/telescope-fzf-native.nvim',
        },
        config = config.telescope,
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
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
        dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
        build = ':TSUpdate',
        event = 'VeryLazy',
        config = config.treesitter
    },
    {
        'williamboman/mason.nvim',
        dependencies = {
            'WhoIsSethDaniel/mason-tool-installer.nvim',
            'neovim/nvim-lspconfig',
            'hrsh7th/cmp-nvim-lsp',
            'jose-elias-alvarez/null-ls.nvim',
        },
        build = ":MasonUpdate",
        config = config.lsp,
        event = 'BufRead'
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp-signature-help',
        },
        event = "InsertEnter",
        config = config.cmp,
    },
    {
        'zbirenbaum/copilot.lua',
        event = "InsertEnter",
        config = config.copilot,
    },
    {
        'danymat/neogen',
        config = true,
    },
    {
        'kevinhwang91/nvim-ufo',
        config = config.fold,
        dependencies = { 'kevinhwang91/promise-async' },
        event = 'VeryLazy'
    },
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'rcarriga/nvim-dap-ui',
            'theHamsta/nvim-dap-virtual-text'
        },
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
    -- {
    --     'folke/persistence.nvim',
    --     config = config.session,
    -- },
    {
        "folke/flash.nvim",
        config = config.flash,
    },
    {
        'christoomey/vim-tmux-navigator',
        lazy = false,
    },
    {
        'famiu/bufdelete.nvim',
        lazy = false
    },
    {
        'ojroques/nvim-osc52',
        config = config.osc52,
        lazy = false,
    },
    {
        "kylechui/nvim-surround",
        config = config.surround,
        event = "VeryLazy",
    },
    {
        'lervag/vimtex',
        lazy = false,
        config = config.latex,
    },
    {
        'tpope/vim-obsession',
        lazy = false,
    }
}

require("lazy").setup(
    plugins,
    {
        defaults = {
            lazy = true,
        }
    }
)
