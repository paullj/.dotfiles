local helpers = require("helpers.keys")
local keymap = helpers.map
local term_map = helpers.map

-- Modes
--  normal_mode = "n",
--  visual_mode = "v",
--  visual_block_mode = "x",
--  insert_mode = "i",
--  command_mode = "c",
--  terminal_mode = "t",

-- Mouse Menu
vim.cmd([[:amenu 10.100 mousemenu.Goto\ Definition <cmd>lua vim.lsp.buf.definition()<CR>]])
vim.cmd([[:amenu 10.110 mousemenu.References <cmd>lua vim.lsp.buf.references()<CR>]])
-- vim.cmd [[:amenu 10.120 mousemenu.-sep- *]]

keymap("n", "<RightMouse>", "<cmd>:popup mousemenu<CR>")
keymap("n", "<Tab>", "<cmd>:popup mousemenu<CR>")

-- Normal Mode --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", "Move to the window to the left") -- ctrl + h
keymap("n", "<C-j>", "<C-w>j", "Move to the window below") -- ctrl + j
keymap("n", "<C-k>", "<C-w>k", "Move to the window above") -- ctrl + k
keymap("n", "<C-l>", "<C-w>l", "Move to the window to the right") -- ctrl + l

keymap("n", "<leader>e", ":Lex 30<CR>", "Open file explorer") -- space+e

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", "Resize window up") -- ctrl + up
keymap("n", "<C-Down>", ":resize -2<CR>", "Resize window down") -- ctrl + down
keymap("n", "<C-Left>", ":vertical resize -2<CR>", "Resize window left") -- ctrl + left
keymap("n", "<C-Right>", ":vertical resize +2<CR>", "Resize window") -- ctrl + right

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", "Next buffer") -- shift + l
keymap("n", "<S-h>", ":bprevious<CR>", "Previous buffer") -- shift + h

-- Insert Mode --
keymap("i", "jk", "<Esc>", "Escape insert mode") -- jk

-- Visual Mode --
-- Stay in indent mode
keymap("v", "<", "<gv", "Indent left") -- <
keymap("v", ">", ">gv", "Indent right") -- >

-- Move text up and down
keymap("v", "A-j", ":m .+1<CR>==", "Move selected text down") -- alt + j
keymap("v", "A-k", ":m .-2<CR>==", "Move selected text up") -- alt + k
keymap("v", "p", '"_dP', "Paste without yanking") -- p

-- Visual Block Mode --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", "Move block of text down") -- J
keymap("x", "K", ":move '<-2<CR>gv-gv", "Move block of text up") -- K
keymap("x", "<C-j>", ":move '>+1<CR>gv-gv", "Move block of text down") -- ctrl + j
keymap("x", "<C-k>", ":move '<-2<CR>gv-gv", "Move block of text up") -- ctrl + k

-- Terminal Mode --
-- Better terminal navigation
term_map("t", "<C-h>", "<C-\\><C-N><C-w>h", "Move to the window to the left") -- ctrl + h
term_map("t", "<C-j>", "<C-\\><C-N><C-w>j", "Move to the window below") -- ctrl + j
term_map("t", "<C-k>", "<C-\\><C-N><C-w>k", "Move to the window above") -- ctrl + k
term_map("t", "<C-l>", "<C-\\><C-N><C-w>l", "Move to the window to the right") -- ctrl + l
