# Convert exif data to json

requires imagemagick to be installed
```
$ convert *.jpg[1x1+0+0] json: > data.json
```


# Image Compression Workflow 

```Makefile
.PHONY: process

OUTPUT_PATH := ./Home-Copy
OUTPUT_WIDTH := 1920
INPUT_PATH := ./Home/*.jpg

# Extract the metadata of the file to json
metadata:
		convert ${OUTPUT_PATH}/*.jpg[1x1+0+0] json: > metadata.json
 
# Batch compress the image, but persist the metadata (can be removed with -strip)
compress:
		@mogrify -path ${OUTPUT_PATH} -filter Triangle -define filter:support=2 -resize ${OUTPUT_WIDTH} -unsharp 0.25x0.25+8+0.065 -dither None -posterize 136 -quality 82 -define jpeg:fancy-upsampling=off -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=1 -define png:exclude-chunk=all -interlace none -colorspace sRGB ${INPUT_PATH}

convert:
		convert ${PWD}/Home/DSCF3619.jpg -resize 1920 -quality 85 output.jpg
```

`index.js` to get the json file:

```
const data = require('./data.json')
const fs = require('fs')

const newdata = data.map(img => {
  return {
    name: img.image.baseName,
    dof: toNumber(img.image.properties['exif:ApertureValue'], 1),
    shutterSpeed: img.image.properties['exif:ShutterSpeedValue'],
    iso: parseInt(img.image.properties['exif:ISOSpeedRatings'], 10),
    width: img.image.pageGeometry.width,
    height: img.image.pageGeometry.height
  }
})

function toNumber (str, decimal) {
  let [num, den] = str.split('/').map(Number)
  return (num / den).toFixed(decimal)
}

console.log(newdata.slice(0, 5))

fs.writeFileSync('processed.json', JSON.stringify(newdata))

```
