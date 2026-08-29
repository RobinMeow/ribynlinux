# zsh

## Oh my zsh default keybinds

`CTRL+e` to accept ghost-like zsh-autosuggestions

`CTRL+r` search past commands _(this is default outside of omz,
and I dont use it anyways I have my own fh fn for this)_

### oh my zsh git aliases


keeping these to compare against my own, and pick the better one:
TODO: append --verbose to all my git `add` aliases:
TODO: consider adding -w (ignore whitespace changes) to the git diff aliases
| `g`                    | `git`                                                                                                                           |
| `ga`                   | `git add`                                                                                                                       |
| `gaa`                  | `git add --all`                                                                                                                 |
| `gb`                   | `git branch`                                                                                                                    |
| `gba`                  | `git branch --all`                                                                                                              |
| `gbr`                  | `git branch --remotes`                                                                                                          |
| `gco`                  | `git checkout`                                                                                                                  |
| `gc`                   | `git commit --verbose`                                                                                                          |
| `gca`                  | `git commit --verbose --all`                                                                                                    |
| `gca!`                 | `git commit --verbose --all --amend`                                                                                            |
| `gcan!`                | `git commit --verbose --all --no-edit --amend`                                                                                  |
| `gc!`                  | `git commit --verbose --amend`                                                                                                  |
| `gcn`                  | `git commit --verbose --no-edit`                                                                                                |
| `gcn!`                 | `git commit --verbose --no-edit --amend`                                                                                        |
| `gd`                   | `git diff`                                                                                                                      |
| `gdw`                  | `git diff --word-diff`                                                                                                          |
| `gdca`                 | `git diff --cached` --cached is an alias to --staged (propably the old original)
| `gdcw`                 | `git diff --cached --word-diff`                                                                                                 |
| `gds`                  | `git diff --staged`                                                                                                             |
| `gdup`                 | `git diff @{upstream}` compares everything, unstaged + staged + local commits against my currently locally fetched remote copy
| `gfa`                  | `git fetch --all --tags --prune`                                                                                                |
| `glod`                 | `git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'` iso date
| `glods`                | `git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --date=short` iso day no time
| `glol`                 | `git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'` close to mine, slight differences
| `glola`                | `git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --all` --all shows every branch and makes the --graph more usefull
| `glols`                | `git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --stat` git metrics. much better than my current glast
| `glgp`                 | `git log --stat --patch` --patch shows the git diff, also much better then my current glast
| `gl`                   | `git pull` already had this one shadows with gpl, will shadow again

keeping these for reference. I dont use them currently but I might want to in the future:
| `grt`                  | `cd "$(git rev-parse --show-toplevel \|\| echo .)"` change dir to git root
| `gapa`                 | `git add --patch` interactively stage chunks
| `gau`                  | `git add --update` add only already tracked files
| `gwip`                 | `git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign --message "--wip-- [skip ci]"` `[skip ci]` is apparently built-in in azure devops, gh, gitlab etc..
| `gbs`                  | `git bisect` I dont bisect often enough to need aliases for those. I already have to look up the cli most of the time
| `gbsb`                 | `git bisect bad`                                                                                                                |
| `gbsg`                 | `git bisect good`                                                                                                               |
| `gbsn`                 | `git bisect new`                                                                                                                |
| `gbso`                 | `git bisect old`                                                                                                                |
| `gbsr`                 | `git bisect reset`                                                                                                              |
| `gbss`                 | `git bisect start`                                                                                                              |
| `gbgd`                 | `LANG=C git branch --no-color -vv \| grep ": gone\]" \| cut -c 3- \| awk '"'"'{print $1}'"'"' \| xargs git branch -d` I do this manually, but it is tedious tbh
| `gbgD`                 | `LANG=C git branch --no-color -vv \| grep ": gone\]" \| cut -c 3- \| awk '"'"'{print $1}'"'"' \| xargs git branch -D`           |
| `gbnm`                 | `git branch --no-merged` list branches not merged into current branch
| `ggsup`                | `git branch --set-upstream-to=origin/$(git_current_branch)` dont often have to do this, dont mind doing it manually, the err message shows how to
| `gbg`                  | `LANG=C git branch -vv \| grep ": gone\]"` "git branch gone"
| `gcor`                 | `git checkout --recurse-submodules`                                                                                             |
| `gclean`               | `git clean --interactive -d`                                                                                                    |
| `gcfu`                 | `git commit --fixup` not using yet. when you want to ammend something to a commit to far in the past. on rebasing it will be squashed into the specified commit nice to compare to fix up a branch at the end with rebase --autosquash apparently
| `gdv`                  | `git diff -w "$@" \| view -` opens diff view in view which sym links to vim. could also make `| nvim -R -`
| `gdt`                  | `git diff-tree --no-commit-id --name-only -r` shows file paths which have changed use like this `gdt HEAD`
| `gf`                   | `git fetch`                                                                                                                     |
| `gfo`                  | `git fetch origin`                                                                                                              |
| `gfg`                  | `git ls-files \| grep` git find files by grep
TODO: remove --rebase as default from my config
| `gpr`                  | `git pull --rebase`                                                                                                             |
| `gprv`                 | `git pull --rebase -v`                                                                                                          |
TODO: maybe these as default, if I use fixup more?
| `gpra`                 | `git pull --rebase --autostash`                                                                                                 |
| `gprav`                | `git pull --rebase --autostash -v`                                                                                              |

merging / rebasing (always write these out but I might want some in the future, now that I now which aliases are used)
| `gm`                   | `git merge`                                                                                                                     |
| `gma`                  | `git merge --abort`                                                                                                             |
| `gmc`                  | `git merge --continue`                                                                                                          |
| `gms`                  | `git merge --squash`                                                                                                            |
| `gmff`                 | `git merge --ff-only`                                                                                                           |
| `gmom`                 | `git merge origin/$(git_main_branch)` I can pass in more flags with auto completions after, so they could have niche use cases
| `gmum`                 | `git merge upstream/$(git_main_branch)`                                                                                         |
these sound interesting for working on forked repos as contributer
| `ggpull`               | `git pull origin "$(git_current_branch)"`                                                                                       |
| `ggl`                  | `git pull origin $(current_branch)`                                                                                             |
| `gluc`                 | `git pull upstream $(git_current_branch)`                                                                                       |
| `glum`                 | `git pull upstream $(git_main_branch)`                                                                                          |

TODO: use a function for git commit --message to allow `gcm all args will be passed in as message without apostrophes`
the ones not deleted in here I will keeep

| Alias                  | Command                                                                                                                         |
| :--------------------- | :------------------------------------------------------------------------------------------------------------------------------ |
| `gp`                   | `git push`                                                                                                                      |
| `gpd`                  | `git push --dry-run`                                                                                                            |
| `gpf!`                 | `git push --force`                                                                                                              |
| `ggf`                  | `git push --force origin $(current_branch)`                                                                                     |
| `gpf`                  | On Git >= 2.30: `git push --force-with-lease --force-if-includes`                                                               |
| `gpf`                  | On Git < 2.30: `git push --force-with-lease`                                                                                    |
| `ggfl`                 | `git push --force-with-lease origin $(current_branch)`                                                                          |
| `gpsup`                | `git push --set-upstream origin $(git_current_branch)`                                                                          |
| `gpsupf`               | On Git >= 2.30: `git push --set-upstream origin $(git_current_branch) --force-with-lease --force-if-includes`                   |
| `gpsupf`               | On Git < 2.30: `git push --set-upstream origin $(git_current_branch) --force-with-lease`                                        |
| `gpv`                  | `git push --verbose`                                                                                                            |
| `gpoat`                | `git push origin --all && git push origin --tags`                                                                               |
| `gpod`                 | `git push origin --delete`                                                                                                      |
| `ggpush`               | `git push origin "$(git_current_branch)"`                                                                                       |
| `ggp`                  | `git push origin $(current_branch)`                                                                                             |
| `gpu`                  | `git push upstream`                                                                                                             |
| `grb`                  | `git rebase`                                                                                                                    |
| `grba`                 | `git rebase --abort`                                                                                                            |
| `grbc`                 | `git rebase --continue`                                                                                                         |
| `grbi`                 | `git rebase --interactive`                                                                                                      |
| `grbo`                 | `git rebase --onto`                                                                                                             |
| `grbs`                 | `git rebase --skip`                                                                                                             |
| `grbd`                 | `git rebase $(git_develop_branch)`                                                                                              |
| `grbm`                 | `git rebase $(git_main_branch)`                                                                                                 |
| `grbom`                | `git rebase origin/$(git_main_branch)`                                                                                          |
| `grbum`                | `git rebase upstream/$(git_main_branch)`                                                                                        |
| `grf`                  | `git reflog`                                                                                                                    |
| `gr`                   | `git remote`                                                                                                                    |
| `grv`                  | `git remote --verbose`                                                                                                          |
| `gra`                  | `git remote add`                                                                                                                |
| `grrm`                 | `git remote remove`                                                                                                             |
| `grmv`                 | `git remote rename`                                                                                                             |
| `grset`                | `git remote set-url`                                                                                                            |
| `grup`                 | `git remote update`                                                                                                             |
| `grh`                  | `git reset`                                                                                                                     |
| `gru`                  | `git reset --`                                                                                                                  |
| `grhh`                 | `git reset --hard`                                                                                                              |
| `grhk`                 | `git reset --keep`                                                                                                              |
| `grhs`                 | `git reset --soft`                                                                                                              |
| `gpristine`            | `git reset --hard && git clean --force -dfx`                                                                                    |
| `gwipe`                | `git reset --hard && git clean --force -df`                                                                                     |
| `groh`                 | `git reset origin/$(git_current_branch) --hard`                                                                                 |
| `grs`                  | `git restore`                                                                                                                   |
| `grss`                 | `git restore --source`                                                                                                          |
| `grst`                 | `git restore --staged`                                                                                                          |
| `gunwip`               | `git rev-list --max-count=1 --format="%s" HEAD \| grep -q "--wip--" && git reset HEAD~1`                                        |
| `grev`                 | `git revert`                                                                                                                    |
| `greva`                | `git revert --abort`                                                                                                            |
| `grevc`                | `git revert --continue`                                                                                                         |
| `grm`                  | `git rm`                                                                                                                        |
| `grmc`                 | `git rm --cached`                                                                                                               |
| `gcount`               | `git shortlog --summary -n`                                                                                                     |
| `gsh`                  | `git show`                                                                                                                      |
| `gsps`                 | `git show --pretty=short --show-signature`                                                                                      |
| `gstall`               | `git stash --all`                                                                                                               |
| `gstu`                 | `git stash --include-untracked`                                                                                                 |
| `gstaa`                | `git stash apply`                                                                                                               |
| `gstc`                 | `git stash clear`                                                                                                               |
| `gstd`                 | `git stash drop`                                                                                                                |
| `gstl`                 | `git stash list`                                                                                                                |
| `gstp`                 | `git stash pop`                                                                                                                 |
| `gsta`                 | On Git >= 2.13: `git stash push`                                                                                                |
| `gsta`                 | On Git < 2.13: `git stash save`                                                                                                 |
| `gsts`                 | `git stash show --patch`                                                                                                        |
| `gst`                  | `git status`                                                                                                                    |
| `gss`                  | `git status --short`                                                                                                            |
| `gsb`                  | `git status --short -b`                                                                                                         |
| `gsi`                  | `git submodule init`                                                                                                            |
| `gsu`                  | `git submodule update`                                                                                                          |
| `gsd`                  | `git svn dcommit`                                                                                                               |
| `git-svn-dcommit-push` | `git svn dcommit && git push github $(git_main_branch):svntrunk`                                                                |
| `gsr`                  | `git svn rebase`                                                                                                                |
| `gsw`                  | `git switch`                                                                                                                    |
| `gswc`                 | `git switch -c`                                                                                                                 |
| `gswd`                 | `git switch $(git_develop_branch)`                                                                                              |
| `gswm`                 | `git switch $(git_main_branch)`                                                                                                 |
| `gta`                  | `git tag --annotate`                                                                                                            |
| `gts`                  | `git tag -s`                                                                                                                    |
| `gtv`                  | `git tag \| sort -V`                                                                                                            |
| `gignore`              | `git update-index --assume-unchanged`                                                                                           |
| `gunignore`            | `git update-index --no-assume-unchanged`                                                                                        |
| `gwch`                 | `git log --patch --abbrev-commit --pretty=medium --raw`                                                                         |
| `gwt`                  | `git worktree`                                                                                                                  |
| `gwta`                 | `git worktree add`                                                                                                              |
| `gwtls`                | `git worktree list`                                                                                                             |
| `gwtmv`                | `git worktree move`                                                                                                             |
| `gwtrm`                | `git worktree remove`                                                                                                           |
| `gk`                   | `gitk --all --branches &!`                                                                                                      |
| `gke`                  | `gitk --all $(git log --walk-reflogs --pretty=%h) &!`                                                                           |
| `gtl`                  | `gtl(){ git tag --sort=-v:refname -n --list ${1}\* }; noglob gtl`                                                               |


### Deprecated aliases

These are aliases that have been removed, renamed, or otherwise modified in a way that may, or may not,
receive further support.

| Alias    | Command                                                   | Modification                                          |
| :------- | :-------------------------------------------------------- | :-----------------------------------------------------|
| `gap`    | `git add --patch`                                         | New alias: `gapa`                                     |
| `gcl`    | `git config --list`                                       | New alias: `gcf`                                      |
| `gdt`    | `git difftool`                                            | No replacement                                        |

## Functions

### Current

| `grename <old> <new>`    | Renames branch `<old>` to `<new>`, including on the origin remote                                              |

