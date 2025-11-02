
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


run: build-images
	@echo "🚀 Starting core services (Kafka, Neo4j )..."
	docker compose -f docker-compose.yml -p graph up -d \
		broker schema-registry control-center connect \
		neo4j  \
		--remove-orphans

# https://neo4j.com/docs/operations-manual/current/docker/operations/#docker-neo4j-plugins
	

cypher:
	docker compose exec --interactive --tty neo4j cypher-shell -u ${NEO4J_USERNAME} -p ${NEO4J_PASSWORD}


creNodes:
	cd creConnect; ./deploy.sh

creEdges:
	docker compose exec --interactive --tty neo4j cypher-shell -u ${NEO4J_USERNAME} -p ${NEO4J_PASSWORD} -f /cypher/1.create_LivesAt_edge_trigger.cypher
#	docker compose exec --interactive --tty neo4j cypher-shell -u ${NEO4J_USERNAME} -p ${NEO4J_PASSWORD} -f /cypher/2.create_HaveAccount_edge.cypher
#	docker compose exec --interactive --tty neo4j cypher-shell -u ${NEO4J_USERNAME} -p ${NEO4J_PASSWORD} -f /cypher/3.create_Card_edge.cypher


constraints:
	docker compose exec --interactive --tty neo4j cypher-shell -u ${NEO4J_USERNAME} -p ${NEO4J_PASSWORD} -f /cypher/constraints.cypher

stop:
	docker compose stop

start:
	docker compose start

down:	
	docker compose down 
	cd data/; rm -rf neo4j_db
	cd data/; rm -rf confluent.d
	cd data/; rm -rf neo4j_data

ps:
	docker compose ps

logs:
	docker compose logs

logsf:
	docker compose logs -f

watch:
	watch docker compose ps