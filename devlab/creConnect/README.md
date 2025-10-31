## Some Kafka Connect Topics Sink Notes

Simple, all our sink and eventually source jobs will be defined here.

These require the json payloads be posted onto the kafka topic, which will result as a sink into Neo4J.

### Primary Topics -> Nodes

- create_account_node_sink -> This sinks/create Account nodes, extracting the Account detail from the adults topic/Account tag. 
  
- create_card_node_sink -> This sinks/create Credit Card nodes, extracting the Credit Cards from the adults topic/Account tag. 

- create_adults_node_sink -> This sinks our Adults from the adults topic and push them into Neo4J Nodes, 

- create_adult_address_node_sink -> additionally we will extract the address tag and create Address Nodes

- create_children_node_sink -> This sinks our Children from the children topic and push them into Neo4J Nodes, 

- create_children_address_node_sink -> additionally we will extract the address tag and create Address Nodes


### TODO

- Create Edge's
  - Create edge [LIVING_AT (:parcel_id)] between family members => Address node based on same parcel_id 

  - Create edge between Address and the neighbourhood node based on neighbourhood.

  - Accounts ... 
    - create edge between people/adults and accounts nodes.
    - create edge between accounts and banks nodes.

  - Credit Card ... 
    - create edge between people/adults and credit card nodes.
    - create edge between CC and banks nodes.



## Version 2

See creConnect for the Version 2 implimentation, allot more stable and dependant. 

## Version 1

See creConnect/v1 for the old Version 1. some of the flows using this pattern worked, some simply not, unexplainable
Thank you to Michael D from Neo4J for the assistance to figure out the V2 pattern.