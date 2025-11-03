.DEFAULT_GOAL := help
include ../.env

IMAGE_NAME=kafka-connect-custom
VERSION=2.2
BASE_CONNECT_IMAGE=confluentinc/cp-kafka-connect:7.9.1


define HELP

Available commands:

- pull:  Pull our Confluent Kafka Connect base image.
- build: Build this project, after executing pull.

endef

export HELP
help:
	@echo "$$HELP"
.PHONY: help

pull:
	@echo "🔨 Pulling base image for Kafka Connect..."
	docker pull ${BASE_CONNECT_IMAGE}
	@echo "✅ Base Kafka Connect image pulled successfully"

build: pull
	@echo "🔨 Building Kafka Connect custom image..."
	docker build -t ${REPO_NAME}/${IMAGE_NAME}:${VERSION} .

