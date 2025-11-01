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

pullall: flink  

flink:
	docker pull arm64v8/flink:1.20.2-scala_2.12-java17

###### Build Section ######

