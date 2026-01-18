-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.del("n", "<leader>K")

-- Remove snacks.nvim zen/zoom keybindings
pcall(vim.keymap.del, "n", "<leader>uz")
pcall(vim.keymap.del, "n", "<leader>uZ")

vim.keymap.set("n", "<Up>", "<Nop>", { desc = "Disabled - use k" })
vim.keymap.set("n", "<Down>", "<Nop>", { desc = "Disabled - use j" })
vim.keymap.set("n", "<Left>", "<Nop>", { desc = "Disabled - use h" })
vim.keymap.set("n", "<Right>", "<Nop>", { desc = "Disabled - use l" })
vim.keymap.set("n", "<C-Up>", "<Nop>", { desc = "Disabled - use Alt+k" })
vim.keymap.set("n", "<C-Down>", "<Nop>", { desc = "Disabled - use Alt+j" })
vim.keymap.set("n", "<C-Left>", "<Nop>", { desc = "Disabled - use Alt+h" })
vim.keymap.set("n", "<C-Right>", "<Nop>", { desc = "Disabled - use Alt+l" })

-- Disable arrow key movement
-- Insert mode
vim.keymap.set("i", "<Up>", "<Nop>", { desc = "Disabled - use k" })
vim.keymap.set("i", "<Down>", "<Nop>", { desc = "Disabled - use j" })
vim.keymap.set("i", "<Left>", "<Nop>", { desc = "Disabled - use h" })
vim.keymap.set("i", "<Right>", "<Nop>", { desc = "Disabled - use l" })

-- Visual mode
vim.keymap.set("v", "<Up>", "<Nop>", { desc = "Disabled - use k" })
vim.keymap.set("v", "<Down>", "<Nop>", { desc = "Disabled - use j" })
vim.keymap.set("v", "<Left>", "<Nop>", { desc = "Disabled - use h" })
vim.keymap.set("v", "<Right>", "<Nop>", { desc = "Disabled - use l" })

-- Visual block mode
vim.keymap.set("x", "<Up>", "<Nop>", { desc = "Disabled - use k" })
vim.keymap.set("x", "<Down>", "<Nop>", { desc = "Disabled - use j" })
vim.keymap.set("x", "<Left>", "<Nop>", { desc = "Disabled - use h" })
vim.keymap.set("x", "<Right>", "<Nop>", { desc = "Disabled - use l" })

-- Insert Mode --
vim.keymap.set("i", "jk", "<Esc>", { desc = "Escape insert mode" }) -- jk

-- Visual Mode --
-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left" }) -- <
vim.keymap.set("v", ">", ">gv", { desc = "Indent right" }) -- >

-- Move text up and down
vim.keymap.set("v", "<A-j>", ":m .+1<CR>==", { desc = "Move selected text down" }) -- alt + j
vim.keymap.set("v", "<A-k>", ":m .-2<CR>==", { desc = "Move selected text up" }) -- alt + k
vim.keymap.set("v", "p", '"_dP', { desc = "Paste without yanking" }) -- p

-- Visual Block Mode --
-- Move text up and down
vim.keymap.set("x", "J", ":move '>+1<CR>gv-gv", { desc = "Move block of text down" }) -- J
vim.keymap.set("x", "K", ":move '<-2<CR>gv-gv", { desc = "Move block of text up" }) -- K
vim.keymap.set("x", "<C-j>", ":move '>+1<CR>gv-gv", { desc = "Move block of text down" }) -- ctrl + j
vim.keymap.set("x", "<C-k>", ":move '<-2<CR>gv-gv", { desc = "Move block of text up" }) -- ctrl + k

-- Terminal Mode --
-- Exit terminal with double escape
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" }) -- double escape
