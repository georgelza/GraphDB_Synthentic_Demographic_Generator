#!/bin/bash

# Neo4j Kafka Connect Sink Configurations.
# =============================================================================
# 1. Account Nodes Sink
# =============================================================================
echo "Creating 'Account' nodes sink..."
curl -X POST http://localhost:8083/connectors \
  -H "Content-Type: application/json" \
  -d @create_account_node_sink.json

# =============================================================================
# STATUS CHECK COMMANDS
# =============================================================================
echo ""
echo "Checking connector status..."
echo "=========================="

echo "Accounts sink status:"
curl -s http://localhost:8083/connectors/neo4j-accounts-node-sink/status | jq '.'
