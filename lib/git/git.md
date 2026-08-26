# git

store creds in plaintext for badly configured remotes.
`git config --global credential.helper store`
[source](https://stackoverflow.com/questions/35942754/how-can-i-save-username-and-password-in-git)

[conditional include parent dir git](https://stackoverflow.com/questions/21307793/set-git-config-values-for-all-child-folders/48088291#48088291)

```gitconfig
[includeIf "gitdir:~/toplevelFolder1/"]
    path = ~/topLevelFolder1/.gitconfig_include
```
