## Some Kafka Connect Topics Sink Notes

Simple, all our sink and eventually source jobs will be defined here.

These require the json payloads be posted onto the kafka topic, which will result as a sink into Neo4J.

### Topics

- create_account_node_sink -> This sinks our Accounts from the adults topic and push them into Neo4J Nodes

- create_adults_node_sink -> This sinks our Adults from the adults topic and push them into Neo4J Nodes, additionally we will extract the address tag and create Address Nodes

- create_children_node_sink -> This sinks our Children from the children topic and push them into Neo4J Nodes, additionally we will extract the address tag and create Address Nodes
