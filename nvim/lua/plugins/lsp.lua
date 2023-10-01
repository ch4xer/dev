local config = require('plugins.config.init')
return {
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
        'glepnir/lspsaga.nvim',
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = config.lspsaga,
        event = 'VeryLazy'
    },
}
