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

build: pullall buildall 

pullall: flink 

buildall:  buildflinkbase  

flink:
	docker pull arm64v8/flink:1.20.2-scala_2.12-java17

###### Build Section ######

# Base images with some add on's - Flink 1.20.1 - Java 17
buildflinkbase:
	cd build-flink-base-1.20.2; make build
