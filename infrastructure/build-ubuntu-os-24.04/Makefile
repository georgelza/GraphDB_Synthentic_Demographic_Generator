.DEFAULT_GOAL := help
include ../.env

IMAGE_NAME=ubuntu-24.04
VERSION=1.0.1

define HELP

Available commands:

- build: Build this project

endef

export HELP
help:
	@echo "$$HELP"
.PHONY: help


build:  
	docker build --build-arg REPO_NAME=${REPO_NAME} -t ${REPO_NAME}/${IMAGE_NAME}:${VERSION} . --no-cache 

