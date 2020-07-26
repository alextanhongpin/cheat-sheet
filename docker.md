## Run ubuntu to test installations

```bash
$ docker pull ubuntu:latest
$ docker run -it ubuntu
```

## Connecting from container to host service

Say we have a `service-a` running in container, and `postgres` running outside. When `service-a` wants to refer to postgres outside the container, we cannot just call `localhost:5432`. Instead, we call `HDI` (host.docker.internal), which means calling `http://host.docker.internal:5432`.
```
host.docker.internal
```

## Specifying User

For ubuntu/debian:

```Dockerfile
FROM debian:stretch
RUN groupadd -g 999 appuser && \
    useradd -r -u 999 -g appuser appuser
USER appuser
CMD ["cat", "/tmp/secrets.txt"]
```

For alpine:

```Dockerfile
RUN addgroup -g 1000 group && \
    adduser -D -u 1000 -G group user

RUN chown -R user:group /app
USER user
```

Alternative:
```Dockerfile
RUN adduser -S -D -H -h /app appuser
USER appuser
```

`adduser` command:

```bash
BusyBox v1.28.4 (2018-12-06 15:13:21 UTC) multi-call binary.

Usage: adduser [OPTIONS] USER [GROUP]

Create new user, or add USER to GROUP

	-h DIR		Home directory
	-g GECOS	GECOS field
	-s SHELL	Login shell
	-G GRP		Group
	-S		Create a system user
	-D		Don't assign a password
	-H		Don't create home directory
	-u UID		User id
	-k SKEL		Skeleton directory (/etc/skel)
```

`addgroup`:

```bash
BusyBox v1.28.4 (2018-12-06 15:13:21 UTC) multi-call binary.

Usage: addgroup [-g GID] [-S] [USER] GROUP

Add a group or add a user to a group

	-g GID	Group id
	-S	Create a system group
```

Example:

```
$ docker run --user 1001 -v /root/secrets.txt:/tmp/secrets.txt <img>
cat: /tmp/secrets.txt: Permission denied
$ docker run -v /root/secrets.txt:/tmp/secrets.txt <img>
top secret stuff
```
## Remove containers that are months old

The first pipe search for the keyword `months`, you can customize it to filter specific keyword. The second one basically prints out only the third column, which is the image id.
```bash
$ docker rmi $(docker images | awk /months/ | awk '{print $3}')

# Better
# Remove image that are 1 day old
$ docker image prune -a --filter "until=24h" 

# Remove image that are 10 day old
$ docker image prune -a --filter "until=240h" 

$ docker images --format 'table {{.Repository}}\t{{.Tag}}\t{{.ID}}\t{{.CreatedAt}}\t{{.Size}}'
$ docker image prune -a --filter "until=2017-01-04T00:00:00"
```

## Clear all images forcefully

```bash
$ docker rmi -f $(docker images -q)

# A better way
$ docker image prune

# Alternative
$ docker system prune

# Filter images with the latest tag and remove them
$ docker image rm $(docker images *:latest -q)
```

## Get a list of containers

```bash
# -q prints only the container's id
# -a prints all container
$ docker ps -a -q
```

## Remove all containers that exited

```bash
$ docker rm $(docker ps -q -f status=exited) 
```

## My favorite way of removing all stopped docker containers is:

```bash
# passing all the container ids to xargs, docker rm deletes all container
$ docker ps -q |xargs docker rm
```

## Wiping out all containers

```bash
$ docker rm $(docker ps -a -q)
```

## Delete all untagged images

```bash
$ docker rmi $(docker images | grep "<none>" | awk '{print $3}')
```


## Remove dangling images
As the name suggest, a dangling image in Docker is something that is inactive and not being used by any other running images.
The'repo:tag' for dangling images would be shown as <none>:<none> or untagged when the command ‘docker images’ is executed.
Since the dangling images cause wastage of disk space, they need to be deleted periodically to clear up the disk space for efficient functioning of the server.
```bash
$ docker rmi $(docker images -f "dangling=true" -q)
 
# alternative
$ docker image prune
```


Optimize layers
```bash
$ docker history alextanhongpin/web
```

## View iptables
```bash
$ ip route show
$ iptables -L
```
## View network gateway
```bash
$ netstat -r

# IP address is labeled as "inet addr." The subnet is labeled as "Mask."
$ ifconfig

# display the IP address, subnet mask and the default network gateway
$ ipconfig
```

## Clarification on how to stop containers with --restart=always
```
docker stop $(docker ps -a -q) &
docker update --restart=no $(docker ps -a -q) &
systemctl restart docker
```

## Update so that it won't restart
```
docker update --restart=no my-container
```

## Create an alias before pushing to  dockerhub
$ docker tag <image>:<original tag> <image>:<alias>
$ docker push <image>:<alias>

## Sort all the images by size
```
$ docker images --format '{{.Size}}\t{{.ID}}\t{{.Repository}}\t{{.Tag}}' | sed 's/ //' | gsort -h -r
```

## Wipe all images except running ones

```bash
$ docker system prune -af
```

## Get latest hash

```bash
$ git rev-parse HEAD
```

## Versioning with Github Hash

```Makefile
NAME   := acmecorp/foo
# This doesn't work
# TAG    := $$(git log -1 --pretty=%!H(MISSING))

TAG := $(shell git log -1 --pretty=%H)
TAG := $(shell git rev-parse HEAD)

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


## Example with Elastic Container Service

```Make
include .env

# The following variables are loaded from .env file:
# AWS_ACCOUNT_ID=<AWS_ACCOUNT_ID>

NAME := seekasia/idp
TAG := $(shell git log -1 --pretty=%h)
IMG := ${NAME}:${TAG}
LATEST := ${NAME}:latest

AWS_REGION := ap-southeast-1
AWS_IMG := ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${IMG}
AWS_LATEST := ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${LATEST}

version:
	@echo IMG = ${IMG}
	@echo LATEST = ${LATEST}
	@echo AWS_IMG = ${AWS_IMG}
	@echo AWS_LATEST = ${AWS_LATEST}

preview:
	@docker images | grep ${NAME}

build: 
	@docker build --no-cache -t ${IMG} .
	@docker tag ${IMG} ${LATEST}
	@docker tag ${LATEST} ${AWS_IMG}
	@docker tag ${AWS_IMG} ${AWS_LATEST}

tag:
	@docker push ${AWS_IMG}
	@docker push ${AWS_LATEST}
```


## Remove all images created that is specified before the last image


```bash
$ docker rmi -f $(docker images --filter "before=seekasia/idp" --format '{{.ID}}')
```

## Include .env file

```
web:
  env_file:
    - web-variables.env
```

## Getting Docker IP in Makefile

```Make
# This does not work
# DOCKER_IP := $(ipconfig getifaddr en0)

# This works
DOCKER_IP := $(shell ipconfig getifaddr en0)

run:
	echo "posgres://postgres@$(DOCKER_IP)/rust_api"
```

## Git Hash versus Semantic Versioning for Docker images

To keep things simple, use Git Hash (because it is easier to track which commit contains the changes), but apply semantic versioning when deploying to Dockerhub or public repository, a.k.a a production-ready deployment.

## Healthcheck in docker-compose.yml vs Dockerfile

Prefer in `Dockerfile` versus `docker-compose.yml`:

`docker-compose.yml`: 

```yml
healthcheck:
    test: ["CMD", "curl", "-f", "http://localhost:8081/ping"]
    interval: 30s
    timeout: 10s
```

`Dockerfile`:

```Dockerfile
HEALTHCHECK --interval=30s --timeout=10s CMD curl -f http://localhost:8081/ping
```

## Running Docker Bench Security

```bash
$ docker run -it --net host --pid host --userns host --cap-add audit_control \                                                 
    -e DOCKER_CONTENT_TRUST=$DOCKER_CONTENT_TRUST \
    -v /var/lib:/var/lib \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /etc:/etc --label docker_bench_security \
    docker/docker-bench-security
```

## Filter images by name

This will filter all docker images by organization name (in this case, `alextanhongpin`) and return only the id `-q`:
```bash
$ docker images alextanhongpin/* -q
```

## .dockerignore

```.dockerignore
# Ignore all
**
# Except...
!main.go
!internal/
```

## Useful images

- https://github.com/spotify/docker-gc

## Clean System

```bash
$ docker system prune [-a]
WARNING! This will remove:
        - all stopped containers
        - all networks not used by at least one container
        - all dangling images
        - all build cache
```

## Clear 

```
$ docker run --rm -v/:/tmp busybox - rm -rf /tmp
```


## Dockerfile setting build arguments as environment variable

```Dockerfile
ARG NODE_ENV
ENV NODE_ENV $NODE_ENV
```

Passing args when building:

```bash
$ docker build --build-arg REACT_APP_VERSION=${VERSION} -t organization/repository .
```

## Dockerfile build with multiple args

`Dockerfile`:
```
ARG BUILD_DATE
ARG VERSION

ENV BUILD_DATE=$BUILD_DATE
ENV VERSION=$VERSION
```

`Makefile`:

```make
TAG := $(shell git log -1 --pretty=%h)
DATE := $(shell date '+%Y/%m/%d')

docker:
	@docker build --build-arg VERSION=${TAG} --build-arg BUILD_DATE=${DATE} -t ${IMG} .
```

## Dockerfile with go-ethereum

```
FROM golang:1.11.0-alpine3.8 as builder

RUN apk add --no-cache make gcc musl-dev linux-headers git

WORKDIR /go-app/

COPY . ./


RUN GO111MODULE=on CC=gcc go build -mod=vendor -o app

FROM alpine:3.8

WORKDIR /root/

ENV GIN_MODE=release

COPY --from=builder /go-app/app .

CMD ["./app"]
```

```Make
docker:
	@GO111MODULE=on go mod vendor
	cp -r \
  	"${GOPATH}/src/github.com/ethereum/go-ethereum/crypto/secp256k1/libsecp256k1" \
	"vendor/github.com/ethereum/go-ethereum/crypto/secp256k1/"
	@docker build -t example/go-app .
```


## Docker image naming


Other than image:version, we should specify whether it is stage or prod too. Reason being if we push a general latest version in local development, and the production db restarts, it will take the latest development version.

Is this naming good enough?

```
alextanhongpin/go-server:prod-latest
alextanhongpin/go-server:stage-latest
alextanhongpin/go-server:test-latest
```


## Dynamic Arg in container

Specifying image version dynamically:
```
ARG MYAPP_IMAGE=myorg/myapp:latest
FROM $MYAPP_IMAGE
...
Then if you want to use a different image/tag, you can provide it at runtime:

docker build -t container_tag --build-arg MYAPP_IMAGE=localimage:latest .
```
