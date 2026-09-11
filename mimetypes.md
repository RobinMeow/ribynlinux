# mimetypes

```sh
# query available apps to set as default for application/pdf
grep -rl "application/pdf" /usr/share/applications/ ~/.local/share/applications/
# note that not all apps are listed. e.g. firefox doesnt register itself
# as pdf app, but it can read and render them very well.
```
