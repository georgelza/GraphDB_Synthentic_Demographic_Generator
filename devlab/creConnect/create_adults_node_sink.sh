#!/bin/bash

# Neo4j Kafka Connect Sink Configurations.

# =============================================================================
# Adults Nodes Sink
# =============================================================================
echo "Creating 'Adults' nodes sink..."
export NEO4J_CYPHER=$(cat create_adults_node_sink.cypher)
curl -X POST http://localhost:8083/connectors \
  -H "Content-Type: application/json" \
  -d @create_adults_node_sink.json

# =============================================================================
# STATUS CHECK COMMANDS
# =============================================================================
echo ""
echo "Checking connector status..."
echo "=========================="

echo "Adults sink status:"
curl -s http://localhost:8083/connectors/neo4j-adults-node-sink/status | jq '.'
