return {
  {
    "mrjones2014/smart-splits.nvim",
    build = "./kitty/install-kittens.bash",
    lazy = false,
    -- stylua: ignore
    keys = {
      { "<C-h>", function() require("smart-splits").move_cursor_left() end, desc = "focus leftside window", },
      { "<C-j>", function() require("smart-splits").move_cursor_down() end, desc = "focus downside window", },
      { "<C-k>", function() require("smart-splits").move_cursor_up() end, desc = "focus upside window", },
      { "<C-l>", function() require("smart-splits").move_cursor_right() end, desc = "focus rightside window", },
    },
  },
  {
    "folke/persistence.nvim",
    enabled = false,
  },
}
