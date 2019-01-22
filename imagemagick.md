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

## ImageOptim

Use ImageOptim, they have option for progressive jpeg.
```
$ imageoptim '**/*.jpg' '**/*.jpeg'
```

## Modified Workflow


`index.js` for processing metadata:
```js
const args = process.argv.slice(2)
const pathToFile = './' + args[0]

const data = require(pathToFile)
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

fs.writeFileSync(pathToFile.replace('data.json', 'out.json'), JSON.stringify(newdata))
```

`Makefile` for pipeline:

```
.PHONY: process

OUTPUT_WIDTH := 1920

# Create a duplicate folder with the suffix -resize
makedir:
		find . -type d -exec mkdir {}-resize \;

# Search only folders with the suffix -resize, and perform image resize to the targetted output-width
resize:
		find . -type d -not -path "*/*-resize" -not -path "." -exec mogrify -path {}-resize -resize ${OUTPUT_WIDTH} {}/*.jpg \;

# For each folder with the suffix -resize, extract the metadata of the file to json
# You can exec bash for multiple chain function!
metadata:
		find . -type d -path "*/*-resize" -exec sh -c "convert {}/*.jpg[1x1+0+0] json: > {}/data.json" \;

# Process the metadata
process:
		find */*.json -exec node index.js {} \;

# Batch compress the image, but persist the metadata (can be removed with -strip)
# compress:
# 		find . -type d -exec mogrify -path {}-min -filter Triangle -define filter:support=2 -resize ${OUTPUT_WIDTH} -unsharp 0.25x0.25+8+0.065 -dither None -posterize 136 -quality 82 -define jpeg:fancy-upsampling=off -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=1 -define png:exclude-chunk=all -interlace none -colorspace sRGB {}/*.jpg \;
compress:
		find . -type d -path "*/*-resize" -exec imageoptim "{}/*.jpg" "{}/*.jpeg" \;
		
```

## Image compression with ImageOptim

https://imageoptim.com/command-line.html

```
$ open -a ImageOptim .
```
