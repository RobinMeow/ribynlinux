# how to install and helpers

## peristent long term setup

TBD

## for testing purposes

```sh
# one-multi-liner
export RIBYN_ROOT="$HOME/ribynlinux" \
  && git clone --depth 1 https://github.com/RobinMeow/ribynlinux.git "$RIBYN_ROOT" \
  && "$RIBYN_ROOT/bin/ribyn_install"

# FEDORA (in docker setting up a user named ribyn)
dnf update -y && dnf install -y sudo git bc vim && \
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/RobinMeow/ribynlinux/master/bootstrap/yet-another-setup.sh)"

# ARCH (in docker setting up a user named ribyn)
pacman -Syu --noconfirm; pacman -S --noconfirm sudo git bc vim; && \
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/RobinMeow/ribynlinux/master/bootstrap/yet-another-setup.sh)"

# after login, run:
export RIBYN_ROOT="$HOME/ribynlinux" && \
  git clone --depth 1 https://github.com/RobinMeow/ribynlinux.git $RIBYN_ROOT \
  && "$RIBYN_ROOT/bin/ribyn_install"

# if testing in docker in wsl
export RIBYN_ROOT="$HOME/ribynlinux" && \
  export RIBYN_SKIP_DETECT_SLOP_USER="yes" && \
  git clone --depth 1 https://github.com/RobinMeow/ribynlinux.git $RIBYN_ROOT \
  && "$RIBYN_ROOT/bin/ribyn_install"

```

> `RIBYN_ROOT` environment variable is required by almost every script
> this is mostly only relevant for the first install. The zshrc exports this variable
>
> the ribyn_install script frequently changes,
> perhaps look into it to see which flags are supported

## raw links

github
`https://raw.githubusercontent.com/<usrname>/<repo>/<branch>/<path-to-file>`

codeberg
`https://codeberg.org/<username>/<repo>/raw/branch/<branchname>/<path-to-file>`
