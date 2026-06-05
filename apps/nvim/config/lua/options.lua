--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.o.termguicolors = true

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

vim.o.number = true -- absolute line numbers
vim.o.relativenumber = true -- line numbers relative to cursor

-- this has no effect. i think blink_cmp is overriding it with its own defaults
-- vim.opt.completeopt = { "menu", "menuone", "noinsert" }

vim.o.showmode = false -- Don't show the mode, since it's already in the status line
vim.o.breakindent = true
vim.o.undofile = true -- Save undo to a history file

vim.opt.foldenable = true
vim.opt.foldcolumn = "1"
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99 -- start with all folds open

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.signcolumn = "yes" -- Keep signcolumn on by default

vim.o.updatetime = 250 -- If this many milliseconds nothing is typed the swap file will be written to disk (Default 4000)

vim.o.timeoutlen = 300 -- Decrease mapped sequence wait time

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

vim.o.winborder = "rounded" -- make all floating windows rounded

vim.o.shiftwidth = 2
vim.o.tabstop = 2

vim.opt.list = true
vim.opt.listchars = {
  tab = "· ", -- first char is overriden by ident blanklint plugin if applicable
  trail = "·",
  nbsp = "␣",
  eol = nil, -- used this one for a while '↵' other: ↵ ↲ ↲
}

-- Preview substitutions live, as you type! Whats a substitution: s%/replaceTxt/WithMe/g
-- will show the preview in the file without confirming it
vim.o.inccommand = "split"

vim.o.cursorline = true -- Show which line your cursor is on

vim.o.scrolloff = 10 -- amount of lines to keep visible above and beneath the cursor

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
vim.o.confirm = true
