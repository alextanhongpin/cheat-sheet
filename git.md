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
