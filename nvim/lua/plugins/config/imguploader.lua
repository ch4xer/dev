M = function ()
    require'nvim-github-uploader'.setup({
    token = "xxxxxxxxx",
    repo = "your/repo",
    path = "note",
    img_name = function()
        return os.date "%Y-%m-%d-%H-%M-%S.png"
    end,
    affix = "![](%s)",
    message = "upload image",
    committer_name = "uploader",
    committer_email = "xxx@xxx.com",
    notice = "notify",
    tmp_file = "/tmp/nvim-github-uploader",
    show_name = true,
    })
end

return M
