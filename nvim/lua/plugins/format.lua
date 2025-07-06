return {
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    cmd = "ConformInfo",
    opts = {
      default_format_opts = {
        async = true,
        quiet = true,
      },
      formatters_by_ft = {
        lua = { "stylua" },
        sh = { "shfmt" },
        javascript = { "prettierd" },
        markdown = { "prettierd" },
      },
    },
  },
}
