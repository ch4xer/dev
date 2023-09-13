M = function()
    local vim = vim
    local cmp = require('cmp')
    local compare = require('cmp.config.compare')
    local lspkind = require('lspkind')
    local luasnip = require 'luasnip'
    local border = {
        { "┌", "FloatBorder" },
        { "─", "FloatBorder" },
        { "┐", "FloatBorder" },
        { "│", "FloatBorder" },
        { "┘", "FloatBorder" },
        { "─", "FloatBorder" },
        { "└", "FloatBorder" },
        { "│", "FloatBorder" },
    }

    -- -- https://github.com/L3MON4D3/LuaSnip/issues/780
    luasnip.setup({
        update_events = { "TextChanged", "TextChangedI" },
        region_check_events = { "CursorMoved", "CursorHold", "InsertEnter", "CursorMovedI" },
        history = true,
    })
    require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/snippets" })
    require('neogen').setup({ snippet_engine = "luasnip" })

    cmp.setup({
        completion = {
            completeopt = 'menu,menuone,noinsert',
        },
        window = {
            completion = {
                border = border,
                scrollbar = '║',
            },
            documentation = {
                border = 'rounded'
            }
        },
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end,
        },
        formatting = {
            format = lspkind.cmp_format({
                mode = 'symbol_text',
                maxwidth = 50,
            }),
        },
        mapping = {
            ['<CR>'] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            }),
            ['<C-j>'] = cmp.mapping(function(fallback)
                if luasnip.expand_or_locally_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, { 'i', 's' }),
            ['<C-k>'] = cmp.mapping(function(fallback)
                if luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { 'i', 's' }),
            ['<Left>'] = cmp.mapping.close(),
            ['<Down>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                else
                    fallback()
                end
            end, { 'i', 's' }),
            ['<Up>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end, { 'i', 's' }),
        },
        matching = {
            disallow_fuzzy_matching = true,
            disallow_fullfuzzy_matching = true,
            disallow_partial_fuzzy_matching = false,
            disallow_partial_matching = false,
            disallow_prefix_unmatching = true,
        },
        preselect = cmp.PreselectMode.None,
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'nvim_lsp_signature_help' },
            { name = 'luasnip' },
        }, {
            { name = 'buffer' },
        }),
        sorting = {
            priority_weight = 1.0,
            comparators = {
                compare.locality,
                compare.sort_text,
                -- compare.scopes,
                compare.score,
                compare.exact,
                compare.recently_used,
                compare.offset,
                compare.kind,
                compare.sort_text,
                compare.length,
                compare.order,
            },
        }
    })

    -- auto insert `(` after select function or method item
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
    )
end

return M

-- example pyproject.toml for virtual envrionment:
-- [tool.ruff]
-- select = ["PLW","PLE","PLC",]
--
-- # Allow autofix for all enabled rules (when `--fix`) is provided.
-- fixable = ["A", "B", "C", "D", "E", "F", "G", "I", "N", "Q", "S", "T", "W", "ANN", "ARG", "BLE", "COM", "DJ", "DTZ", "EM", "ERA", "EXE", "FBT", "ICN", "INP", "ISC", "NPY", "PD", "PGH", "PIE", "PL", "PT", "PTH", "PYI", "RET", "RSE", "RUF", "SIM", "SLF", "TCH", "TID", "TRY", "UP", "YTT"]
--
-- # Exclude a variety of commonly ignored directories.
-- exclude = [".bzr",".direnv",".eggs",".git",".git-rewrite",".hg",".mypy_cache",".nox",".pants.d",".pytype",".ruff_cache",".svn",".tox",".venv","__pypackages__","_build","buck-out","build","dist","node_modules","venv"]
--
-- # Same as Black.
-- line-length = 88
--
-- [tool.ruff.mccabe]
-- # Unlike Flake8, default to a complexity level of 10.
-- max-complexity = 10
--
-- [tool.ruff.pydocstyle]
-- convention = "google"

-- [tool.pyright]
-- "venvPath": ".",
-- "venv": "."
--
-- marksman 's root directory is where .git folder exists
