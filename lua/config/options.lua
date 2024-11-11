-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

vim.wo.number = true

vim.g.mapleader = " "
vim.g.have_nerd_font = true

-- Enable mouse mode.
vim.opt.mouse = "a"

vim.opt.number = true
vim.opt.showmode = false
vim.opt.breakindent = true

-- Save the undo history to a file.
vim.opt.undofile = true

-- Case-insensitive searching unless \C or
-- more than one capital letter is in the search term.
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Window split behavior.
vim.opt.splitright = true
vim.opt.splitbelow = true

-- How to display certain whitespace characters.
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Live preview of substitutions.
vim.opt.inccommand = "split"

-- Show what line the cursor is on.
vim.opt.cursorline = true

-- Minimum number of lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Turn on true color
vim.opt.termguicolors = true
