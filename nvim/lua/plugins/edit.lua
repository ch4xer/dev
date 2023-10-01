local config = require('plugins.config.init')
return {
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
        "shellRaining/hlchunk.nvim",
        event = { "VeryLazy" },
        config = config.indent,
    },
    {
        'RRethy/vim-illuminate',
        event = 'VeryLazy',
    },
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
        build = ':TSUpdate',
        event = 'VeryLazy',
        config = config.treesitter
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
        "folke/flash.nvim",
        config = config.flash,
    },
    {
        "kylechui/nvim-surround",
        config = config.surround,
        event = "VeryLazy",
    },
}
