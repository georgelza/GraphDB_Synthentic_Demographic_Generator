
.DEFAULT_GOAL := help
include .env

define HELP

Available commands:

- run: This will call core.
- createtopics: 
- cypher:
- constraints:

- stop: Stop the project.
- start: Start a stopped project.
- down: Tear down the project, clean directories.
- ps: Show all running containers.

- logs: Show/tail logs.
- logsf: Stream logs.

- watch: Watch logs.


endef

export HELP
help:
	@echo "$$HELP"
.PHONY: help


#	docker rmi $(docker images -q --filter "dangling=true")

run:
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