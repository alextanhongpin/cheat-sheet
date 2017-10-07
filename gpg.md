## List all the keys

```bash
$ gpg -k
```

## Export the gpg keys

```bash
$ gpg --export -a <YOUR_ID>
```

## Sign your github commit
```bash
$ git config --global user.signingkey ED5CDE14(with my key) 
$ git config --global commit.gpgsign true
$ git config --global gpg.program /usr/local/bin/gpg

# When committing
$ git commit -S -am "feat: ...."
```
