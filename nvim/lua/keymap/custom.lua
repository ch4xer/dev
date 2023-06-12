local vim = vim

M = {}

M.DeleteWinOrBuf = function()
    local pre_exit = ''
    local exit = 'quit'
    local current_bufnr = vim.api.nvim_win_get_buf(0)
    local current_buf_name = vim.api.nvim_buf_get_name(current_bufnr)
    local current_win_number = vim.api.nvim_get_current_win()
    local is_valid = function(bufnr)
        if not bufnr or bufnr < 1 then return false end
        local exists = vim.api.nvim_buf_is_valid(bufnr)
        return vim.bo[bufnr].buflisted and exists
    end
    -- the current buffer should be valid
    if is_valid(current_bufnr) then
        pre_exit = 'write'
        exit = 'Bdelete'
        local should_quit = 0
        -- check if there is other window contains valid buffer
        for _, win in ipairs(vim.api.nvim_list_wins()) do
            local bufnr = vim.api.nvim_win_get_buf(win)
            -- bufnr ~= current_bufnr
            if win ~= current_win_number and is_valid(bufnr) then
                pre_exit = 'write'
                exit = 'quit'
                should_quit = 1
                break
            end
        end
        if should_quit == 0 then
            -- if there is only [No Name], quitall
            local valid_buffer_number = #vim.tbl_filter(is_valid, vim.api.nvim_list_bufs())
            vim.print(valid_buffer_number)
            vim.print(current_buf_name)
            if current_buf_name == "" and valid_buffer_number == 1 then
                pre_exit = ''
                exit = 'quitall'
            end
        end
    end
    -- dont block exit even failed to save
    pcall(vim.cmd, pre_exit)
    vim.cmd(exit)
end

M.EnterInsert = function()
    local current_bufnr = vim.api.nvim_win_get_buf(0)
    local is_valid = function(bufnr)
        if not bufnr or bufnr < 1 then return false end
        local exists = vim.api.nvim_buf_is_valid(bufnr)
        return vim.bo[bufnr].buflisted and exists
    end
    if is_valid(current_bufnr) then
        vim.cmd('insert')
    end
end

M.FormatCode = function()
    if vim.bo.filetype == "norg" then
        vim.cmd('execute \"normal gg=G\\<C-o>\"')
    else
        vim.lsp.buf.format()
    end
end

M.Typora = function()
    local filename = vim.api.nvim_buf_get_name(0)
    vim.fn.system("Typora " .. filename)
end

M.sudo_write = function(tmpfile, filepath)
    local sudo_exec = function(cmd, print_output)
        vim.fn.inputsave()
        local password = vim.fn.inputsecret("Password: ")
        vim.fn.inputrestore()
        if not password or #password == 0 then
            M.warn("Invalid password, sudo aborted")
            return false
        end
        local out = vim.fn.system(string.format("sudo -p '' -S %s", cmd), password)
        if vim.v.shell_error ~= 0 then
            print("\r\n")
            M.err(out)
            return false
        end
        if print_output then print("\r\n", out) end
        return true
    end
    if not tmpfile then tmpfile = vim.fn.tempname() end
    if not filepath then filepath = vim.fn.expand("%") end
    if not filepath or #filepath == 0 then
        M.err("E32: No file name")
        return
    end
    -- `bs=1048576` is equivalent to `bs=1M` for GNU dd or `bs=1m` for BSD dd
    -- Both `bs=1M` and `bs=1m` are non-POSIX
    local cmd = string.format("dd if=%s of=%s bs=1048576",
        vim.fn.shellescape(tmpfile),
        vim.fn.shellescape(filepath))
    -- no need to check error as this fails the entire function
    vim.api.nvim_exec(string.format("write! %s", tmpfile), true)
    if sudo_exec(cmd) then
        print(string.format([[\r\n"%s" written]], filepath))
        vim.cmd("e!")
    end
    vim.fn.delete(tmpfile)
end

M.view_net_image = function()
    local current_line = vim.api.nvim_get_current_line()
    local link_start = string.find(current_line, "]%(")
    if link_start ~= nil then
        local link_end = string.find(current_line, "%)", link_start + 2)
        if link_end ~= nil then
            local link = string.sub(current_line, link_start + 2, link_end - 1)
            local tmpfile = os.getenv("HOME") .. "/.cache/nvim/imv-" .. os.date('%F-%H-%M-%S') .. ".jpg"
            os.execute('curl -s "' .. link .. '" -o ' .. tmpfile)
            os.execute('imv ' .. tmpfile .. ' &')
        end
    end
end

M.accept_copilot_suggestion = function()
    if require("copilot.suggestion").is_visible() then
        require("copilot.suggestion").accept()
    else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Right>", true, false, true), "n", false)
    end
end

return M
