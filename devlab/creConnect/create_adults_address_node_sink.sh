#!/bin/bash

# Neo4j Kafka Connect Sink Configurations.

# =============================================================================
# 2. Adults Address Nodes Sink
# =============================================================================
echo "Creating 'Adults Address' nodes sink..."
curl -X POST http://localhost:8083/connectors \
  -H "Content-Type: application/json" \
  -d @create_adults_address_node_sink.json

# =============================================================================
# STATUS CHECK COMMANDS
# =============================================================================
echo ""
echo "Checking connector status..."
echo "=========================="

echo "AccountEvents sink status:"
curl -s http://localhost:8083/connectors/neo4j-adults-address-node-sink/status | jq '.'
