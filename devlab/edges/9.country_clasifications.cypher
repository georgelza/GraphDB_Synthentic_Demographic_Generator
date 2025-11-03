// Based on Continent
MATCH (country:Country)
MATCH (continent:Continent)
WHERE country.continent = continent.name
MERGE (country)-[:BELONGS_TO]->(continent);

// Example: Link countries to their regional blocks
MATCH (country:Country)
MATCH (block:RegionalBlock)
WHERE country.rb_code = block.code
MERGE (country)-[:REGIONAL_BLOCK_MEMBER_OF]->(block);

// Example: Link countries to their UN REGION
MATCH (country:Country)
MATCH (block:UNRegion)
WHERE country.un_code = block.code
MERGE (country)-[:UN_MEMBER_OF]->(block);

// Example: Link countries to their LinguisticGroup
MATCH (country:Country)
MATCH (block:LinguisticGroup)
WHERE country.lg_code = block.code
MERGE (country)-[:LINGUISTIC_GROUP_MEMBER_OF]->(block);

// Example: Link countries to their DevelopmentGroup
MATCH (country:Country)
MATCH (block:DevelopmentGroup)
WHERE country.dg_code = block.code
MERGE (country)-[:DEVELOPMENT_GROUP_MEMBER_OF]->(block);

// Map Address to Country
MATCH (address:Address)
MATCH (country:Country)
WHERE address.countryCode = country.countryCode
MERGE (address)-[:LOCATED_IN]->(country);