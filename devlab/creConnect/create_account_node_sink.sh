#!/bin/bash

# Neo4j Kafka Connect Sink Configurations.

# =============================================================================
# Account Nodes Sink
# =============================================================================
echo "Creating 'Account' nodes sink..."
export NEO4J_CYPHER=$(cat create_account_node_sink.cypher)
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
curl -s http://localhost:8083/connectors/neo4j-account-node-sink/status | jq '.'
