local vim = vim
M = {}

vim.g.paste_as_link = function()
    if vim.bo.filetype ~= "markdown" then
        return
    end
    local is_wayland, is_img = M.get_clipboard_type()
    if is_img then
        M.paste_clipboard_image(is_wayland)
    else
        M.paste_clipboard_hyprlink(is_wayland)
    end
end

M.paste_clipboard_hyprlink = function(is_wayland)
    local cmd
    if is_wayland then
        cmd = "wl-paste --no-newline"
    else
        cmd = "xclip -selection clipboard -o"
    end
    local handle = io.popen(cmd, "r")
    if handle == nil then
        return
    end
    local content = handle:read("*a")
    local insert_txt = string.format("[link](%s)", content, content)
    vim.api.nvim_put({ insert_txt }, "l", true, true)
end

M.paste_clipboard_image = function(is_wayland)
    local current_time = os.date("%Y-%m-%d-%H-%M-%S")
    local filename = vim.fn.fnamemodify(vim.fn.expand "%", ":t:r")
    local abs_path, rlt_path
    -- for hugo blog index.md
    if filename == "index" then
        vim.print("index")
        abs_path = vim.fn.fnamemodify(vim.fn.expand "%", ":p:h") .. "/" .. current_time .. ".png"
        rlt_path = current_time .. ".png"
    else
        -- 1. markdown file in git repo
        -- 2. has Attachment folder in root directory
        local abs_dir = M.get_marksman_root_dir() .. "/Attachment/"
        if vim.fn.isdirectory(abs_dir) == 0 then
            return
        end
        local note_dir = abs_dir
        if vim.fn.isdirectory(note_dir) == 0 then
            vim.print(note_dir)
            vim.fn.mkdir(note_dir, "p")
        end
        abs_path = note_dir .. current_time .. ".png"
        rlt_path = "/Attachment/" .. current_time .. ".png"
    end
    local cmd
    if is_wayland then
        cmd = "wl-paste --no-newline --type image/png > '%s'"
    else
        cmd = "xclip -selection clipboard -t image/png -o > '%s'"
    end
    os.execute(string.format(cmd, abs_path))
    local insert_txt = string.format("![](%s)", rlt_path)
    vim.api.nvim_put({ insert_txt }, "l", true, true)
end

M.get_marksman_root_dir = function()
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
        return ""
    end
    for _, client in ipairs(clients) do
        if client.config.name == "marksman" then
            return client.config.root_dir
        end
    end
end

M.get_clipboard_type = function()
    local system_os = vim.uv.os_uname().sysname
    local cmd_check, is_wayland, is_img
    if system_os == "Linux" then
        local display_server = os.getenv "XDG_SESSION_TYPE"
        if display_server == "x11" or display_server == "tty" then
            cmd_check = "xclip -selection clipboard -o -t TARGETS"
            is_wayland = false
        elseif display_server == "wayland" then
            cmd_check = "wl-paste --list-types"
            is_wayland = true
        end
    else
        return ""
    end
    local command = io.popen(cmd_check)
    local content = {}
    for output in command:lines() do
        table.insert(content, output)
    end

    if vim.tbl_contains(content, "image/png") then
        is_img = true
    else
        is_img = false
    end
    return is_wayland, is_img
end

vim.g.delete_buf_or_quit = function()
    local exit = 'quit'
    local current_bufnr = vim.api.nvim_win_get_buf(0)
    local current_buf_name = vim.api.nvim_buf_get_name(current_bufnr)
    -- local current_win_number = vim.api.nvim_get_current_win()
    local is_valid = function(bufnr)
        if not bufnr or bufnr < 1 then return false end
        local exists = vim.api.nvim_buf_is_valid(bufnr)
        return vim.bo[bufnr].buflisted and exists
    end
    -- the current buffer should be valid
    if is_valid(current_bufnr) then
        exit = 'lua MiniBufremove.delete()'
        local should_quit = 0
        -- check if there is other window contains valid buffer
        -- for _, win in ipairs(vim.api.nvim_list_wins()) do
        --     local bufnr = vim.api.nvim_win_get_buf(win)
        --     -- bufnr ~= current_bufnr
        --     if win ~= current_win_number and is_valid(bufnr) then
        --         pre_exit = 'write'
        --         exit = 'quit'
        --         should_quit = 1
        --         break
        --     end
        -- end
        if should_quit == 0 then
            -- if there is only [No Name], quitall
            local valid_buffer_number = #vim.tbl_filter(is_valid, vim.api.nvim_list_bufs())
            if current_buf_name == "" and valid_buffer_number == 1 then
                exit = 'quitall'
            end
        end
    end
    vim.cmd(exit)
    vim.cmd.wincmd("=")
end

vim.g.wq_all = function()
    vim.cmd('silent wa')
    vim.cmd('qa')
end

vim.g.toggle_tree = function()
    local t = function()
        -- vim.cmd("Neotree show last toggle")
        vim.cmd("Neotree focus last toggle")
        vim.cmd.wincmd("=")
    end
    vim.fn.timer_start(1, t)
end

vim.g.close_tree = function()
    local get_filetree_window = function()
        for _, windowId in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
            local buffer = vim.api.nvim_win_get_buf(windowId)
            if vim.api.nvim_buf_get_option(buffer, 'ft') == 'neo-tree' then
                return windowId
            end
        end
        return nil
    end
    if vim.api.nvim_list_uis()[1].width <= vim.g.width_close_tree then
        if get_filetree_window() ~= nil then
            vim.cmd("Neotree action=close")
        end
    end
end

vim.g.quit_win = function()
    if #vim.api.nvim_list_wins() == 1 then
        vim.cmd('qa')
    end
    vim.api.nvim_win_close(0, true)
    vim.cmd.wincmd("=")
end

vim.g.preview_note = function()
    if vim.bo.filetype == 'markdown' then
        vim.cmd('MarkdownPreviewToggle')
    elseif vim.bo.filetype == 'tex' then
        vim.cmd('VimtexCompile')
    end
end

vim.g.is_not_large = function()
    -- will not trigger if file size is larger than 1000 KB
    local max_filesize = 1000 * 1024 -- 1000 KB
    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(0))
    if ok and stats and stats.size > max_filesize then
        return false
    end
    return true
end

vim.g.exec_on_small = function(func, ...)
    if vim.g.is_not_large() then
        func(...)
    end
end

vim.g.register_keymap = function(keySet)
    for _, set in pairs(keySet) do
        for _, keymap in ipairs(set) do
            if keymap[4] == nil then
                keymap[4] = { noremap = true, silent = true }
            end
            if keymap[3] ~= nil then
                vim.keymap.set(
                    keymap[1],
                    keymap[2],
                    keymap[3],
                    keymap[4]
                )
            end
        end
    end
end
