#!/bin/bash

# Neo4j Kafka Connect Sink Configurations.
# =============================================================================
# Children Nodes Sink
# =============================================================================
echo "Creating 'Children' nodes sink..."
export NEO4J_CYPHER=$(cat create_children_node_sink.cypher)
curl -X POST http://localhost:8083/connectors \
  -H "Content-Type: application/json" \
  -d @create_children_node_sink.json

# =============================================================================
# STATUS CHECK COMMANDS
# =============================================================================
echo ""
echo "Checking connector status..."
echo "=========================="

echo "Children sink status:"
curl -s http://localhost:8083/connectors/neo4j-children-node-sink/status | jq '.'
