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
            null_ls.builtins.formatting.prettier,
            null_ls.builtins.formatting.black,
            null_ls.builtins.diagnostics.pylint.with({
                command = function ()
                    local cwd = vim.fn.getcwd()
                    if vim.fn.executable(cwd .. '/.venv/bin/pylint') == 1 then
                        return cwd .. '/.venv/bin/pylint'
                    else
                        return 'pylint'
                    end
                end,
                args = { "--from-stdin", "$FILENAME", "-f", "json", "--persistent=yes","--disable=C,R"},
            }),
            null_ls.builtins.formatting.isort,
        },
    })
end


return M
