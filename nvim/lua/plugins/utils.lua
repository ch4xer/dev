local config = require('plugins.config.init')
return {
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
        "kdheepak/lazygit.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        cmd = { 'LazyGit' }
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
        'tpope/vim-obsession',
        lazy = false,
    },
    {
        'lervag/vimtex',
        lazy = false,
        config = config.latex,
    }
}
