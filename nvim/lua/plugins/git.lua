return {
    {
        'lewis6991/gitsigns.nvim',
        config = true,
        event = 'BufRead',
    },
    {
        "kdheepak/lazygit.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        cmd = { 'LazyGit' }
    },
}
