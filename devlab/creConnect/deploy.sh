#!/bin/bash

# =============================================================================
# Nodes via Sink
# =============================================================================
echo "Deploy all Node create via Kafka-> Neo4J sinks..."

find ./ -maxdepth 1 -name '*.sh' -exec {} \;