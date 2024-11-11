return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local tsconfig = require("nvim-treesitter.configs")
      tsconfig.setup({
        ensure_installed = {
          "lua",
          "javascript",
          "c",
          "c_sharp",
          "cpp",
          "css",
          "go",
          "gomod",
          "gosum",
          "html",
          "jsdoc",
          "make",
          "markdown",
          "markdown_inline",
          "proto",
          "csv",
          "commonlisp",
          "scheme",
          "sql",
          "toml",
          "typescript",
          "xml",
          "yaml",
        },
        ignore_install = {},
        modules = {},
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
      })
    end,
  },
}
