// Antarctica Territories with Regional Classifications - Neo4j Cypher Script
// Note: Antarctica has no sovereign countries, only territorial claims and research stations

MERGE (n:Country {countryCode: "AQ"}) ON CREATE SET n = { name: "Antarctica", countryCode: "AQ", continent: "Antarctica", currency: "NONE", currencySymbol: "N/A", countryPhonePrefix: "+672", rb_code: "NONE", un_code: "NONE", lg_code: "NONE", dg_code: "NONE" } RETURN n;