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
# 2. Adults Nodes Sink
# =============================================================================
echo "Creating 'Adults' nodes sink..."
curl -X POST http://localhost:8083/connectors \
  -H "Content-Type: application/json" \
  -d @create_adults_node_sink.json

# =============================================================================
# 3. Children Nodes Sink
# =============================================================================
echo "Creating 'Children' nodes sink..."
curl -X POST http://localhost:8083/connectors \
  -H "Content-Type: application/json" \
  -d @create_children_node_sink.json

# =============================================================================
# STATUS CHECK COMMANDS
# =============================================================================
echo ""
echo "Checking connector status..."
echo "=========================="

echo "AccountEvents sink status:"
curl -s http://localhost:8083/connectors/neo4j-txn-node-sink/status | jq '.'
