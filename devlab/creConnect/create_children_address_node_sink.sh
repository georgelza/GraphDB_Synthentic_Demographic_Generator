#!/bin/bash

# Neo4j Kafka Connect Sink Configurations.
# =============================================================================
# 3. Children Nodes Sink
# =============================================================================
echo "Creating 'Children' nodes sink..."
export NEO4J_CYPHER=$(cat create_children_address_node_merge.json)
curl -X POST http://localhost:8083/connectors \
  -H "Content-Type: application/json" \
  -d @create_children_address_node_sink.json

# =============================================================================
# STATUS CHECK COMMANDS
# =============================================================================
echo ""
echo "Checking connector status..."
echo "=========================="

echo "Children Address sink status:"
curl -s http://localhost:8083/connectors/neo4j-children-address-node-sink/status | jq '.'
