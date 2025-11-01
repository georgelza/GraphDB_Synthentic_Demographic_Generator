#!/bin/bash

# =============================================================================
# Children Address Nodes Sink
# =============================================================================
echo "Creating 'Children Address' nodes sink..."

# Read the Cypher query
CYPHER_QUERY=$(cat create_address_node_sink.cypher)

# Create JSON payload with Cypher embedded
JSON_PAYLOAD=$(jq -n \
  --arg cypher "$CYPHER_QUERY" \
  '{
    "name": "neo4j-children-address-node-sink",
    "config": {
      "connector.class": "org.neo4j.connectors.kafka.sink.Neo4jConnector",
      "topics": "children",
      "neo4j.uri": "bolt://neo4j:7687",
      "neo4j.authentication.basic.username": "neo4j",
      "neo4j.authentication.basic.password": "dbpassword",
      "neo4j.cypher.topic.children": $cypher,
      "key.converter": "org.apache.kafka.connect.storage.StringConverter",
      "value.converter": "org.apache.kafka.connect.json.JsonConverter",
      "value.converter.schemas.enable": "false",
      "tasks.max": "2",
      "neo4j.batch.size": "1000",
      "neo4j.batch.timeout.msecs": "5000",
      "neo4j.retry.backoff.msecs": "3000",
      "neo4j.retry.max.attemps": "5"
    }
  }')

# Send to Kafka Connect
echo "$JSON_PAYLOAD" | curl -X POST http://localhost:8083/connectors \
  -H "Content-Type: application/json" \
  -d @-

# =============================================================================
# STATUS CHECK COMMANDS
# =============================================================================
echo ""
echo "Checking connector status..."
echo "=========================="

echo "Children Address sink status:"
curl -s http://localhost:8083/connectors/neo4j-children-address-node-sink/status | jq '.'
