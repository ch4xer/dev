M = function()
    local null_ls = require("null-ls")
    null_ls.setup({
        sources = {
            null_ls.builtins.formatting.clang_format.with({
                extra_args = {
                    -- "-style=file:" .. vim.fn.expand("$XDG_CONFIG_HOME/nvim/misc/clang_format"),
                    "-style=" .. vim.fn.expand("{IndentWidth: 4}"),
                }
            }),
            null_ls.builtins.formatting.markdown_toc,
            null_ls.builtins.formatting.prettier,
            null_ls.builtins.formatting.black.with({
                extra_args = { "--line-length=100" }
            }),
            null_ls.builtins.formatting.isort,
        }
    })
end


return M
