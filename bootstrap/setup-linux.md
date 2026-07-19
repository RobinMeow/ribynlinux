# Linux Setup (Fedora/Arch)

To prepare a Fedora or Arch Linux instance, run the following command. The script installs base packages (zsh, vim, sudo, git), optionally creates a new user, clones the repository, and starts the installation.

## Quick Start

> setup script is in rework. wip on archinstaller

```bash
sh -c "$(curl -fsSL https://codeberg.org/Ribyn/ribynlinux/raw/branch/master/scripts/setup-linux.sh)"
SKIP_INSTALL=true sh -c "$(curl -fsSL https://codeberg.org/Ribyn/ribynlinux/raw/branch/master/scripts/setup-linux.sh)"
```

or manually (Recommended: the setup script is iffy):
```bash
export RIBYN_ROOT="$HOME/ribynlinux"
git clone ssh://git@codeberg.org:Ribyn/ribynlinux.git $RIBYN_ROOT
$RIBYN_ROOT/scripts/install.sh --full-install
```

