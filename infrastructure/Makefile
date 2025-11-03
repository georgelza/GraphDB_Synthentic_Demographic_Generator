.DEFAULT_GOAL := help

define HELP

Available commands:

- pullall: Pull all source images.

- buildall: Build all images.

endef

export HELP
help:
	@echo "$$HELP"
.PHONY: help

build: pullall 
	cd connect && make build
.PHONY: pullall

#pullall: confluent neo4j flink

pullall: confluent neo4j
.PHONY: pullall

confluent:
	docker pull confluentinc/cp-kafka:7.9.1
	docker pull confluentinc/cp-schema-registry:7.9.1
	docker pull confluentinc/cp-enterprise-control-center:7.9.1
	docker pull confluentinc/cp-kafka-connect-base:7.9.1
.PHONY: confluent

neo4j:
	docker pull neo4j:latest
#	docker pull neo4j:5.26.15-community
.PHONY: neo4j


flink:
	docker pull arm64v8/flink:1.20.2-scala_2.12-java17
.PHONY: flink


