# Install here


https://ffmpeg.martin-riedl.de/

Installing with homebrew leaves the ffmpeg without many capabilities:

```
ffmpeg -filters | grep drawtext
```

```
export

scroll:
	-rm output.mp4
	#ffmpeg -loop 1 -t 2 -i output.png -vf "crop=w=2880:h=ih:x='(iw-1920)*t/240':y=0" -g 1 -r 25 -pix_fmt yuv420p output.mp4
	ffmpeg -loop 1 -i output.png -f lavfi -i color=c=black:s=1920x1080 -filter_complex \
	"[0:v]scale=-2:720[img]; \
	 [1:v][img]overlay=x='W-(w+w)*t/240':y=(H-h)/2[v]" \
	-map "[v]" -t 240 -pix_fmt yuv420p output.mp4
	open output.mp4

# Merge images horizontally with padding 40px
montage:
	magick *.jpg *.png -resize x1080 +smush 40 -background none -transparent white output.png
	open output.png
```
