// where they share the same pps

// Create (Person) -> ["HAVE_MOBILE_DEVICE"] -> (Mobile_device) relationships edges
MATCH (p:Person)
MATCH (md:Mobile_device)
WHERE p.pps = md.pps
MERGE (p)-[:HAVE_MOBILE_DEVICE]->(md);

// Create (Corporate) -> ["MOBILE_DEVICE_IS_USED_BY"] -> (Person) relationships edges
MATCH (md:Mobile_device)
MATCH (p:Person)
WHERE md.pps = p.pps
MERGE (md)-[:MOBILE_DEVICE_IS_USED_BY]->(p);