- keep all install-app.sh seperately as before.
- design them to be invokeable in the cli for direct execution and when sourced they provide sync-app and install-app functions (where sync will only copy config files and install will install deps and the app itself as required)
- upgrade to set -euo pipefail where it makes sense
- extend the zshrc with autocompletion for a syntax like this "ribyn install appname" and "ribyn sync appname"
- consider a third term for install+sync, or having sync implicitly included in install (i think the latter makes more sense)
- scripts which are executed should not use .sh suffix, since not common https://google.github.io/styleguide/shellguide.html#s2.1-file-extensions
- move ng-test.sh and similars to bin/ngtest and have it added to path by zshrc
- all errors should use stderr not stdout
- read the google styleguide its not that long

https://oneuptime.com/blog/post/2026-02-13-shell-scripting-best-practices/view

recommended dir structure by ai1 for this repo:

```
ribyns-env/
├── bootstrap/        # entrypoints
│   ├── install
│   ├── setup-linux
│   ├── sync
│   └── doctor
│
├── docs/             # markdown knowledgebase
│   ├── arch-install.md
│   ├── linux.md
│   ├── hyprland.md
│   └── ollama.md
│
├── assets/           # non-config assets
│   ├── images/
│   ├── sounds/
│   └── wallpapers/
```
