// Create relationships between related providers (examples)
MATCH (eir:ISP {name: "Eir"})
MATCH (heanet:ISP {name: "HEAnet - National Research and Education Network"})
CREATE (eir)-[:PROVIDES_CONNECTIVITY_TO]->(heanet);

MATCH (inex:ISP {name: "Internet Neutral Exchange Association Company Limited By Guarantee"})
MATCH (digiweb:ISP {name: "Digiweb Ltd"})
CREATE (digiweb)-[:PEERS_AT]->(inex);

MATCH (inex:ISP {name: "Internet Neutral Exchange Association Company Limited By Guarantee"})
MATCH (magnet:ISP {name: "Magnet Networks Limited"})
CREATE (magnet)-[:PEERS_AT]->(inex);