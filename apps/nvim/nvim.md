# nvim

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
