return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    config = function()
      local masonlsp = require("mason-lspconfig")

      local disabled_servers = {}

      masonlsp.setup({
        ensure_installed = { "html", "gopls", "ts_ls" },
        automatic_installation = true,
      })
      masonlsp.setup_handlers({
        function(server)
          -- Ignore servers on the disabled_servers list.
          for _, name in pairs(disabled_servers) do
            if name == server then
              return
            end
          end
          local opts = {
            -- Add global options in either directly here or separate Lua
            -- module, then hook it up here.
            -- on_attach = on_attach,
            -- capabilities = capabilities
          }

          local require_ok, found_server = pcall(require, "plugins.lsp." .. server)
          if require_ok then
            opts = vim.tbl_deep_extend("force", found_server, opts)
          end
          require("lspconfig")[server].setup(opts)
        end,
      })
    end,
  },
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
