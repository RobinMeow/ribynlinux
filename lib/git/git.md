# git

store creds in plaintext for badly configured remotes.
`git config --global credential.helper store`
[source](https://stackoverflow.com/questions/35942754/how-can-i-save-username-and-password-in-git)

[conditional include parent dir git](https://stackoverflow.com/questions/21307793/set-git-config-values-for-all-child-folders/48088291#48088291)

```gitconfig
[includeIf "gitdir:~/toplevelFolder1/"]
    path = ~/topLevelFolder1/.gitconfig_include
```

# temporarly disable git aliases to practise muscle memory on git aliases and functions

```gitconfig
[alias]
	ss = status --short --untracked-files=all
	sw = switch
	l = log -7 --graph --pretty=format:\"%C(auto)%h%d%Creset %s %C(green)%cn%Creset %C(cyan)(%cr)%Creset\"
	last = l -1
	co = checkout
	c = commit --verbose
	b = branch
	p = push
	pl = pull
	aa = add --all
	aac = "!git add --all && git commit --verbose"
	aaca = "!git add --all && git commit --amend --verbose"
	aacane = "!git add --all && git commit --amend --no-edit --verbose"
	aacp = "!git add --all && git commit --verbose && git push"
	aacpf = "!git add --all && git commit --verbose && git push --force-with-lease"
	aacapf = "!git add --all && git commit --amend --verbose && git push --force-with-lease"
	aacanep = "!git add --all && git commit --amend --no-edit --verbose && git push"
	aacanepf = "!git add --all && git commit --amend --no-edit --verbose && git push --force-with-lease"
	wt = worktree
	fpa = fetch --prune --all
	pf = push --force-with-lease
	ca = commit --amend --verbose
	cane = commit --amend --no-edit --verbose
	canep = "!git commit --amend --no-edit && git push"
	canepf = "!git commit --amend --no-edit && git push --force-with-lease"
	cp = "!git commit --verbose && git push"
	smfe = submodule foreach
	skipped = !git ls-files -v | grep \"^S\"
	skip = update-index --skip-worktree
	no-skip = update-index --no-skip-worktree
	crime = log --all --numstat --date=short --pretty=format:--%h--%ad--%aN
	bvvawkgone = "!git branch --verbose --verbose | awk '/: gone]/ {print $1}'"
```
