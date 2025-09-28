// Load Irish Banks JSON data into Neo4j
// Make sure the ie_banks.json file is in your devlab/data/neo4j_data/ directory, this will be mapped to /var/lib/neo4j/import/ inside the neo4j container.

// First, load the banks as nodes
CALL apoc.load.json("file:///var/lib/neo4j/import/ie_banks.json") YIELD value as bank
CREATE (b:Bank {
  fspiId:       bank.fspiId,
  fspiAgentId:  bank.fspiAgentId,
  memberName:   bank.memberName,
  displayName:  bank.displayName,
  country:      bank.country,
  swiftCode:    bank.swiftCode,
  bicfiCode:    bank.bicfiCode,
  ibanCode:     bank.ibanCode,
  memberNo:     bank.memberNo,
  sponsoredBy:  bank.sponsoredBy,
  branchStart:  bank.branchStart,
  branchEnd:    bank.branchEnd
})
// Set headquarters information
SET b.headquarters_address   = bank.headquarters.address,
    b.headquarters_city      = bank.headquarters.city,
    b.headquarters_post_code = bank.headquarters.post_code
// Handle card networks (store as JSON string or create separate relationships)
SET b.card_networks = apoc.convert.toJson(bank.card_network)
RETURN b.memberName as memberName, b.fspiId as fspiId;

// Alternative: Create separate Card Network nodes and relationships
CALL apoc.load.json("file:///var/lib/neo4j/import/ie_banks.json") YIELD value as bank
MATCH (b:Bank {fspiId: bank.fspiId})
UNWIND bank.card_network as card
MERGE (cn:CardNetwork {name: card.name})
CREATE (b)-[:SUPPORTS_CARD {percentage: card.value}]->(cn);

// Create Branch nodes and relate them to Banks
CALL apoc.load.json("file:///var/lib/neo4j/import/ie_banks.json") YIELD value as bank
MATCH (b:Bank {fspiId: bank.fspiId})
FOREACH (branch IN bank.branches |
  CREATE (br:Branch {
    branch_id:    branch.branch_id,
    branch_name:  branch.branch_name,
    address:      branch.location.address,
    city:         branch.location.city,
    province:     branch.location.province,
    county:       branch.location.county,
    latitude:     branch.location.latitude,
    longitude:    branch.location.longitude,
    bicfiCode:    branch.bicfiCode
  })
  CREATE (b)-[:HAS_BRANCH]->(br)
);

// Create Location nodes for better geographic queries
// Option 1: Using FOREACH (Recommended)
CALL apoc.load.json("file:///var/lib/neo4j/import/ie_banks.json") YIELD value as bank
MATCH (b:Bank {fspiId: bank.fspiId})
FOREACH (branch IN bank.branches |
  MERGE (loc:Location {
    city: branch.location.city,
    county: branch.location.county,
    province: branch.location.province
  })
  MERGE (br:Branch {branch_id: branch.branch_id})
  CREATE (br)-[:LOCATED_IN]->(loc)
);
// Recommendation: Use Option 1 with FOREACH as it's the most concise and handles empty arrays gracefully.

// Option 2: Using Conditional Check
CALL apoc.load.json("file:///var/lib/neo4j/import/ie_banks.json") YIELD value as bank
MATCH (b:Bank {fspiId: bank.fspiId})
WITH b, bank
WHERE size(bank.branches) > 0
UNWIND bank.branches as branch
MERGE (loc:Location {
  city: branch.location.city,
  county: branch.location.county,
  province: branch.location.province
})
MATCH (br:Branch {branch_id: branch.branch_id})
CREATE (br)-[:LOCATED_IN]->(loc);

// Option 3: Using Subquery
CALL apoc.load.json("file:///var/lib/neo4j/import/ie_banks.json") YIELD value as bank
MATCH (b:Bank {fspiId: bank.fspiId})
WITH b, bank
CALL {
  WITH b, bank
  WITH b, bank WHERE size(bank.branches) > 0
  UNWIND bank.branches as branch
  MERGE (loc:Location {
    city: branch.location.city,
    county: branch.location.county,
    province: branch.location.province
  })
  MATCH (br:Branch {branch_id: branch.branch_id})
  CREATE (br)-[:LOCATED_IN]->(loc)
}


// Create indexes for better performance
CREATE INDEX bank_fspiId_index   FOR (b:Bank) ON (b.fspiId);
CREATE INDEX bank_swift_index    FOR (b:Bank) ON (b.swiftCode);
CREATE INDEX branch_id_index     FOR (br:Branch) ON (br.branch_id);
CREATE INDEX location_city_index FOR (l:Location) ON (l.city);
