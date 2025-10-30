
.DEFAULT_GOAL := help
include .env

define HELP

Available commands:

- build-images: Build required Docker images (Kafka Connect)
- run: Build images and start core services (Kafka, Neo4j, MongoDB, PostgreSQL, Redis)
- run-full: Build images and start all services (includes Flink, Minio)
- createtopics: Create Kafka topics
- cypher: Access Neo4j Cypher shell
- constraints: Apply Neo4j constraints

- stop: Stop the project
- start: Start a stopped project
- down: Tear down the project, clean directories
- ps: Show all running containers

- logs: Show/tail logs
- logsf: Stream logs
- watch: Watch logs


endef

export HELP
help:
	@echo "$$HELP"
.PHONY: help


#	docker rmi $(docker images -q --filter "dangling=true")

build-images:
	@echo "🔨 Building required Docker images..."
	@cd ../infrastructure/connect && make build
	@echo "✅ Images built successfully"
.PHONY: build-images

build-images-full:
	@echo "🔨 Building Kafka Connect image..."
	@cd ../infrastructure/connect && make build
	@echo "🔨 Building Flink image (1.20.2)..."
	@cd flink && make pull1202 && make build1202
	@echo "✅ All images built successfully"
.PHONY: build-images-full

run: build-images
	@echo "🚀 Starting core services (Kafka, Neo4j, MongoDB, PostgreSQL, Redis)..."
	docker compose -f docker-compose.yml -p graph up -d \
		broker schema-registry control-center connect \
		neo4j mongodb postgrescdc redis  \
		--remove-orphans

run-full: build-images-full
	@echo "🚀 Starting all services (including Flink, Minio)..."
	docker compose -f docker-compose.yml -p graph up -d \
		broker schema-registry control-center connect \
		jobmanager taskmanager \
		postgrescat minio minio-client \
		neo4j mongodb postgrescdc redis  \
		--remove-orphans 


 # https://neo4j.com/docs/operations-manual/current/docker/operations/#docker-neo4j-plugins
	
createtopics:
	./creTopics/creTopics.sh


cypher:
	docker compose exec --interactive --tty neo4j cypher-shell -u ${NEO4J_USERNAME} -p ${NEO4J_PASSWORD}

constraints:
	docker compose exec --interactive --tty neo4j cypher-shell -u ${NEO4J_USERNAME} -p ${NEO4J_PASSWORD} -f /connect/constraints.cypher


stop:
	docker compose stop

start:
	docker compose start

down:	
	docker compose down 
	cd data/; rm -rf neo4j_db
	cd data/; rm -rf confluent.d
	cd data/; rm -rf postgrescdc
	cd data/; rm -rf postgrescat
	cd data/; rm -rf redis
	cd data/; rm -rf flink
	cd data/; rm -rf minio
	cd data/; rm -rf mongodb


ps:
	docker compose ps

logs:
	docker compose logs

logsf:
	docker compose logs -f

watch:
	watch docker compose ps

fsql:
	docker compose exec --interactive --tty jobmanager /opt/flink/bin/sql-client.sh

jm:
	docker compose exec --interactive --tty jobmanager /bin/bash