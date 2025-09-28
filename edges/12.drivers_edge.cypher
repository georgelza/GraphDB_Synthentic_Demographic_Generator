// where they share the same pps

// Create (Person) -> ["HAVE_DRIVERS_LICENSE"] -> (DriversLicense) relationships edges
MATCH (p:Person)
MATCH (dl:DriversLicense)
WHERE p.pps = dl.pps
MERGE (p)-[:HAVE_DRIVERS_LICENSE]->(dl);

// Create (DriversLicense) -> ["DRIVERS_LICENSE_ISSUED_TO"] -> (Person) relationships edges
MATCH (dl:DriversLicense)
MATCH (p:Person)
WHERE dl.pps = p.pps
MERGE (dl)-[:DRIVERS_LICENSE_ISSUED_TO]->(p);