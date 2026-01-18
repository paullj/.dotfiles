-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Remove snacks.nvim zen/zoom keybindings after plugins load
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    -- Delete zen/zoom keybindings if they exist
    pcall(vim.keymap.del, "n", "<leader>uz")
    pcall(vim.keymap.del, "n", "<leader>uZ")
  end,
})
