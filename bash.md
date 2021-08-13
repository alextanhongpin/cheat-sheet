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

The example below will find all files with `*.JPG` extension and rename it to `*.jpg`. NOTE this will not work in Makefile:
```bash
$ find . -path *.JPG -exec sh -c 'mv "$1" "${1%.JPG}.jpg"' _ {}  \;
```

## Convert .MOV/.mov file to .MP4
```bash
$ ffmpeg -i in.MOV -vcodec copy -acodec copy out.mp4
```

Find all files with the `.MOV` extension and convert them to `.MP4`. This will not work in Makefile:

```bash
$ find . -name '*.MOV' -exec sh -c 'ffmpeg -i "$1" -vcodec copy -acodec copy "${1%.MOV}.mp4"' _ {} \;
```

## Bcrypt Password

```bash
$ htpasswd -bnBC 10 "" your_password | tr -d ':\n' | sed 's/$2y/$2a/'
```

## Useful bash color

```
# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Underline
UBlack='\033[4;30m'       # Black
URed='\033[4;31m'         # Red
UGreen='\033[4;32m'       # Green
UYellow='\033[4;33m'      # Yellow
UBlue='\033[4;34m'        # Blue
UPurple='\033[4;35m'      # Purple
UCyan='\033[4;36m'        # Cyan
UWhite='\033[4;37m'       # White

# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White

# High Intensity
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White

# Bold High Intensity
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\033[0;100m'   # Black
On_IRed='\033[0;101m'     # Red
On_IGreen='\033[0;102m'   # Green
On_IYellow='\033[0;103m'  # Yellow
On_IBlue='\033[0;104m'    # Blue
On_IPurple='\033[0;105m'  # Purple
On_ICyan='\033[0;106m'    # Cyan
On_IWhite='\033[0;107m'   # White
```



# Find the last file that changes the file 

A naive way would be to check `HEAD~1`, but the previous commit does not necessarily change that given file.
```bash
$ find data/swagger -name "*.json" -exec sh -c 'git show $(git log --follow -n1 --pretty=format:"%h" -- {} | tail -n 1):{} > tmp/{}' \;
``

## Copy file only if not exists

```bash
$ cp -n .env.sample .env
```

Alternatively make use of makefile:

```bash
.env:
  cp .env.sample .env
```

## Edit long commands in vim

Opens an editor to allow you to type your command. When you exist (:w), the command will be run:
```bash
$ fc
```

# Hearbeat to avoid timeout error during long deployment

```
function prevent_codeship_timeout() { ( for i in {1..5}; do echo "Preventing Codeship timeout by echoing every 300 seconds"; sleep 300; done ) & local pid=$!; trap 'kill ${pid}' SIGINT SIGTERM EXIT; }
prevent_codeship_timeout &
```

## Flatten all directory files to root

```bash
$ find [DIRECTORY] -mindepth 2 -type f -exec mv -i '{}' [DIRECTORY] ';'
```

## Mass create directory from filename

```bash
$ find . -type f -exec sh -c 'mkdir -p "${1%.txt}"' _ {} \;
```
