# Makefile to add version to release tag
```bash
date_version := $(shell date +%Y.%m.%d)
version      := $(shell cat VERSION)
dockerize: clean build
        docker build -t ${image}:latest .
        docker tag ${image}:latest ${image}:$(version)
        docker tag ${image}:latest ${image}:$(version)
```
