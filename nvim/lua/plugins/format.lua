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
      format_on_save = {
        async = true,
        lsp_format = "fallback",
      },
    },
  },
}
