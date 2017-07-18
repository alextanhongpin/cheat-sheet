## Compress the file but exclude node modules

```bash
tar -czvf archive.tar.gz --exclude=./node_modules .
```


## To compress

`zip -r archive_name.zip folder_to_compress`

## To extract

`unzip archive_name.zip`


## If you want to make a zip without those invisible Mac resource files such as “_MACOSX” or “._Filename” and .ds store files, use the “-X” option in the command so:

`zip -r -X archive_name.zip folder_to_compress`
