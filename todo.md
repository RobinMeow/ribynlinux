# TicketSystem

- maybe rsy before rin (because things like cargo-binstall want to collect telemetry)
- defer homebrew installs to the end, to improve unattended installs
- move logs from .cache to .local/state
- arch only i think; cargo breaks ci on first install, asking if install from rust or rustup
- hypr wayland-protocol is missing on wob install
- hypr sync should only call hyprctl reload if hypr is running (or ignore the error)
- find something, which renders a grid on the screen flash-vimium-like
  to let me click on areas
- rename to run_on_distro to distro_strategies.sh and include pacin dnfin
- config.sh is the single point of truth, all others shell scripts should
  not have fall back values
- automate build from sources and use a lock file system
- rmpc configure for my use case wich is dir only
- use ribyn_rsync instead of cp -r everywhere (better verbosity,
  improved performance and copies only files when neccessary)
- rmpc primary colors needs to be orange
- config.sh should defined env variables for syncing which each sync.sh
  reachs as needed (instead of having rsy defining its own fallbacks)
- Rename shell variable $RIBYN_ROOT to $RIBYN or $RIBYNLINUX $RIBYN_GIT $RIBYNLNX
- make sure I can do volume control outside hypr as needed (cli?)
- depends on firefox;make a cli tool to replace the need for bookmarks

# Further Education

- [practical bash scripting: what AI cant teach you](https://www.youtube.com/watch?v=aqEIE6Jn0mU)
- learn sed
- continue on [learn cpp chapter 11](https://www.learncpp.com/cpp-tutorial/implicit-type-conversion/)

## Spaceship Zsh prompt

consider using spaceshipt instead of p10k
```sh
. "$RIBYN_ROOT/lib/ensure_installed_homebrew.sh"
brew install --no-ask \
  spaceship
```

## Godot

- with godot an overlay grid which allows me to trigger mouse clicks
- https://github.com/CSharpGodotTools/Template godot learning resource for visualized debugging and multiplayer

## app ideas

- cli with promp questions for generating a config.sh file in ~/.config/ribyn/config.sh
- tui for managing worktrees
- tui to manage config.sh
- tui app for pomodora using my own timer bin
- music dl (TUI)
- calendar for birthdays (family sharable sync in Android?)
- Raster-Selection for Kitty (not only left right, but also up down tab bar)
- Ribyn-Distro installer
- lest I sleep the sleep of death
- jesus parables
- Isaiah 35:6. "Then will the lame leap like a deer, and the mute tongue shout for joy. Water will gush forth in the wilderness and streams in the desert." (New International Version)

## Fedora

- virtualization is not tested

## Kitty

- continue reading through the example config

## Neovim

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

## zsh / omz

- learn about the magic space
- add bible verses as message of the day

## Hyprland

decided to wait at least until im no longer on nvidia. Even pre-configured "themes" have an install scripts which will auto download open-nvidia-dkms driver or sth, and i dont wanna mess with my working system, nor maintain 4 versions of hyprland to have the same desktop env on my lenovo (amd), macbook (intel?) and pc (nvidia). and only my bluetooth keyboard in qwerty

## random notes

[30 vim commands must-know: refresher for features which exist](https://www.youtube.com/watch?v=RSlrxE21l_k)

- [yazi bulk rename](https://yazi-rs.github.io/features/)
- [yazi tips and tricks e.g. drag and drop](https://yazi-rs.github.io/docs/tips/#drag-and-drop)

- https://makefiletutorial.com
- make sure simple kind of man is in my music playlist
- [rclone to sync cloud as a mounted filesystem](https://github.com/rclone/rclone)

# Walkolution

wd40 zum nachschmieren
