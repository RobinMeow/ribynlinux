# Discord

disable auto updates, to ensure hyprland
launches the window on the correct workspace.
Otherwise the updater will launch on that workspace and spawn discord
randomly elsewhere.
add a `"SKIP_HOST_UPDATE": true` in `~/.config/discord/settings.json`

Using Vesktop now, which is alot faster.
[vesktop.dev/install/linux](https://vesktop.dev/install/linux/)
download x64
you can use this to install an update which you previously skipped:
`sudo dnf install /home/ribyn/.cache/vesktop-updater/pending/vesktop-1.7.0.x86_64.rpm`
