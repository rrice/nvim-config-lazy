return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      ensure_installed = {
        "prettier",
      },
      setup = {
        rust_analyzer = function()
          return true
        end,
      },
      servers = {
        lua_ls = {
          mason = false,
        },
      },
    },
    lazy = false,
    config = function()
      local lspconfig = require("lspconfig")
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}
