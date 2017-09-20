
## Check if your go instances is running 
```bash
ps -ef | grep go
```

## Sort by file size

```
du -d 1 -h .
```

If you have gsort installed, 

```
$ brew install coreutils
$ du -d 1 -h . | gsort -h
```
