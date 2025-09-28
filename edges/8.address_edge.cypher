// where they share the same parcel

// Create (Person) -> ["LIVES_AT"] -> (Address) relationships edges
MATCH (p:Person)
MATCH (ad:Address)
WHERE p.address = ad.parcel_id
MERGE (p)-[:LIVES_AT]->(ad);

// Create (Address) -> ["IS_OCCUPIED_BY"] -> (Person) relationships edges
MATCH (ad:Address)
MATCH (p:Person)
WHERE ad.parcel_id = p.parcel_id
MERGE (ad)-[:IS_OCCUPIED_BY]->(p);


// Create (Corporate) -> ["OPERATES_OUT_OF"] -> (Address) relationships edges
MATCH (cp:Corporate)
MATCH (ad:Address)
WHERE cp.address = ad.parcel_id
MERGE (cp)-[:OPERATES_OUT_OF]->(ad);

// Create (Address) -> ["LANDLINE_NUMBER_IS_USED_BY"] -> (Corporate) relationships edges
MATCH (ad:Address)
MATCH (cp:Corporate)
WHERE ad.parcel_id = cp.parcel_id
MERGE (ad)-[:USED_AS_BUSINESS_PREMISS]->(cp);
