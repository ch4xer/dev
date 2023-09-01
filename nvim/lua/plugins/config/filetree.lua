M = function()
    local vim = vim

    local function on_attach(bufnr)
        local api = require('nvim-tree.api')
        local function opts(desc)
            return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- open pdf with xdg-open
        -- local function NvimTreeXdgOpen()
        --     local lib = require 'nvim-tree.lib'
        --     local node = lib.get_node_at_cursor()
        --     if node.extension == "pdf" then
        --         vim.fn.jobstart("xdg-open '" .. node.absolute_path .. "' &", { detach = true })
        --     else
        --         api.node.open.edit(node)
        --     end
        -- end
        --
        api.config.mappings.default_on_attach(bufnr)
        vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
        vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical Split'))
        vim.keymap.set('n', 's', api.node.open.horizontal, opts('Open: Horizontal Split'))
        vim.keymap.set('n', 'r', api.fs.rename_sub, opts('Rename: Omit Filename'))
        vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
        vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
        vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
        vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
        vim.keymap.set('n', 'F', api.live_filter.clear, opts('Clean Filter'))
        vim.keymap.set('n', 'f', api.live_filter.start, opts('Filter'))
        vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
        vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
        vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
    end

    require 'nvim-tree'.setup {
        on_attach           = on_attach,
        disable_netrw       = true,
        hijack_netrw        = true,
        open_on_tab         = true,
        hijack_cursor       = true,
        update_cwd          = true,
        sync_root_with_cwd  = true,
        view                = {
            adaptive_size = true,
            width = {
                min = 20,
                max = 40,
            },
            side = 'left',
            preserve_window_proportions = true,
        },
        filters             = { custom = { "^\\." } },
        update_focused_file = { enable = true, },
        renderer            = {
            highlight_opened_files = "all",
            indent_markers = { enable = true },
            symlink_destination = false,
        },
        diagnostics         = {
            enable = true,
            show_on_dirs = true,
            show_on_open_dirs = true,
        },
        git                 = {
            show_on_dirs = false,
        }
    }
end

return M
