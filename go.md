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
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
```

P.S: Don't forget to source ~/.bash_profile or ~/.zshrc, as follows:
```bash
$ source ~/.bash_profile
```

## copy or link the executables to /usr/local/bin

```bash
$ ln -s $GOPATH/bin/nomad-demo /usr/local/bin/nomad-demo
```


get number of fields in golang
``` 
x is a struct
		v := reflect.ValueOf(x)
		n = v.NumField() 
    ```

## Static Analysis

```bash
$ go build -gcflags "-m -m"
```

## Test Coverage 

```bash
# Create a test coverage output
$ go test -cover -coverprofile cover.out

# View it in html
$ go tool cover -html=cover.out
```

## Makefile for vgo

```bash
# Include all the environment variables from the .env file
include .env

# Export all environment variables for the current scope
export

# Install vgo and dependencies
install:
	@go version && go get -u golang.org/x/vgo

# Setup vendor folder locally
vendor:
	@vgo mod -vendor


# Start local development
start:
	@vgo run server/server.go
```
