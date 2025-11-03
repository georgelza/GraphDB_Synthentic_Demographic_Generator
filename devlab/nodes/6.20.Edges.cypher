// Create relationships between Countries and their Classifications
// Run this after loading all the countries and classification nodes

// 1. Link Countries to Continents based on continent field matching name
MATCH (country:Country), (continent:Continent)
WHERE country.continent = continent.name
MERGE (country)-[:BELONGS_TO_CONTINENT]->(continent);

// 2. Link Countries to Regional Blocks based on rb_code matching code
MATCH (country:Country), (rb:RegionalBlock)
WHERE country.rb_code = rb.code AND country.rb_code IS NOT NULL
MERGE (country)-[:MEMBER_OF_REGIONAL_BLOCK]->(rb);

// 3. Link Countries to UN Regions based on un_code matching code
MATCH (country:Country), (un:UNRegion)
WHERE country.un_code = un.code AND country.un_code IS NOT NULL
MERGE (country)-[:MEMBER_OF_UN_REGION]->(un);

// 4. Link Countries to Linguistic Groups based on lg_code matching code
MATCH (country:Country), (lg:LinguisticGroup)
WHERE country.lg_code = lg.code AND country.lg_code IS NOT NULL
MERGE (country)-[:PART_OF_LINGUISTIC_GROUP]->(lg);

// 5. Link Countries to Development Groups based on dg_code matching code
MATCH (country:Country), (dg:DevelopmentGroup)
WHERE country.dg_code = dg.code AND country.dg_code IS NOT NULL
MERGE (country)-[:CLASSIFIED_AS_DEVELOPMENT_GROUP]->(dg);




// Optional: Verify the relationships were created
// Uncomment the queries below to check your results
/*
// Check continent relationships
MATCH (c:Country)-[:BELONGS_TO_CONTINENT]->(cont:Continent)
RETURN cont.name as Continent, count(c) as Countries
ORDER BY Continent;
#/

// Check regional block relationships
MATCH (c:Country)-[:MEMBER_OF_REGIONAL_BLOCK]->(rb:RegionalBlock)
RETURN rb.name as RegionalBlock, count(c) as Countries
ORDER BY Countries DESC;

// Check UN region relationships
MATCH (c:Country)-[:MEMBER_OF_UN_REGION]->(un:UNRegion)
RETURN un.name as UNRegion, count(c) as Countries
ORDER BY Countries DESC;

// Check linguistic group relationships
MATCH (c:Country)-[:PART_OF_LINGUISTIC_GROUP]->(lg:LinguisticGroup)
RETURN lg.name as LinguisticGroup, count(c) as Countries
ORDER BY Countries DESC;

// Check development group relationships
MATCH (c:Country)-[:CLASSIFIED_AS_DEVELOPMENT_GROUP]->(dg:DevelopmentGroup)
RETURN dg.name as DevelopmentGroup, count(c) as Countries
ORDER BY Countries DESC;


// Sample query to see all relationships for a specific country
MATCH (c:Country {name: "Ireland"})
OPTIONAL MATCH (c)-[:BELONGS_TO_CONTINENT]->(cont:Continent)
OPTIONAL MATCH (c)-[:MEMBER_OF_REGIONAL_BLOCK]->(rb:RegionalBlock)
OPTIONAL MATCH (c)-[:MEMBER_OF_UN_REGION]->(un:UNRegion)
OPTIONAL MATCH (c)-[:PART_OF_LINGUISTIC_GROUP]->(lg:LinguisticGroup)
OPTIONAL MATCH (c)-[:CLASSIFIED_AS_DEVELOPMENT_GROUP]->(dg:DevelopmentGroup)
RETURN c.name as Country, 
       cont.name as Continent,
       rb.name as RegionalBlock,
       un.name as UNRegion,
       lg.name as LinguisticGroup,
       dg.name as DevelopmentGroup;
