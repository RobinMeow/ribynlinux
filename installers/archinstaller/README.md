# RibynLinux archinstaller

writing my own installer with my perferred defaults.
With easy selection for per-machine difference, which can deviate.

> this is on hold. Since Im not sure if I really need go for this. Also the installation guide is pretty small.
> prolly will rename this one, into another go app as soon as I know what.

## Development

to run the installer 

```sh
cd $RIBYN_ROOT/installers/archinstaller/
go run .`
```

## Libs

shell wrapper for bubbletea (not useful for this project) [charmbracelet/gum](https://github.com/charmbracelet/gum)
tui lib [charmbracelet/bubbletea](https://github.com/charmbracelet/bubbletea)
component lib for bubbletea [charmbracelet/bubbles](https://github.com/charmbracelet/bubbles)
