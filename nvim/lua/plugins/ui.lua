local config = require('plugins.config.init')
return {
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
        'onsails/lspkind-nvim',
        event = 'VeryLazy'
    },
    {
        'glepnir/dashboard-nvim',
        event = 'VimEnter',
        config = config.dashboard,
        dependencies = { 'nvim-tree/nvim-web-devicons' }
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
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        config = config.noice,
    },
    {
        'lewis6991/gitsigns.nvim',
        config = true,
        event = 'BufRead'
    },
}
