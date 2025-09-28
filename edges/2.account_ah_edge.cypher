// Where they share the same fspiAgentAccountId

// Create (Account) -> [ACCOCIATED_WITH] -> (AccountHolder) edge
MATCH (acc:Account)
MATCH (ah:AccountHolder)
WHERE acc.fspiAgentAccountId = ah.fspiAgentAccountId
MERGE (acc)-[:ACCOCIATED_WITH]->(ah);

// Create (AccountHolder) -> [ROOTED_WITH] -> (Account) edge
MATCH (ah:AccountHolder)
MATCH (acc:Account)
WHERE acc.fspiAgentAccountId = ah.fspiAgentAccountId
MERGE (ah)-[:ROOTED_WITH]->(acc);