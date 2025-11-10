return {
  {
    "neovim/nvim-lspconfig",
  },
  {
    "mason-org/mason.nvim",
    config = true,
  },
  {
    "hrsh7th/cmp-nvim-lsp",
  },
  {
    "mason-org/mason-lspconfig.nvim",
    config = function()
      require("lspconfig").racket_langserver.setup({})

      vim.lsp.enable("racket_langserver")

      local lsp_setup_group = vim.api.nvim_create_augroup("my_lsp_setup", { clear = true })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = lsp_setup_group,
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
          local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
          if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local lsp_highlight_group = vim.api.nvim_create_augroup("my_lsp_highlight", { clear = true })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = lsp_highlight_group,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = lsp_highlight_group,
              callback = vim.lsp.buf.clear_references,
            })
            vim.api.nvim_create_autocmd("LspDetach", {
              group = lsp_highlight_group,
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = lsp_highlight_group, buffer = event2.buf })
              end,
            })
          end

          -- Toggle inlay hints
          if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map("<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, "[T]oggle Inlay [H]ints")
          end
        end,
      })
    end,
  },
}
