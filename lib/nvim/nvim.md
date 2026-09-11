# nvim

## tasks

- checkout these tree sitter parsers, they sound interesting
  `git_config	unstable	HF J 	@amaanq`
  `git_rebase	unstable	H  J 	@gbprod`
  `gitattributes	unstable	H  JL	@ObserverOfTime`
  `gitcommit	unstable	H  J 	@gbprod`
  `gitignore	unstable	H  J 	@theHamsta`
- consider cnext keybinds
  `vim.keymap.set("n", "<leader>cn", ":cnext<CR>")`
  `vim.keymap.set("n", "<leader>ct", ":cprev<CR>")`
  `vim.keymap.set("n", "<leader>cc", ":cclose<CR>")`
  `vim.keymap.set("n", "<leader>cf", ":cnfile<CR>")`
- close all buffers and reopen last edited `vim.keymap.set("n", "cab", ":%bd|e#|bd#<CR><C-O><CR>")` (close all but current would be nicer)
- review prs from github/gitlab in neovim [atlas.nvim](https://github.com/emrearmagan/atlas.nvim)
  I have not yet compared this to other plugins. Just as an idea
- use go typescript compiler for my new CompileTsc
- consider swapping from snacks to nvim-notify looks better and i wanna get rid of snacks
- increase git diffview left panel default width
- strike trhough words when deprecated
- vim._core.ui2 configure it to be me useable
- custom emoji loader :) see spinners.json origin: https://github.com/zadirion/Unreal.nvim/blob/main/lua/spinners.json
- text to neovim (voice: change inner word)
- keymap for search config which lets me use telescope fuzzy serach for dirs in .config (not only neovim and hypr)
- neovim tests against all my config
- enable tildeop with operator
- harpoon https://github.com/ThePrimeagen/harpoon/tree/harpoon2
- read :help lua-guide
- learn native nvim motions and operations before re-enableing mini.surround/flash plugins
- current restore session solution, is good enough. but if i desore restored terminals or DBUI, or quickfix lists i might want to look for plugin
- virtual text for debugging https://github.com/theHamsta/nvim-dap-virtual-text?utm_source=chatgpt.com
- show cmd line in the middle of the screen for pair programming
- populate tsc/tsgo/lint errors into quickfix

## transparency

if you want to disable transparency for floating windows,
checkout gh for transparent.nvim and comments in colorscheme.lua for kanagawa

## uninstall manually

required when chaning stable to master version or vice versa, if you also change the git clone location

```sh
# i used this with help of ai on two machines and it worked.
# tho, i dont know if it was proper
rm /usr/local/bin/nvim
# rm: remove write-protected regular file '/usr/local/bin/nvim'? ^C
sudo rm /usr/local/bin/nvim
sudo rm -rf /usr/lib/nvim
sudo rm -rf /usr/lib/nvim
sudo rm -rf /usr/local/lib/nvim
sudo rm -rf /usr/local/share/nvim
sudo rm -rf /usr/share/nvim
```

[neovim.io uninstall](https://neovim.io/doc/install/#uninstall)

```sh
sudo cmake --build build/ --target uninstall
# alternatively
sudo rm /usr/local/bin/nvim
sudo rm -r /usr/local/share/nvim/
```

## notes

- [prevent double rename](https://github.com/nvim-telescope/telescope.nvim/issues/3328#issuecomment-2472420006)
- lsp-linked_editing_range (e.g. auto update closing tags html) [telescope dedup](https://github.com/nvim-telescope/telescope.nvim/issues/3328)
- [30 vim commands must-know: refresher for features which exist](https://www.youtube.com/watch?v=RSlrxE21l_k)
