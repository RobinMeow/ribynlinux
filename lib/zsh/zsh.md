# zsh

## Oh my zsh default keybinds

`CTRL+e` to accept ghost-like zsh-autosuggestions

`CTRL+r` search past commands _(this is default outside of omz,
and I dont use it anyways I have my own fh fn for this)_

### oh my zsh git aliases

keeping these to compare against my own, and pick the better one:
TODO: append --verbose to all my git `add` aliases:
TODO: consider adding -w (ignore whitespace changes) to the git diff aliases
`glod`                 | `git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'` iso date
`glods`                | `git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --date=short` iso day no time
`glol`                 | `git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'` close to mine, slight differences
`glola`                | `git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --all` --all shows every branch and makes the --graph more usefull
`glols`                | `git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --stat` git metrics. much better than my current glast
`glgp`                 | `git log --stat --patch` --patch shows the git diff, also much better then my current glast
`gl`                   | `git pull` already had this one shadows with gpl, will shadow again
`gp`                   | `git push --verbose`
TODO: git reset hard/soft aliases
NOTE: I usually don't need this, becuase I either want their changes, or I want them gone, and I dont have the issue of auto fetching
`gpf`                  | On Git >= 2.30: `git push --force-with-lease --force-if-includes` "-if my local branch -includes the remotes commit hashes" prevents the flaw from --force-with-lease
`gpsup`                | `git push --set-upstream origin $(git_current_branch)` if not changing origin name, nor setting autoSetupRemote = true in config
`gpristine`            | `git reset --hard && git clean --force -dfx`
`gwipe`                | `git reset --hard && git clean --force -df`
`gst`               | `git stash`
`gss`                  | `git status --short --branch`
`gsm`                  | `git submodule`
`gsw`                  | `git switch`
`gswd`                 | `git switch $(git_develop_branch)`
`gswm`                 | `git switch $(git_main_branch)`
TODO: gskip gnoskip
TODO: learn --patch includes git diff for past history on gl -2 --patch
`gwt`                  | `git worktree`

keeping these for reference. I dont use them currently but I might want to in the future:
`grt`                  | `cd "$(git rev-parse --show-toplevel \|\| echo .)"` change dir to git root
`gapa`                 | `git add --patch` interactively stage chunks
`gau`                  | `git add --update` add only already tracked files
`gwip`                 | `git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign --message "--wip-- [skip ci]"` `[skip ci]` is apparently built-in in azure devops, gh, gitlab etc..
`gbs`                  | `git bisect` I dont bisect often enough to need aliases for those. I already have to look up the cli most of the time
`gbsb`                 | `git bisect bad`
`gbsg`                 | `git bisect good`
`gbsn`                 | `git bisect new`
`gbso`                 | `git bisect old`
`gbsr`                 | `git bisect reset`
`gbss`                 | `git bisect start`
`gbgd`                 | `LANG=C git branch --no-color -vv \| grep ": gone\]" \| cut -c 3- \| awk '"'"'{print $1}'"'"' \| xargs git branch -d` I do this manually, but it is tedious tbh
`gbgD`                 | `LANG=C git branch --no-color -vv \| grep ": gone\]" \| cut -c 3- \| awk '"'"'{print $1}'"'"' \| xargs git branch -D`
`gbnm`                 | `git branch --no-merged` list branches not merged into current branch
`ggsup`                | `git branch --set-upstream-to=origin/$(git_current_branch)` dont often have to do this, dont mind doing it manually, the err message shows how to
`gbg`                  | `LANG=C git branch -vv \| grep ": gone\]"` "git branch gone"
`gcor`                 | `git checkout --recurse-submodules`
`gclean`               | `git clean --interactive -d`
`gcfu`                 | `git commit --fixup` not using yet. when you want to ammend something to a commit to far in the past. on rebasing it will be squashed into the specified commit nice to compare to fix up a branch at the end with rebase --autosquash apparently
`gdv`                  | `git diff -w "$@" \| view -` opens diff view in view which sym links to vim. could also make `| nvim -R -`
`gdt`                  | `git diff-tree --no-commit-id --name-only -r` shows file paths which have changed use like this `gdt HEAD`
`gf`                   | `git fetch`
`gfo`                  | `git fetch origin`
`gfg`                  | `git ls-files \| grep` git find files by grep
TODO: remove --rebase as default from my config
`gpr`                  | `git pull --rebase`
`gprv`                 | `git pull --rebase -v`
TODO: maybe these as default, if I use fixup more?
`gpra`                 | `git pull --rebase --autostash`
`gprav`                | `git pull --rebase --autostash -v`
`gru`                  | `git reset --` read like "git reset unstage" -- is a safe guard, when a file is named master or main it gets confused with branches or commits/tags..
`grs`                  | `git restore`
`grss`                 | `git restore --source`
`grst`                 | `git restore --staged`
`gcount`               | `git shortlog --summary -n` who did how many commits. worthless but nice to look at

merging / rebasing (always write these out but I might want some in the future, now that I now which aliases are used)
`gm`                   | `git merge`
`gma`                  | `git merge --abort`
`gmc`                  | `git merge --continue`
`gms`                  | `git merge --squash`
`gmff`                 | `git merge --ff-only`
`gmom`                 | `git merge origin/$(git_main_branch)` I can pass in more flags with auto completions after, so they could have niche use cases
`gmum`                 | `git merge upstream/$(git_main_branch)`
`grb`                  | `git rebase`
`grba`                 | `git rebase --abort`
`grbc`                 | `git rebase --continue`
`grbi`                 | `git rebase --interactive`
`grbo`                 | `git rebase --onto`
`grbs`                 | `git rebase --skip`
`grbd`                 | `git rebase $(git_develop_branch)`
`grbm`                 | `git rebase $(git_main_branch)`
`grbom`                | `git rebase origin/$(git_main_branch)`
`grbum`                | `git rebase upstream/$(git_main_branch)`

these sound interesting for working on forked repos as contributer (origin points to your fork and upstream to the original)
`ggpull`               | `git pull origin "$(git_current_branch)"`
`ggl`                  | `git pull origin $(current_branch)`
`gluc`                 | `git pull upstream $(git_current_branch)`
`glum`                 | `git pull upstream $(git_main_branch)`
`gpu`                  | `git push upstream`

TODO: use a function for git commit --message to allow `gcm all args will be passed in as message without apostrophes`
the ones not deleted in here I will keeep

