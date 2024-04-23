return {
    {
        'ibhagwan/fzf-lua',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            local actions = require("fzf-lua").actions
            require("fzf-lua").setup({
                winopts = {
                    preview = {
                        layout = 'vertical'
                    }
                },
                buffers = {
                    actions = {
                        ["ctrl-x"] = false,
                        ["ctrl-d"] = { actions.buf_del, actions.resume },
                    }
                }
            })
        end,
    },
}
