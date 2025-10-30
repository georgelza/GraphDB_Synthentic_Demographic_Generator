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

buildall: pullsource buildos buildopenjdk8 buildhive

flink:
	docker pull arm64v8/flink:1.20.2-scala_2.12-java17

pullsource: common hive  

common:
	cd build-hdfs-openjdk8/base; mkdir stage; cd stage; wget https://downloads.apache.org/hadoop/common/hadoop-3.3.5/hadoop-3.3.5-aarch64.tar.gz

hive:
# hive 3.1.3 is located in the Archive section now, to go on top of Hadoop 3.3.5
	cd build-hive-openjdk8/basehive; cd stage; wget https://archive.apache.org/dist/hive/hive-3.1.3/apache-hive-3.1.3-bin.tar.gz
	cd build-hive-openjdk8/basehive; cd stage; wget http://www.congiu.net/hive-json-serde/1.3.8/cdh5/json-serde-1.3.8-jar-with-dependencies.jar 
	cd build-hive-openjdk8/basehive; cd stage; wget https://jdbc.postgresql.org/download/postgresql-42.7.6.jar


###### Build Section ######

# Base images with some add on's - Flink 1.20.1 - Java 17

buildos:
	cd ./build-ubuntu-os-24.04; make build

# Extend Ubuntu 20.04 OS + OpenJDK 8
buildopenjdk8:
	cd ./build-ubuntu-os-openjdk8; make build

# Now add Hadoop onto the Ubuntu 20.04 / openjdk8 base followed by Hive 3.3.4
buildhive:
	cd build-hive-openjdk8; make base
	cd build-hive-openjdk8; make basehive