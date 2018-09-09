# Squash commits

```bash
# n is the number of commits previously that you want to squash
$ git rebase -i master~n
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
