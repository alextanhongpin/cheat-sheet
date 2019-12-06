## Base64 and MD5 with no newline

Useful for basic authorization header. Also take a look at htpasswd.

```bash
$ echo -n john:123456 | md5
$ echo -n john:123456 | base64
$ echo -n john:123456 | shasum -a 256

$ openssl rand -base64 32
```
## Clearing clipboard

Weird issue when pasting in vim due to the append nature (?) of copy paste.

```bash
echo | pbcopy
pbpaste
```
## User

```
$ id -u
$ id -un
$ id -g
$ id -gn
```

## Generate random passwords

```
$ openssl rand -base64 32
kVehTPyjvy0OXZ5AAYN4nsRHDFlDN/ciP0LPLHadsVI=

$ date | md5
93f685a396de775f267aa999f9a1b60e

$ echo "hello" | md5
b1946ac92492d2347c6235b4d2611184
```

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

## Loop for each directory

```bash
for D in `find . -type d`                                                                                                    
	do echo $D
done

# or
for D in */; do echo $D; done
```

## alias for tree

Print current directory layout:

```
alias tree='find . -print | sed -e '\''s;[^/]*/;|____;g;s;____|; |;g'\'
```

## Find and replace all file extension

The example below will find all files with `*.JPG` extension and rename it to `*.jpg`.
```bash
$ find . -path *.JPG -exec sh -c 'mv "$1" "${1%.JPG}.jpg"' _ {}  \;
```

## Bcrypt Password

```bash
$ htpasswd -bnBC 10 "" your_password | tr -d ':\n' | sed 's/$2y/$2a/'
```
