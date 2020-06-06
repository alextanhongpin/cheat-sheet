## Optional include

```Make
-include .env
```

## Example makefile for grpc

```makefile

PRIVATE_SERVER_PORT=:8081
PRIVATE_GATEWAY_PORT=:9091

PUBLIC_SERVER_PORT=:8090
PUBLIC_GATEWAY_PORT=:9090

up:
	docker-compose -f docker-compose/production/docker-compose.yml up -d

down:
	docker-compose -f docker-compose/production/docker-compose.yml down

build-server:
	docker build -f server/Dockerfile -t alextanhongpin/go-grpc-event-server .

build-gateway:
	docker build -f gateway/Dockerfile -t alextanhongpin/go-grpc-event-gateway .

# setup
setup:
	brew install glide
	brew install protobuf
	go get -u -v github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway
	go get -u -v github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger
	go get -u -v github.com/golang/protobuf/protoc-gen-go
	go get -u -v github.com/favadi/protoc-go-inject-tag


# stub generates the grpc server file from the proto file
stub:
	find . -name "*.proto" -exec \
	protoc -I/usr/local/include -I. \
	-I${GOPATH}/src \
	-I${GOPATH}/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
	--go_out=plugins=grpc:. \
	--proto_path=. "{}" \;

# proto/**/*.proto

# Setting proto path in order to import them (cannot be absolute)
# -I/--proto_path=. \

# gw generates the grpc gateway file from the proto file
gw:
	find . -name "*.proto" -exec \
	protoc -I/usr/local/include -I. \
	-I${GOPATH}/src \
	-I${GOPATH}/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
	--grpc-gateway_out=logtostderr=true:. "{}" \;
# proto/**/.proto

# tag generates the inline tag for structs
tag:
	find . -name "*.pb.go" -exec protoc-go-inject-tag -input "{}" \;


# serve-grpc serves the grpc server at the specified port
serve-private:
	go run pkg/server-private/main.go -port ${PRIVATE_SERVER_PORT}


serve-public:
	go run pkg/server-public/main.go -port ${PUBLIC_SERVER_PORT}


# serve-gateway serves the grpc gateway at the specified port while listening to the server endpoint
serve-gateway-private:
	go run pkg/gateway-private/main.go -port ${PRIVATE_GATEWAY_PORT} -addr localhost${PRIVATE_SERVER_PORT} -jwks_uri "" -auth0_aud -auth0_iss

serve-gateway-public:
	go run pkg/gateway-public/main.go -port ${PUBLIC_GATEWAY_PORT} -addr localhost${PUBLIC_SERVER_PORT}


# ===============
# API Endpoints #
# ===============

post:
	curl -X POST -d '{"data": {"name":"hello", "start_date": 1505254724582, "uri": "test_uri"} }' http://localhost:9090/v1/events


get-public-all:
	curl http://localhost:9090/public/v1/events


get-all:
	curl http://localhost:9090/v1/events


get-one:
	curl http://localhost:9090/v1/events/59b6bbc47270e76be612ee81

delete:
	curl -X DELETE http://localhost:9090/v1/events/59b6babf7270e76be612ee5b

update:
	curl -X PATCH -d '{"data": {"name": "123", "uri": "hellp", "tags": ["1", "2"]}}' http://localhost:9090/v1/events/59b6baf47270e76be612ee61 

update-2:
	curl -X PATCH -d '{"data": {"uri": "cool kid"}}' http://localhost:9090/v1/events/59b6baf47270e76be612ee61 

push-server:
	docker push alextanhongpin/go-grpc-event-server

push-gateway:
	docker push alextanhongpin/go-grpc-event-gateway


compile:
	GOOS=linux GOARCH=arm CGO_ENABLED=0 go build -o app main.go
```

## Example makefile for building docker 

```makefile
VERSION=0.0.2

public-server:
	docker build -f pkg/server-public/Dockerfile -t alextanhongpin/public-event-server:0.0.1-beta .
	docker push alextanhongpin/public-event-server:${VERSION}

private-server:
	docker build -f pkg/server-private/Dockerfile -t alextanhongpin/private-event-server:0.0.1-beta .
	docker push alextanhongpin/private-event-server:${VERSION}

public-gateway:
	docker build -f pkg/gateway-public/Dockerfile -t alextanhongpin/public-event-gateway:0.0.1-beta .
	docker push alextanhongpin/public-event-gateway:${VERSION}

private-gateway:
	docker build -f pkg/gateway-private/Dockerfile -t alextanhongpin/private-event-gateway:0.0.1-beta .
	docker push alextanhongpin/private-event-gateway:${VERSION}


push-all:
	docker push alextanhongpin/public-event-server:${VERSION} && \
	docker push alextanhongpin/private-event-server:${VERSION} && \
	docker push alextanhongpin/public-event-gateway:${VERSION} && \
	docker push alextanhongpin/private-event-gateway:${VERSION}


# Does a local build

local-gateway:
	@echo "building local gateway"
	cd pkg/gateway-public/ && \
	CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app && \
	docker build -f Dockerfile.production -t alextanhongpin/public-event-gateway:${VERSION} . && \
	rm -rf app

	cd pkg/gateway-private/ && \
	CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app && \
	docker build -f Dockerfile.production -t alextanhongpin/private-event-gateway:${VERSION} . && \
	rm -rf app

local:
	@echo "Building public event server"
	cd pkg/server-public/ && \
	CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app && \
	docker build -f Dockerfile.production -t alextanhongpin/public-event-server:${VERSION} . && \
	rm -rf app
	@echo "Done building public event server"

	@echo "Building privte event server"
	cd pkg/server-private/ && \
	CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app && \
	docker build -f Dockerfile.production -t alextanhongpin/private-event-server:${VERSION} . && \
	rm -rf app
	@echo "Done building private server"
```
  
## Include .env file

```makefile
include .env

greet:
  @echo ${YOUR_VAR_IN_ENV}
```

## Simply Expanded Variables `:=`

```Makefile
FOO = foo

# BAR will first take the value FOO=foo, but will eventually
# be overwritten by the FOO=foo2
BAR = ${FOO} bar

# BAR2 will take the immutable value of FOO
BAR2 := ${FOO} bar
FOO = foo2

scream:
	@echo ${BAR} # outputs foo2 bar
	@echo ${BAR2} # outputs foo bar
```


# Include Environment Variables and export all

This will include all environment variables from the `.env` file and export it directly:

```makefile
include .env
export
```

## Ensure Variables are set and is not empty string

```makefile
HELLO_WORLD=""

# Does not handle "" empty string
scream: check-env
	@echo ${HELLO_WORLD}

# Better
cry: guard-HELLO_WORLD
	@echo ${HELLO_WORLD}

check-env:
ifndef HELLO_WORLD
  $(error HELLO_WORLD is undefined)
endif

guard-%:
	@if [ -n '${${*}}' ]; then \
		echo 'Environment variable $* not set'; \
		exit 1; \
	fi
```

## Bash Files ensure variables are set and not empty string

```bash
set -e #  
set -u # Prints a message stderr when it tries to expand a variable that is not set
set -x # Prints each command in a script to stderr before running it
set -o pipefail # Pipeline fails on the first command which fails

HELLO_WORLD=something

echo $HELLO_WORLD
```

Or:

```bash
# Option one - Verbose version
HI="hello"

if [ -z "$HI" ]; then
    echo "Need to set HI"
    exit 1
fi

echo $HI

# Option 2 - One liner
HELLO="world"
echo "${HELLO:?Need to set HELLO}"
```


## Chaining Commands

```
action1:
    echo action1
action2:
    echo action2
action3:
    echo action3
    
action: action1 action2 action3
```

## Default command

Running the `make` without the command will trigger the first command available. So it's good to place a default command at the top of the file that prints information related to the makefile.
```
default:
	@echo "Maybe print help or list of commands available"
```

## Help section

```
define HELP
usage: make (sub-commands ...)

Welcome to the APPNAME CLI.

commands:
	install  Install vgo and dependencies.
	vendor   Download dependencies into `vendor` folder.
	start    Start local golang server.
endef

# Needs the quotes for newlines
default:
	@echo "$$HELP"
```


## Ensure Variables are set

```
HELLO = hello world
CAR = car

guard-%:
	@if [ "${${*}}" == "" ]; then \
		echo "Environment variable $* not set"; \
		exit 1; \
	fi

scream: guard-HELLO guard-CAR
	@echo ${HELLO} ${CAR}

```

## Self-documenting Makefiles

```
.PHONY: help
help:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

vendor: ## Vendor the application
	@echo vendoring...
```
Alternative:
```
PROJECTNAME=$(shell basename "$(PWD)")
GOFILES=$(wildcard *.go)

.PHONY: help
all: help
help: Makefile
	@echo
	@echo " Choose a command run in "$(PROJECTNAME)":"
	@echo
	@sed -n 's/^##//p' $< | column -t -s ':' |  sed -e 's/^/ /'
	@echo

```


My own version:

```bash
# Without color
# Explanation - find the row that starts with ##, with the ":" as separator, then trim away the ##, and pretty print them.
$ awk -F ":" '/^##/{sub("^##","", $0); printf("%s\t%s\n", $1, $2)}' Makefile

## With color, but the column is uneven...
$ awk '/^##/{sub("^##", "", $0);split($0, a, ":");printf("\033[0;32m%s\033[0m\t%s\n", a[1], a[2])}' Makefile


# Simple. Find the line matching ## at the beginning, then replace the ## with empty string
# Split the text by ":" into individual columns, but no coloring...
$ awk '/^##/{sub("##","", $0); print $0}' Makefile | column -t -s ':'

# Other alternative...
$ awk -F ':' '/^##/{sub("##","", $0); printf("\033[0;32m%s\033[0m:%s\n", $1, $2);}' Makefile | column -t -s ':'
$ awk '/^##/{sub("##","", $0); print $0}' Makefile | column -t -s ':' | awk -F "\t" '{printf("%s:%s\n", $1, $2)}'
```


Usage in Makefile (note the $$ for params):

```bash
PROJECTNAME := $(shell basename $(PWD))

.PHONY: help
all: help
help: Makefile
	@echo
	@echo " Choose a command to run in "$(PROJECTNAME)":"
	@echo
	@awk -F ':' '/^##/{sub("##","", $$0); printf("\033[0;32m%s\033[0m:%s\n", $$1, $$2);}' Makefile | column -t -s ':'
	@echo
```
## Useful Variables

```make
VERSION=0.1.0

COMMIT=$(shell git rev-parse HEAD)
BRANCH=$(shell git rev-parse --abbrev-ref HEAD)

CURRENT_DIR=$(shell pwd)
BUILD_DIR=$(CURRENT_DIR)/build

BINARY=your-go-binary

COLOR="\033[32;1m"
ENDCOLOR="\033[0m"
```

## Colors

```bash
export const Reset = "\x1b[0m"
export const Bright = "\x1b[1m"
export const Dim = "\x1b[2m"
export const Underscore = "\x1b[4m"
export const Blink = "\x1b[5m"
export const Reverse = "\x1b[7m"
export const Hidden = "\x1b[8m"

export const FgBlack = "\x1b[30m"
export const FgRed = "\x1b[31m"
export const FgGreen = "\x1b[32m"
export const FgYellow = "\x1b[33m"
export const FgBlue = "\x1b[34m"
export const FgMagenta = "\x1b[35m"
export const FgCyan = "\x1b[36m"
export const FgWhite = "\x1b[37m"

export const BgBlack = "\x1b[40m"
export const BgRed = "\x1b[41m"
export const BgGreen = "\x1b[42m"
export const BgYellow = "\x1b[43m"
export const BgBlue = "\x1b[44m"
export const BgMagenta = "\x1b[45m"
export const BgCyan = "\x1b[46m"
export const BgWhite = "\x1b[47m"
```


## Conditional Makefile environment

Let's say you have this in your root directory:

```bash
.env
.env.development
```

```Makefile
ifeq ($(MAKE_ENV),)
	MAKE_ENV := development
endif
# Include the default.
-include .env
# Overwrite
-include .env.$(MAKE_ENV)
export
```

Now you can run with either:
```bash
$ make command
# or
$ MAKE_ENV=development make command
```

If you do not want to add the `MAKE_ENV` env before calling the command, do this:

```makefile
dev:
	@MAKE_ENV=development $(MAKE) command
pro:
	@MAKE_ENV=production $(MAKE) command
```

## Delete all files in directory except hidden ones

```
$ rm -rf *
```

## Match command

```makefile
deploy-%:
	echo deploying to $* now
```

## Safe Env

```makefile
NAME = car
-include .env
ifeq ($(ENV),)
	ENV := development
endif
-include .env.$(ENV)
export

# To override just a single environment variable inline.
deploy:
	@export NAME=car; \
	echo $$NAME; \
	echo ${NAME}
	echo ${env} ${A}

deploy-staging: .env.staging
	echo ${A}
	$(MAKE) deploy ENV=staging
	
deploy-production: .env.production
	echo ${A}
	$(MAKE) deploy ENV=production

# ifeq ($(ENV),$*)
#         @echo ${ENV} ${A}
# else
#         $(error not equal for $(ENV) and $*)
# endif
```

## Improvisation

```makefile
ifeq ($(ENV),)
	ENV := development
endif
-include .env
-include .env.$(ENV)
export

# To override just a single environment variable inline.
deploy:
	@echo ${A}

# make deploy-staging
# make deploy-production
deploy-%: .env.%
	@$(MAKE) deploy ENV=$*
```

## Getting version bash script

```bash
set version 

#!/bin/sh

set -e

# Take only the first 7 characters as the version.
export VERSION=$(echo $CI_COMMIT_ID | cut -c1-7)
export WORKDIR=deploy
echo $VERSION > $WORKDIR/VERSION

# Create a copy of the old configuration.
mv $WORKDIR/Dockerrun.aws.json $WORKDIR/Dockerrun.aws.json.copy

# Set the latest version.
cat $WORKDIR/Dockerrun.aws.json.copy | jq --arg VERSION "$VERSION" ".containerDefinitions[].image"="\"yourcontainername:$VERSION\"" > $WORKDIR/Dockerrun.aws.json

cat $WORKDIR/Dockerrun.aws.json | grep image
```


## Check env equal or error
 
```Makefile
.PHONY: deploy check-env

deploy: check-env
	...

other-thing-that-needs-env: check-env
	...

check-env:
ifndef ENV
	$(error ENV is undefined)
endif
```

## Better way to set default environment variables

```diff bash
- ifeq ($(ENV),)
-         ENV := development
- endif 
+ ENV ?= development
```

## Error handling
```Makefile
command:
	@$(error bad request)	
```

## Test exists

```bash
test -f myApp || echo File does not exist
test ! -f myApp && echo File does not exist
```

## Execute once

Using transient directory to store state:
```Makefile
# Usage: greet: $(TS)/db.done
$(TS)/%.done:
	mkdir -p $(dir $@)
	touch $@
	$(MAKE) $*
```
