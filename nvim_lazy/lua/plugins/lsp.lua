return {
  {
    "neovim/nvim-lspconfig",
    -- stylua: ignore
    keys = {
      { "gn", vim.lsp.buf.rename, desc = "rename symbol" },
      { "gh", vim.lsp.buf.hover, desc = "show documentation" },
      { "ge", vim.diagnostic.open_float, desc = "show diagnostic" },
      { "gd", vim.lsp.buf.definition, desc = "go to definition" },
    },
  },
}
