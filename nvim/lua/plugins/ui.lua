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
        'nvim-neo-tree/neo-tree.nvim',
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
            's1n7ax/nvim-window-picker',
        },
        config = config.neotree,
        cmd = { "Neotree" },
    },
    {
        "folke/noice.nvim",
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
