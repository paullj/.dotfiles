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

-- Function to handle right-click with proper window focus
_G.handle_right_click = function()
	-- Get mouse position
	local mouse_pos = vim.fn.getmousepos()
	-- Switch to the window under the mouse
	if mouse_pos.winid ~= 0 then
		vim.fn.win_gotoid(mouse_pos.winid)
	end
	-- Set cursor to mouse position
	if mouse_pos.line > 0 and mouse_pos.column > 0 then
		vim.fn.cursor(mouse_pos.line, mouse_pos.column)
	end
	-- Show the appropriate context menu
	vim.cmd('popup mousemenu')
end

-- Focus window on right-click before showing menu
keymap("n", "<RightMouse>", "<cmd>lua handle_right_click()<CR>")
keymap("v", "<RightMouse>", "<cmd>lua handle_right_click()<CR>")
keymap("i", "<RightMouse>", "<Esc><cmd>lua handle_right_click()<CR>")
keymap("n", "<Tab>", "<cmd>:popup mousemenu<CR>")

-- Normal Mode --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", "Move to the window to the left") -- ctrl + h
keymap("n", "<C-j>", "<C-w>j", "Move to the window below") -- ctrl + j
keymap("n", "<C-k>", "<C-w>k", "Move to the window above") -- ctrl + k
keymap("n", "<C-l>", "<C-w>l", "Move to the window to the right") -- ctrl + l

keymap("n", "<leader>e", ":Lex 30<CR>", "Open file explorer") -- space+e

-- Toggle relative line numbers
keymap("n", "<leader>rn", function()
	vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, "Toggle relative line numbers")

-- Reload configuration
keymap("n", "<leader>rc", function()
	vim.cmd("source ~/.config/nvim/init.lua")
	vim.notify("Config reloaded!", vim.log.levels.INFO)
end, "Reload config")

-- Resize windows (using Alt + hjkl instead of arrows)
keymap("n", "<M-k>", ":resize +2<CR>", "Resize window up") -- alt + k
keymap("n", "<M-j>", ":resize -2<CR>", "Resize window down") -- alt + j
keymap("n", "<M-h>", ":vertical resize -2<CR>", "Resize window left") -- alt + h
keymap("n", "<M-l>", ":vertical resize +2<CR>", "Resize window right") -- alt + l

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
-- Exit terminal with double escape
term_map("t", "<Esc><Esc>", "<C-\\><C-n>", "Exit terminal mode") -- double escape

-- Better terminal navigation
term_map("t", "<C-h>", "<C-\\><C-N><C-w>h", "Move to the window to the left") -- ctrl + h
term_map("t", "<C-j>", "<C-\\><C-N><C-w>j", "Move to the window below") -- ctrl + j
term_map("t", "<C-k>", "<C-\\><C-N><C-w>k", "Move to the window above") -- ctrl + k
term_map("t", "<C-l>", "<C-\\><C-N><C-w>l", "Move to the window to the right") -- ctrl + l

-- Disable Arrow Keys (force hjkl navigation)
-- Normal mode
keymap("n", "<Up>", "<Nop>", "Disabled - use k")
keymap("n", "<Down>", "<Nop>", "Disabled - use j")
keymap("n", "<Left>", "<Nop>", "Disabled - use h")
keymap("n", "<Right>", "<Nop>", "Disabled - use l")
keymap("n", "<C-Up>", "<Nop>", "Disabled - use Alt+k")
keymap("n", "<C-Down>", "<Nop>", "Disabled - use Alt+j")
keymap("n", "<C-Left>", "<Nop>", "Disabled - use Alt+h")
keymap("n", "<C-Right>", "<Nop>", "Disabled - use Alt+l")

-- Insert mode
keymap("i", "<Up>", "<Nop>", "Disabled - use k")
keymap("i", "<Down>", "<Nop>", "Disabled - use j")
keymap("i", "<Left>", "<Nop>", "Disabled - use h")
keymap("i", "<Right>", "<Nop>", "Disabled - use l")

-- Visual mode
keymap("v", "<Up>", "<Nop>", "Disabled - use k")
keymap("v", "<Down>", "<Nop>", "Disabled - use j")
keymap("v", "<Left>", "<Nop>", "Disabled - use h")
keymap("v", "<Right>", "<Nop>", "Disabled - use l")

-- Visual block mode
keymap("x", "<Up>", "<Nop>", "Disabled - use k")
keymap("x", "<Down>", "<Nop>", "Disabled - use j")
keymap("x", "<Left>", "<Nop>", "Disabled - use h")
keymap("x", "<Right>", "<Nop>", "Disabled - use l")
