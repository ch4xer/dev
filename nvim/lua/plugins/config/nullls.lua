M = function()
    local null_ls = require("null-ls")
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    null_ls.setup({
        sources = {
            null_ls.builtins.formatting.clang_format.with({
                extra_args = {
                    -- "-style=file:" .. vim.fn.expand("$XDG_CONFIG_HOME/nvim/misc/clang_format"),
                    "-style=" .. vim.fn.expand("{IndentWidth: 4}"),
                }
            }),
            null_ls.builtins.formatting.prettier,
            null_ls.builtins.formatting.black,
            -- dont install pylint with mason, install in virtualenv with pip
            null_ls.builtins.diagnostics.pylint,
            null_ls.builtins.formatting.isort,
        },
    })
end


return M
