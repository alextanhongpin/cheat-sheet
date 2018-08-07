
## Check if your go instances is running 
```bash
ps -ef | grep go
```

## Sort by file size

```bash
$ du -shc * | sort -h
$ du -d 1 -h .
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

## View Running Daemon Process

```bash
$ ps
```

## Kill Running Daemon Process

```bash
$ pkill -INT <PID>
```


## Create your own diary

In a file `log.sh`, execute `chmod u+x`:


```bash
#!/bin/bash
function log() {
	echo "$@" | sed -e "1s/^/$(date -R) /" >> log.txt
}

log $@
```

Then, to create a new entry:

```bash
$ ./log.sh This is a new entry
```

To validate:

```bash
$ cat log.txt
```

Output:

```txt
Tue, 08 May 2018 14:26:11 +0800 this is a new entry
```


## List Storage Size

```bash
$ du -sk

$ sudo lsof -s | awk '$5 == "REG"' | sort -n -r -k 7,7 | head -n 50
```


## Rename extension 

hello.png becomes hello.PNG:
```
for x in *.png; do mv $x ${x%.png}.PNG; done
```

