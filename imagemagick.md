# Convert exif data to json

requires imagemagick to be installed
```
$ convert *.jpg[1x1+0+0] json: > data.json
```


## Cheat 

```Makefile
.PHONY: process

process:
  convert *.jpg[1x1+0+0] json: > data.json
```

`index.js` to get the json file:

```
const data = require('./data.json')
const fs = require('fs')

const newdata = data.map(img => {
  return {
    name: img.image.baseName,
    dof: toNumber(img.image.properties['exif:ApertureValue'], 1),
    // shutterSpeed: toNumber(img.image.properties['exif:ShutterSpeedValue'], 2),
    shutterSpeed: img.image.properties['exif:ShutterSpeedValue'],
    iso: img.image.properties['exif:ISOSpeedRatings']
  }
})

function toNumber (str, decimal) {
  let [num, den] = str.split('/').map(Number)
  return (num / den).toFixed(decimal)
}

console.log(newdata.slice(0, 5))

fs.writeFileSync('processed.json', JSON.stringify(newdata))
```
