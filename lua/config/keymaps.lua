-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

-- Set highlight on search, press <Esc> to clear.
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymap bindings.
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uick fix list" })

-- Simplified window navigation.
vim.keymap.set("n", "<C-D-Left>", "<C-w><C-h>", { desc = "Move focus to left window" })
vim.keymap.set("n", "<C-D-Right>", "<C-w><C-l>", { desc = "Move focus to right window" })
vim.keymap.set("n", "<C-D-Down>", "<C-w><C-j>", { desc = "Move focus to lower window" })
vim.keymap.set("n", "<C-D-Up>", "<C-w><C-k>", { desc = "Move focus to upper window" })
