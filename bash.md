
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


## Setting default value for environment variables
```
$ MONGODB_ADMIN_USER:-"admin"
```


## xargs with multiple commands

```bash
$ cat a.txt | xargs -I % sh -c 'command1; command2; ...'
```

## find with multiple command

```bash
$ find . -exec echo {} \; -exec printf {} \;
```
