#!/bin/bash

# Neo4j Kafka Connect Sink Configurations.

# =============================================================================
# 2. Adults Nodes Sink
# =============================================================================
echo "Creating 'Adults' nodes sink..."
curl -X POST http://localhost:8083/connectors \
  -H "Content-Type: application/json" \
  -d @create_adults_node_sink.json

# =============================================================================
# STATUS CHECK COMMANDS
# =============================================================================
echo ""
echo "Checking connector status..."
echo "=========================="

echo "AccountEvents sink status:"
curl -s http://localhost:8083/connectors/neo4j-adults-node-sink/status | jq '.'
