# firefox

## manual settings

open firefox
run sync script
close it agin
run sync script
re-open it, check if google search is dark mode
if not repeat.
install vimium and uorigin block extensions
done.

## choosing firefox over chromium based browsers

- they display no tofus (did not manage to fix in chrome)
- syncing dotfiles is better supported [settings storage](https://wiki.archlinux.org/title/Firefox)
  and [manually backup and restore firefox profile data](https://support.mozilla.org/en-US/kb/back-and-restore-information-firefox-profiles#w_restoring-a-profile-backup)
- better privacy
- had an issue where wl-freeze github page tried to show a mp4 video but
  only audio worked (did not manage to fix this)
- configuring autostart rules for dynamic window tiling managers
  (chrome has the issue, that it runs an updater window instead, which then
  launches the real window, which will skip the rule.
  I worked around this, still annoying.)
- sth changed today, even tho it worked previously, now chrome thinks im recording.
  So now I cant watch netflix anymore. works fine on firefox.

config: `about:config`

in home:
~/.mozilla/firefox

[user.js](https://github.com/pyllyukko/user.js)

make sure to install pipewire-pulse for compat, since firefox uses pulseaudio/alsa
instead of wireplumber.

## setting firefox as default browser

```sh
xdg-settings get default-web-browser
xdg-settings set default-web-browser firefox.desktop
```

in case it happens:
[5.37 Notifications are not floating in tiling window managers or Wayland compositors](https://wiki.archlinux.org/title/Firefox)
