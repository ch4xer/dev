local vim = vim

M = {}

M.paste_as_link = function()
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
    local abs_dir = M.get_marksman_root_dir() .. "/.images/"
    if vim.fn.isdirectory(abs_dir) == 0 then
        return
    end
    local filename = vim.fn.fnamemodify(vim.fn.expand "%", ":t:r")
    local note_dir = abs_dir .. filename .. "/"
    if vim.fn.isdirectory(note_dir) == 0 then
        vim.print(note_dir)
        vim.fn.mkdir(note_dir, "p")
    end
    local abs_path = note_dir .. current_time .. ".png"
    local cmd
    if is_wayland then
        cmd = "wl-paste --no-newline --type image/png > '%s'"
    else
        cmd = "xclip -selection clipboard -t image/png -o > '%s'"
    end
    os.execute(string.format(cmd, abs_path))
    local rlt_path = "/.images/" .. filename .. "/" .. current_time .. ".png"
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
    local system_os = vim.loop.os_uname().sysname
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


M.delete_unsed_image = function()

end

return M
