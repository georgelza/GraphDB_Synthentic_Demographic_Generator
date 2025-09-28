// where they share the same pps

// Create (Person) -> ["HAS_EMAIL"] -> (emailAddresss) relationships edges
MATCH (p:Person)
MATCH (em:emailAddresss)
WHERE p.pps = em.pps
MERGE (p)-[:HAS_EMAIL]->(ad);

// Create (emailAddresss) -> ["EMAIL_IS_USED_BY"] -> (Person) relationships edges
MATCH (em:emailAddresss)
MATCH (p:Person)
WHERE em.pps = p.pps
MERGE (em)-[:EMAIL_IS_USED_BY]->(p);

// where they share the same regId

// Create (Corporate) -> ["HAS_EMAIL"] -> (emailAddresss) relationships edges
MATCH (cp:Corporate)
MATCH (em:emailAddresss)
WHERE cp.regId = em.regId
MERGE (cp)-[:HAS_EMAIL]->(em);

// Create (emailAddresss) -> ["EMAIL_IS_USED_BY"] -> (Corporate) relationships edges
MATCH (em:emailAddresss)
MATCH (cp:Corporate)
WHERE em.regId = cp.regId
MERGE (em)-[:EMAIL_IS_USED_BY]->(cp);