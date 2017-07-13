
Create gif from imovie. 

Link (here)[https://gist.github.com/dergachev/4627207]

```bash
$ ffmpeg -i finanz_demo.mov -s 1440x900 -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=3 --delay=3 > finanz.gif
```
