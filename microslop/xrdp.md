# setup kde on wsl with rdp desktop session

```sh
sudo dnf install xrdp
sudo dnf install xorgxrdp
sudo dnf install plasma-workspace-x11 (on ubuntu plasma-session-x11)
sudo dnf install i3 (also based on x11)
sudo systemctl enable --now xrdp
```

setup your autostart
`nvim ~/.xsession`
type `exec startplasma-x11`

restart wsl (proper shutdown)

log back in and run `ip a`
to see your ip address (not the loopback. probably eth0)
and use `inet 172.x.x.x` as ip to log in via RDP

### xrdp on arch

[xrdp archwiki](https://wiki.archlinux.org/title/Xrdp)
enough said.
