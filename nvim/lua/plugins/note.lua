return {
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
        config = function()
            vim.g.mkdp_browser = 'min'
            vim.g.mkdp_auto_close = 0
            vim.g.mkdp_combine_preview = 1
        end,
    },
    {
        'lervag/vimtex',
        lazy = false,
        config = function()
            vim.g.vimtex_view_method = 'zathura'
            vim.g.vimtex_quickfix_ignore_filters = { "Underfull", "Overfull", "Missing" }
        end,
    },
}
