// Where they share the same fspiId

// Create (bank) -> [OWNS] -> (acc) edge
MATCH (bank:Bank)
MATCH (acc:Account)
WHERE bank.fspiId = acc.fspiId
MERGE (bank)-[:OWNS]->(acc);

