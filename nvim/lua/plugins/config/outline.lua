M = function()
    require("aerial").setup({
        layout = {
            max_width = { 30, 0.2 },
        }
    })
    -- require("symbols-outline").setup({
    --     highlight_hovered_item = true,
    --     show_symbol_details = false,
    --     show_numbers = false,
    --     auto_close = false,
    --     width = 15,
    --     keymaps = {
    --         close = { "<Esc>", "q" },
    --         goto_location = "<Cr>",
    --         focus_location = "o",
    --         hover_symbol = "<C-space>",
    --         toggle_preview = "K",
    --         rename_symbol = "r",
    --         code_actions = "a",
    --         fold = "h",
    --         unfold = "l",
    --         fold_all = "W",
    --         unfold_all = "E",
    --         fold_reset = "R",
    --     }
    -- }
    -- )
end
return M
