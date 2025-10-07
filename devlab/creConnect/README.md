## Some Kafka Connect Topics Sink Notes

Simple, all our sink and eventually source jobs will be defined here.

These require the json payloads be posted onto the kafka topic, which will result as a sink into Neo4J.

### Primary Topics -> Nodes

- create_account_node_sink -> This sinks our Accounts from the adults topic and push them into Neo4J Nodes

- create_adults_node_sink -> This sinks our Adults from the adults topic and push them into Neo4J Nodes, 
- create_adult_address_node_sink -> additionally we will extract the address tag and create Address Nodes

- create_children_node_sink -> This sinks our Children from the children topic and push them into Neo4J Nodes, 
- create_children_address_node_sink -> additionally we will extract the address tag and create Address Nodes


### TODO

- Recode all adults and children as people and then add secondary label of adults or children to people.

- Add parcel_id as a property to address node.
   
- Create edge [LIVING_AT (:parcel_id)] between family members => Address node based on same parcel_id 

- Create edge between Address and the neighbourhood node based on neighbourhood.

- Accounts ... 
  - extract/create account nodes
  - create edge between people/adults and accounts.
  - create edge between accounts and banks.