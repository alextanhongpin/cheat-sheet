## Building binary
Building a binary in the folder `bin` with the name `application` for linux


```bash
$ env GOOS=linux GOARCH=arm go build -v -o bin/application .
```

## Setting up gopath
For *nix system, look where `go` is installed, executing following command:

```bash
$ which go
```
which output let's say:

```bash
$ /usr/local/go/bin/go
```
then add following entries in `~/.bash_profile` or in `~/.zshrc`:

```bash
export GOROOT=/usr/local/go
export GOPATH=$GOROOT/src //your-go-workspace
export GOBIN=$GOROOT/bin //where go-generate-executable-binaries

PATH=$PATH:$GOPATH:$GOBIN

export PATH
```

P.S: Don't forget to source ~/.bash_profile or ~/.zshrc, as follows:
```bash
$ source ~/.bash_profile
```
