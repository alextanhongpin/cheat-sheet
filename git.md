## Undo git reset
Made a mistake once by running `git reset --hard HEAD^`. All my commits are gone. To undo it, its' just run `git reflog`. Git keeps a log of all ref updates (e.g., checkout, reset, commit, merge). You can view it by typing:

```bash
$ git reflog
```

 To undo the commit:
 
```bash
$ git reset 'HEAD@{1}'
```

## Undo last commit


```bash
$ git reset --soft HEAD~1
```

 
# Find Folder Size

```bash
$ du -hs
```
# Clear git history

With `git filter-branch`:

```bash
# pathname is the file to remove, commitHASH is the starting hash to traverse, else it will traverse from the first commit
$ git filter-branch --index-filter 'git rm --cached --ignore-unmatch pathname' commitHASH
```

With `bfg`:

```
# Installation
$ brew cask install java
$ brew install bfg


# Running bf, note it only cleans the commit history
$ bfg --delete-files *.mp4
$ bfg --replace-text passwords.txt
$ bfg --delete-folders .git

# Run this to remove the files
$ git reflog expire --expire=now --all && git gc --prune=now --aggressive
```

When replacing text, create a file called `passwords.txt` for example for mapping the text to another pattern:

```txt
PASSWORD1 # Replace literal string 'PASSWORD1' with '***REMOVED***' (default)
PASSWORD2==>examplePass         # replace with 'examplePass' instead
PASSWORD3==>                    # replace with the empty string
regex:password=\w+==>password=  # Replace, using a regex
```

# Squash commits

```bash
# n is the number of commits previously that you want to squash
$ git rebase -i HEAD~n
$ git rebase -i COMMIT_HASH
```

# Undo your changes

```bash
git reset
git checkout .
git clean -fdx
```

# Remove node_modules if you accidentally checked them in

```bash
$ git rm -r --cached node_modules
```

# Amend your comments

```bash
$ git commit --amend
```

# Cherry-picking

Select a commit from a different branch and add it as a new commit

```bash
$ git cherry-pick YOUR_COMMIT_HASH
```

# Rename branch

```bash
$ git branch -m old-name new-name\
# or if you are in the same directory
$ git branch -m new-name

# Delete the old-name remote branch and push the new-name local branch.
$ git push origin :old-name new-name

# Reset the upstream branch for the new-name local branch. Switch to the branch and then:

$ git push origin -u new-name

```

# Reset local repository branch to be just like remote repository HEAD
```bash 
$ git fetch origin
$ git reset --hard origin/master
$ git clean -f // clean local file
```

# To delete all branches on remote that are already merged

```bash
$ git branch -r --merged | grep -v master | sed 's/origin\///' | xargs -n 1 git push --delete origin
```


# Reset to origin
```bash
$ git fetch --all

# Then, you have two options:
$ git reset --hard origin/master

# OR If you are on some other branch:
$ git reset --hard origin/<branch_name>
```

# Get latest commit of repository
```bash
$ git log -1
```

Output: 
```
commit 706b92ba174729c6a1d761a8566a74f0a0bf8672 (HEAD -> master, origin/master)
Author: alextanhongpin <alextan@seekasia.com>
Date:   Sun Feb 11 23:57:57 2018 +0800

    refactor: improve naming
(END)
```

Press `Q` to exit.

# Get hash from latest commit

```bash
$ git log -1 --pretty=%H
# Output
706b92ba174729c6a1d761a8566a74f0a0bf8672
```


```bash
$ git log -1 --pretty=%h
# Output
706b92b
```

# To get the string

```
$ echo $(git log -1 --pretty=%H)
```

```Makefile
NAME   := acmecorp/foo
TAG    := $$(git log -1 --pretty=%!H(MISSING))
IMG    := ${NAME}:${TAG}
LATEST := ${NAME}:latest

build:
  @docker build -t ${IMG} .
  @docker tag ${IMG} ${LATEST}

push:
  @docker push ${NAME}

login:
  @docker log -u ${DOCKER_USER} -p ${DOCKER_PASS}
```

## Get Tag for Docker Versioning

```
# Tag the repository
$ git tag -a v0.0.1 -m "version v0.0.1"

# Check
$ git describe
v0.0.1

# Perform a commit
$ git commit -am 'chore: do something'

$ git describe
v0.0.1-1-g9ba5c76
```

# Git shortcut
```
alias gst='git status'
alias gcm='git commit -S -am'
alias gco='git checkout'
alias gl='git pull origin'
alias gpom="git pull origin master"
alias gp='git push origin'
alias gd='git diff | mate'
alias gb='git branch'
alias gba='git branch -a'
alias del='git branch -d'
```

## Getting the Github Repository name and owner

```bash
$ git config --get remote.origin.url
$ git ls-remote —get-url

# Use this.
$ git remote get-url origin
# https://github.com/alextanhongpin/go-github-scraper-sg.git

$ basename $(git ls-remote --get-url) .git
$ basename `git remote get-url origin` .git
# go-github-scraper-sg

# View other configs that can be used
$ git config -l
$ git config --get user.name
# alextanhongpin
# Alternative is whoami, but this will return the name of the personal user, not the github username.
```

## Delete branch locally

```bash
$ git push origin --delete branchname
```

## Git commit messages

- feat: A feature that is visible to end users
- fix: A bugfix that is visible for end users
- chore: A change that doesn’t impact end users (e.g .changes to CI Pipeline)
- docs: A change in the README or documentation
- refactor: A change in production code focused on readability, style and / or performance

# clears local deleted branch, fetch all other branches
```
$ git remote update --prune
```

## Remove all git branch except the current one
```bash
$ git branch -D $(git branch)
```

## Sort the branches by last commited date

Find out what are the latest branch in progress.
```bash
$ git fetch --prune
$ git branch —sort=-committerdate
```
## Git commit messages
http://karma-runner.github.io/4.0/dev/git-commit-msg.html
https://365git.tumblr.com/post/3308646748/writing-git-commit-messages
https://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
https://dev.to/maxpou/enhance-your-git-log-with-conventional-commits-3ea4
https://seesparkbox.com/foundry/semantic_commit_messages



## List branches that has been merged
```bash
$ git branch —-merged
```

## List branches that has not been merged
```bash
$ git branch —-no-merged
```

```bash
# cleanup unnecessary files and optimise the local repository (compact your repo)
$ git gc

# prune all unreachable object from the object database
$ git prune

# verifies the connectivity and validity of the objects in the database (validate that your repo is sane)
$ git fsck

# (prune your remote working directory)
$ git remote update --prune 
```

# Rename branch after it is created
- Checkout to the branch you want to rename $ git checkout old-name
- Rename branch name locally: $ git branch -m <new-name>
- Delete old branch from remote: $ git push origin <old-name> <new-name>
- Reset the upstream branch for the new branch name: $ git push origin -u new-name


## Push the commit with the tags automatically
```bash
$ git config --global push.followTags true
```

## Git restore a file to a given commit

```bash
git restore -s <SHA1>     -- <filename>
git restore -s somebranch -- <filename>
```

## Download just a folder from github with subversion (svn)

E.g. To download the folder `https://github.com/alextanhongpin/pkg/tree/master/authheader`:
```bash
# Replace tree/master with trunk
$ svn export https://github.com/alextanhongpin/pkg.git/trunk/authheader
```

You can add an alias to ease the creation of `docker-compose` templates in projects:
```
alias init-db=svn export https://github.com/alextanhongpin/docker-samples/trunk/postgres/docker-compose.yml
```


## Pre commit hooks

Ensure you have a changelog edited in your current branch. Currently there's no way to find out what is the first commit from the current branch, unless I refer to the original branch where it originated from. Usually it will be `main/master`, but probably a better way to do it is to write another script to find the origin.
```sh
#!/bin/bash

if [[ $(git diff develop -- CHANGELOG.md | wc -l) -eq 0 ]];then
	echo "Don't forget to add CHANGELOG.md"
	exit 1;
fi
```

## Git rebase favour current branch

```bash
$ git rebase -X theirs ${branch} # Short option
```
https://stackoverflow.com/questions/2945344/how-do-i-select-a-merge-strategy-for-a-git-rebase

## Git post checkout hook

```bash
$ touch .git/hooks/post-checkout
$ chmod u+x .git/hooks-post-checkout
```

The `.git/hooks/post-checkout`:

```
#!/bin/bash


# The post-checkout hook receives three parameters
# $1: Ref of previous head
# $2: Ref of new head
# $3: Whether this is a file checkout (0) or branch checkout (1).

# This is a file checkout - do nothing
if [ "$3" == "0" ]; then exit; fi

BRANCH_NAME=$(git symbolic-ref --short -- HEAD)
NUM_CHECKOUTS=`git reflog --date=local | grep -o ${BRANCH_NAME} | wc -l`

# If the refs of the previous and new heads are the same
# and the number of checkouts equals one, a new branch has been created
if [ "$1" == "$2" ] && [ ${NUM_CHECKOUTS} -eq 1 ]; then
	echo "new branch created"
else
	echo switched branch ${BRANCH_NAME}
fi

```

## Git checkout a single file from master commit

Useful when you screw up and wants to revert back the original file.
```bash
$ git checkout $(git rev-parse master) -- path-to-file
```
