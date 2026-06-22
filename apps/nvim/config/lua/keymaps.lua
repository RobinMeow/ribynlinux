-- Clear highlights on search when pressing <Esc> in normal mode :help hlsearch
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("t", "<Esc><Esc>", "<c-\\><c-n>")

vim.keymap.set("n", "<leader><F2>", "*:%s///g<left><left>", { desc = "rename current word" })
-- * (Asterisk): This is a built-in Vim command. It looks at the word under your cursor, searches forward for it, and highlights all matches. Crucially, it saves that word into Vim's internal "search register".
-- :: Opens the command-line at the bottom of the screen.
-- %s: Starts a global substitution (search and replace) across the entire (%) file.
-- ///: The standard syntax is :%s/search/replace/. However, if you leave the search area empty, Vim automatically uses the last thing you searched for. Because you just pressed *, Vim secretly fills in the word under your cursor.
-- g: The "global" flag, meaning it changes every occurrence on a line, not just the first one.
-- <Left><Left>: Simulates pressing the Left arrow key twice. This moves your blinking cursor backward, landing it right between the two slashes: :%s//|/g.
vim.keymap.set("x", "<leader><F2>", '"hy:%s/<C-r>h//g<left><left>', { desc = "rename visual selection" })
-- "hy: * "h tells Vim to use a specific clipboard slot (the h register).
-- y yanks (copies) your highlighted visual selection into that h slot.
-- :: Opens the command line.
-- %s/: Starts the global search and replace command.
-- <C-r>h: In Vim's command line, pressing Ctrl + r followed by a register name pastes the contents of that register. This literally dumps whatever text you highlighted directly into the search field.

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move visual selectoin down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move visual selection up" })

-- delete into void, than paste (default: deleted text gets written into register)
vim.keymap.set("x", "<leader>p", '"_dP') -- read like this: "register into _void PPaste before cursor
vim.keymap.set("n", "<leader>d", '"_d') -- delete into void register
vim.keymap.set("v", "<leader>d", '"_d') -- delete into void register

vim.keymap.set("n", "<leader>st", [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]]) -- substituation for word under cursor

vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Move half page up while keeping cursor centered" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Move half page down while keeping cursor centered" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Move next while keeping cursor centered" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Move prev while keeping cursor centered" })

vim.keymap.set("v", ">", ">gv", { desc = "Indent and keep selection" })
vim.keymap.set("v", "<", "<gv", { desc = "Unindent and keep selection" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "join next line to current line w/o losing cursor position" })

vim.keymap.set("n", "<leader>aic", ":CodeCompanionChat Toggle<CR>", { desc = "[ ][a]i [c]hat" })

local session = require("session")
vim.keymap.set("n", "<leader><leader>ss", session.store_session, { desc = "[ ][s]ave [s]esssion" })
vim.keymap.set("n", "<leader><leader>se", session.store_session_and_exit, { desc = "[ ][s]ave sesssion and [e]xit" })
vim.keymap.set("n", "<leader><leader>sr", session.store_session_and_restart, { desc = "[ ][s]ession [r]estart" })
vim.keymap.set("n", "<leader><leader>sd", session.delete_session, { desc = "[ ][s]ession [d]elete, if exists" })

vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- convert line endings to unix
vim.keymap.set("n", "<leader><leader>u", ":e ++ff=dos<CR>:w<CR>:set ff=unix<CR>:w<CR>:e<CR>", { desc = "[ ] convert dos to [u]unix" })

vim.keymap.set("n", "<leader>y", '"+y') -- yank motion into system clipboard
vim.keymap.set("v", "<leader>y", '"+y') -- yank visual into system clipboard
-- FIXME: doesnt behave like Y, which yanks till end of line. it yanks the whole line
-- vim.keymap.set("n", "<leader>Y", '"+Y') -- yank till end of line into system clipboard
vim.keymap.set("n", "<leader><leader>y", ":%y+<CR>") -- yank whole buffer into system clipboard

vim.keymap.set("n", "<leader>g", ":DiffviewOpen<CR>", { desc = "[ ][g]it :DiffviewOpen" })
vim.keymap.set("n", "<leader>fh", ":DiffviewFileHistory %<CR>", { desc = "Git File History" }) -- NOTE: not planning on keeping this keybind but i dont have enough git ones yet to reserve g for git

-- indent level folding
vim.keymap.set("n", "<leader>f0", ":set foldlevel=0<CR>", { desc = "foldlevel 0" })
vim.keymap.set("n", "<leader>f1", ":set foldlevel=1<CR>", { desc = "foldlevel 1" })
vim.keymap.set("n", "<leader>f2", ":set foldlevel=2<CR>", { desc = "foldlevel 2" })
vim.keymap.set("n", "<leader>f3", ":set foldlevel=3<CR>", { desc = "foldlevel 3" })
vim.keymap.set("n", "<leader>f4", ":set foldlevel=4<CR>", { desc = "foldlevel 4" })
vim.keymap.set("n", "<leader>f5", ":set foldlevel=5<CR>", { desc = "foldlevel 5" })
vim.keymap.set("n", "<leader>f9", ":set foldlevel=99<CR>", { desc = "foldlevel 99" })

-- snacks terminal
vim.keymap.set("n", "<leader>t", function()
  require("snacks.terminal").toggle()
end, { noremap = true, silent = true })
vim.keymap.set("t", "<c-q>", function()
  require("snacks.terminal").toggle()
end, { noremap = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic location list" })
vim.keymap.set("n", "<leader>co", ":copen<CR>", { desc = "[c][open] open quickfix list" })

-- Keybinds to make split navigation easier.
-- See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<leader>dc", ":compiler dotnet<CR>:make<CR>:copen<CR>", {
  desc = "[d]otnet [c]ompile and populate quickfixlist",
  silent = true,
})

vim.keymap.set("n", "<leader>u", function()
  vim.cmd.packadd("nvim.undotree")
  require("undotree").open()
end, { desc = "(lazy)load and open [u]ndotree" })
