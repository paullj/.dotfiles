-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Prepend mason bin to PATH so LSP servers are found without loading mason
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

vim.g.lazyvim_blink_main = true
vim.g.snacks_animate = false

-- Disable mouse popup warning
vim.cmd([[
  aunmenu PopUp.How-to\ disable\ mouse
  aunmenu PopUp.-2-
]])
