-- NOTE: list the plugins I don't use but pay attention to.
local plugins = {
    {
        -- too complicated
        'nvim-neo-tree/neo-tree.nvim',
        branch = "v2.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        config = config.neotree,
    },
    {
        'folke/edgy.nvim',
        event = "VeryLazy",
        config = config.edgy,
    },

    {
        'zbirenbaum/copilot-cmp',
        dependencies = {
            'zbirenbaum/copilot.lua',
        },
        event = "InsertEnter"
    },
    {
        'tzachar/cmp-tabnine',
        build = './install.sh',
        dependencies = 'hrsh7th/nvim-cmp',
        ft = { 'go', 'rust', 'c', 'python' },
    },
    {
        'nvim-neorg/neorg',
        build = ":Neorg sync-parsers",
        config = config.neorg,
        ft = 'norg',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        -- this plugin has bug
        'ray-x/lsp_signature.nvim',
        config = config.signature,
        event = 'InsertEnter'
    },
}
