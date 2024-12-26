-- Autocmpletion configuration
return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {

    -- Snippet engine and other sources.
    {
      "L3MON4D3/LuaSnip",
      build = (function()
        -- This step is needed for regex support in snippets.
        -- Although it could happen, I don't want to support this
        -- on windows.
        if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
          return
        end
        return "make install_jsregexp"
      end)(),
      dependencies = {
        -- friendly-snippets has a good set of usable snippets,
        -- but we have to lazy load it.
        {
          "rafamadriz/friendly-snippets",
          config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
          end,
        },
      },
    },
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    luasnip.config.setup()

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = { completeopt = "menu,menuone,noinsert" },
      mapping = cmp.mapping.preset.insert({
        -- Select the [n]ext completion.
        ["<C-n>"] = cmp.mapping.select_next_item(),
        -- Tab key to select the next completion instead of <C-n>.
        ["<Tab>"] = cmp.mapping.select_next_item(),
        -- Select the [p]revious cempletion.
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        -- Shift-Tab key to select the previous completion instead of <C-p>.
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        -- Scroll the documentation window [b]ack.
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        -- Scroll the documentation widown [f]orward.
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        -- Manually trigger the completion.
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),

        -- Accept [y]es the completion.
        ["<C-y>"] = cmp.mapping.confirm({
          select = true,
        }),
        -- But using a carriage return does the same thing.
        ["<CR>"] = cmp.mapping.confirm({
          select = true,
        }),
        -- Placeholder navigation
        -- <C-l> - move to next placeholder.
        -- <C-h> - move to previous placeholder.
        ["<C-l>"] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { "i", "s" }),
        ["<C-h"] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      }),
    })
  end,
}
