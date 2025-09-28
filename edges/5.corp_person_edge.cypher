// where they share the same regId

// Create (Person) -> ["OWNER_OF"] -> (Corporate) relationships edges
MATCH (p:Person)
MATCH (cp:Corporate)
WHERE cp.regId = p.regId
MERGE (p)-[:OWNER_OF]->(cp);

// Create (Corporate) -> ["OWNED_BY"] -> (Person) relationships edges
MATCH (cp:Corporate)
MATCH (p:Person)
WHERE cp.regId = p.regId
MERGE (cp)-[:OWNED_BY]->(p);
