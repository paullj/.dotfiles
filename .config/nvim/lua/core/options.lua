local opt = vim.opt
local o = vim.o
local g = vim.g

-------------------------------------- options ------------------------------------------
o.backup = false
o.laststatus = 3 -- always show the status line
o.showmode = false -- we don't need to see things like -- INSERT -- anymore

o.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
o.cursorline = true -- highlight the current line
o.cursorlineopt = "number"

-- Indenting
o.expandtab = true -- convert tabs to spaces
o.shiftwidth = 2 -- the number of spaces inserted for each indentation
o.smartindent = true -- make indenting smarter again
o.tabstop = 2 -- insert 2 spaces for a tab
o.softtabstop = 2 -- insert 2 spaces for a tab

opt.fillchars = { eob = " " }
-- o.ignorecase = true
-- o.smartcase = true
o.mouse = "a" -- allow the mouse to be used in neovim

-- -- Numbers
o.number = true -- set numbered lines
o.numberwidth = 4 -- set number column width to 2
o.ruler = false -- don't show the line and column number of the cursor position

opt.shortmess:append("sI") -- disable nvim intro

o.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
o.splitbelow = true -- force all horizontal splits to go below current window
o.splitright = true -- force all vertical splits to go to the right of current window
o.timeoutlen = 400 -- time to wait for a mapped sequence to complete (in milliseconds)
o.undofile = true -- enable persistent undo

-- interval for writing swap file to disk, also used by gitsigns
o.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>[]hl")

-- disable some default providers
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
