return {
    {
        'lewis6991/gitsigns.nvim',
        config = true,
        event = 'VeryLazy',
    },
    {
        "kdheepak/lazygit.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        cmd = { "LazyGit", },
    }
}
