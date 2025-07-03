return {
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    cmd = "ConformInfo",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        sh = { "shfmt" },
        python = { "isort", "black" },
        javascript = { "prettierd" },
        markdown = { "prettierd" },
      },
    },
    config = function ()
      require("conform").setup({
        -- can't set this in opts
        format_on_save = {
          async = true,
          lsp_format = "fallback",
        },
      })
    end
  },
}
