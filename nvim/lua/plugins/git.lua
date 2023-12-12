return {
    {
        'lewis6991/gitsigns.nvim',
        config = true,
        lazy = false,
    },
    {
        "kdheepak/lazygit.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        cmd = { 'LazyGit' }
    },
}
