# yt-dlp

```sh
# download a music mp3 file at best quality
# and set explicit file name, becuase it append the url as suffix by default
yt-dlp -x --audio-format mp3 --audio-quality 0 -o "%(title)s.%(ext)s" "https://www.youtube.com/watch?v=FyzAhqmV6ak"
```
