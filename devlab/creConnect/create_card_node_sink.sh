#!/bin/bash

# Neo4j Kafka Connect Sink Configurations.

# =============================================================================
# Card Nodes Sink
# =============================================================================
echo "Creating 'Card Card' nodes sink..."
export NEO4J_CYPHER=$(cat create_card_node_sink.cypher)
curl -X POST http://localhost:8083/connectors \
  -H "Content-Type: application/json" \
  -d @create_card_node_sink.json

# =============================================================================
# STATUS CHECK COMMANDS
# =============================================================================
echo ""
echo "Checking connector status..."
echo "=========================="

echo "Credit Card sink status:"
curl -s http://localhost:8083/connectors/neo4j-card-node-sink/status | jq '.'
