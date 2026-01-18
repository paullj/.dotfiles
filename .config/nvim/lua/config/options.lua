-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.lazyvim_blink_main = true

-- Disable mouse popup warning
vim.cmd([[
  aunmenu PopUp.How-to\ disable\ mouse
  aunmenu PopUp.-2-
]])
