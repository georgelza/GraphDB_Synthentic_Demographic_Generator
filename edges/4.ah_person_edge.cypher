// Where they share the same pps

// Create (AccountHolder) -> [RESPONSIBLE_PARTY]-> (Person) edge
MATCH (ah:AccountHolder)
MATCH (p:Person)
WHERE ah.pps = p.pps
MERGE (ah)-[:RESPONSIBLE_PARTY]->(p);

// Create (Person) -> [HAS_ACCOUNT]-> (AccountHolder) edge
MATCH (p:Person)
MATCH (ah:AccountHolder)
WHERE ah.pps = p.pps
MERGE (p)-[:HAS_ACCOUNT]->(ah);