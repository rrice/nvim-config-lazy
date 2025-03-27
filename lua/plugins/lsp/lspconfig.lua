return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason.nvim", config = true },
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("rice-lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, fn, desc, mode)
          mode = mode or "n"
          vim.keymap.set(mode, keys, fn, { buffer = event.buf, desc = "LSP: " .. desc })
        end
        local tbn = require("telescope.builtin")

        -- Jump to the definition of the word under the cursor, use <C-t> to get back.
        map("gd", tbn.lsp_definitions, "[G]oto [D]efinition")

        -- Find the references for the word under the cursor.
        map("gr", tbn.lsp_references, "[G]oto [R]eferences")

        -- Jump to the implementation of the word under the cursor.
        map("gI", tbn.lsp_implementations, "[G]oto [I]mplementation")

        -- Jump to the type of the word under the cursor.
        map("<leader>D", tbn.lsp_type_definitions, "Goto Type [D]efinition")

        -- Fuzzy find all the symbols in the current document.
        map("<leader>ds", tbn.lsp_document_symbols, "[D]ocument [S]ymbols")

        -- Fuzzy find all the symbols in the current workspace.
        map("<leader>ws", tbn.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

        -- Rename the symbol under the cursor.
        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

        -- Execute a code action, usually the cursor has to be on top of an error
        -- or the suggestion to be activated.
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

        -- Jump to the declaration of the word under the cursor.
        map("<leader>gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

        -- Use CursorHold to highlight references of the word under the cursor after
        -- the cursor lands there and rests.
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
          local highlight_group = vim.api.nvim_create_augroup("rice-lsp-highlight", { clear = false })
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            group = highlight_group,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            group = highlight_group,
            callback = vim.lsp.buf.clear_references,
          })
          vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup("rice-lsp-detach", { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({ group = "rice-lsp-highlight", buffer = event2.buf })
            end,
          })
        end

        -- Toggle inlay hints
        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          map("<leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
          end, "[T]oggle Inlay [H]ints")
        end
      end,
    })
    -- Merge capabilities from nvim-cmp and broadcast it to the LSP servers.
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

    -- LSP servers to add.
    --
    -- Keys -
    --   cmd (table): override the default command used to start the server.
    --   filetypes (table): override the default list of associated filetypes used by the server.
    --   capabilities (table): override fields in the capabilities.
    --   settings (table): override the default settings that are passed in when initializing the server.
    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      },
      emmet_language_server = {
        filetypes = { "html", "htmx", "ejs", "css", "scss" },
      },
      html = {
        filetypes = { "html", "htmx", "ejs" },
      },
    }

    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "ts_ls",
        "emmet_language_server",
        "html",
        "pylsp",
        "zls",
        "dockerls",
        "docker_compose_language_service",
        "bashls",
        "openscad_lsp",
        "omnisharp",
        "powershell_es",
        "yamlls",
        "clangd",
        "arduino_language_server",
      },
      automatic_installation = true,
      handlers = {
        function(name)
          local server = servers[name] or {}
          -- Handles only overriding the servers defined above.
          server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
          require("lspconfig")[name].setup(server)
        end,
      },
    })
  end,
}
