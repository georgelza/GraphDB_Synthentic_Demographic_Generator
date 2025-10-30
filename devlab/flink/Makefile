.DEFAULT_GOAL := help
include ../.env

IMAGE_NAME=apacheflink-base-1.20.2-scala_2.12-java17
VERSION=1.0.0

define HELP

Available commands:

- build: Build this project

endef

export HELP
help:
	@echo "$$HELP"
.PHONY: help

build1202:
	docker build --build-arg REPO_NAME=${REPO_NAME} -t ${REPO_NAME}/${IMAGE_NAME}:${VERSION} --file Dockerfile.1202 .

pull_base:
	cd stage; wget https://repo1.maven.org/maven2/software/amazon/awssdk/bundle/2.31.9/bundle-2.31.9.jar \
    cd stage; wget https://repo1.maven.org/maven2/org/apache/flink/flink-shaded-hadoop-2-uber/2.8.3-10.0/flink-shaded-hadoop-2-uber-2.8.3-10.0.jar \
	cd stage; wget https://repo1.maven.org/maven2/org/apache/paimon/paimon-s3/1.2.0/paimon-s3-1.2.0.jar \
	cd stage; wget https://repo1.maven.org/maven2/org/postgresql/postgresql/42.7.6/postgresql-42.7.6.jar \
	cd stage; wget https://repo1.maven.org/maven2/org/apache/flink/flink-sql-connector-postgres-cdc/3.5.0/flink-sql-connector-postgres-cdc-3.5.0.jar
	
pull1202: pull_base
# 1.20.2
	cd stage; wget https://repo1.maven.org/maven2/org/apache/flink/flink-sql-connector-kafka/3.4.0-1.20/flink-sql-connector-kafka-3.4.0-1.20.jar \
	cd stage; wget https://repo1.maven.org/maven2/org/apache/paimon/paimon-flink-1.20/1.2.0/paimon-flink-1.20-1.2.0.jar \
	cd stage; wget https://repo1.maven.org/maven2/org/apache/flink/flink-sql-json/1.20.2/flink-sql-json-1.20.2.jar \
	cd stage; wget https://repo.maven.apache.org/maven2/org/apache/flink/flink-sql-parquet/1.20.2/flink-sql-parquet-1.20.2.jar \
	cd stage; wget https://repo1.maven.org/maven2/org/apache/flink/flink-json/1.20.2/flink-json-1.20.2.jar
