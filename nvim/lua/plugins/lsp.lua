return {
  {
    "neovim/nvim-lspconfig",
    -- stylua: ignore
    keys = {
      { "gn", vim.lsp.buf.rename,         desc = "rename symbol" },
      { "gh", vim.lsp.buf.hover,          desc = "show documentation" },
      { "ge", vim.diagnostic.open_float,  desc = "show diagnostic" },
      { "gd", vim.lsp.buf.definition,     desc = "go to definition" },
      { "gr", vim.lsp.buf.references,     desc = "go to references" },
      { "ga", vim.lsp.buf.code_action,    desc = "Code Action" },
      { "gi", vim.lsp.buf.implementation, desc = "Implementation" },
    },
  },
}
