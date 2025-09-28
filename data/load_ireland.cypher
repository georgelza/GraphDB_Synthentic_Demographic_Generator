// Load Ireland Geographic Data into Neo4j with Neighbourhoods
// Make sure the ireland.json file is in your neo4j_data/ directory

// First, create the Country node
CALL apoc.load.json("file:///var/lib/neo4j/import/ireland.json") YIELD value as country
CREATE (c:Country {
  name: country.name,
  countryCode: country.countryCode,
  country: country.country,
  continent: country.continent,
  currency: country.currency,
  currencySymbol: country.currencySymbol,
  countryPhonePrefix: country.countryPhonePrefix,
  rb_code: country.rb_code,
  un_code: country.un_code,
  lg_code: country.lg_code,
  dg_code: country.dg_code,
  population: country.population,
  census_year: country.census_year,
  national_average_age: country.national_average_age,
  national_male_population: country.national_male_population,
  national_female_population: country.national_female_population
});

// Create Province nodes and relate them to Country
CALL apoc.load.json("file:///var/lib/neo4j/import/ireland.json") YIELD value as country
MATCH (c:Country {name: country.name})
UNWIND country.provinces as province
MERGE (p:Province {name: province.name})
ON CREATE SET 
  p.population = province.population
ON MATCH SET 
  p.population = province.population
MERGE (c)-[:HAS_PROVINCE]->(p);

// Create County nodes and relate them to Provinces
CALL apoc.load.json("file:///var/lib/neo4j/import/ireland.json") YIELD value as country
UNWIND country.provinces as province
UNWIND province.counties as county
MATCH (p:Province {name: province.name})
MERGE (co:County {name: county.name})
ON CREATE SET 
  co.population = county.population,
  co.average_age = county.average_age
ON MATCH SET 
  co.population = county.population,
  co.average_age = county.average_age
MERGE (p)-[:HAS_COUNTY]->(co);

// Create City/Town nodes with electoral_ward and postal_code
// Fixed version with null handling for CityTown creation
CALL apoc.load.json("file:///var/lib/neo4j/import/ireland.json") YIELD value as country
UNWIND country.provinces as province
UNWIND province.counties as county
UNWIND county.cities_towns as city_town
MATCH (co:County {name: county.name})
// Only merge with non-null values in the pattern
MERGE (ct:CityTown {
  name: city_town.name, 
  electoral_ward: COALESCE(city_town.electoral_ward, 'Unknown')
})
ON CREATE SET 
  ct.postal_code = CASE WHEN city_town.postal_code IS NOT NULL THEN city_town.postal_code END,
  ct.population = CASE WHEN city_town.population IS NOT NULL AND NOT isNaN(city_town.population) THEN city_town.population END,
  ct.average_age = CASE WHEN city_town.average_age IS NOT NULL AND NOT isNaN(city_town.average_age) THEN city_town.average_age END,
  ct.male_population = CASE WHEN city_town.male_population IS NOT NULL AND NOT isNaN(city_town.male_population) THEN city_town.male_population END,
  ct.female_population = CASE WHEN city_town.female_population IS NOT NULL AND NOT isNaN(city_town.female_population) THEN city_town.female_population END,
  ct.male_children = CASE WHEN city_town.male_children IS NOT NULL AND NOT isNaN(city_town.male_children) THEN city_town.male_children END,
  ct.female_children = CASE WHEN city_town.female_children IS NOT NULL AND NOT isNaN(city_town.female_children) THEN city_town.female_children END,
  ct.marital_single_pct = CASE WHEN city_town.marital_status_percentages IS NOT NULL AND city_town.marital_status_percentages.single IS NOT NULL AND NOT isNaN(city_town.marital_status_percentages.single) THEN city_town.marital_status_percentages.single END,
  ct.marital_married_pct = CASE WHEN city_town.marital_status_percentages IS NOT NULL AND city_town.marital_status_percentages.married IS NOT NULL AND NOT isNaN(city_town.marital_status_percentages.married) THEN city_town.marital_status_percentages.married END,
  ct.marital_separated_pct = CASE WHEN city_town.marital_status_percentages IS NOT NULL AND city_town.marital_status_percentages.separated IS NOT NULL AND NOT isNaN(city_town.marital_status_percentages.separated) THEN city_town.marital_status_percentages.separated END,
  ct.marital_divorced_pct = CASE WHEN city_town.marital_status_percentages IS NOT NULL AND city_town.marital_status_percentages.divorced IS NOT NULL AND NOT isNaN(city_town.marital_status_percentages.divorced) THEN city_town.marital_status_percentages.divorced END,
  ct.marital_widowed_pct = CASE WHEN city_town.marital_status_percentages IS NOT NULL AND city_town.marital_status_percentages.widowed IS NOT NULL AND NOT isNaN(city_town.marital_status_percentages.widowed) THEN city_town.marital_status_percentages.widowed END
ON MATCH SET 
  ct.postal_code = CASE WHEN city_town.postal_code IS NOT NULL THEN city_town.postal_code ELSE ct.postal_code END,
  ct.population = CASE WHEN city_town.population IS NOT NULL AND NOT isNaN(city_town.population) THEN city_town.population ELSE ct.population END,
  ct.average_age = CASE WHEN city_town.average_age IS NOT NULL AND NOT isNaN(city_town.average_age) THEN city_town.average_age ELSE ct.average_age END,
  ct.male_population = CASE WHEN city_town.male_population IS NOT NULL AND NOT isNaN(city_town.male_population) THEN city_town.male_population ELSE ct.male_population END,
  ct.female_population = CASE WHEN city_town.female_population IS NOT NULL AND NOT isNaN(city_town.female_population) THEN city_town.female_population ELSE ct.female_population END,
  ct.male_children = CASE WHEN city_town.male_children IS NOT NULL AND NOT isNaN(city_town.male_children) THEN city_town.male_children ELSE ct.male_children END,
  ct.female_children = CASE WHEN city_town.female_children IS NOT NULL AND NOT isNaN(city_town.female_children) THEN city_town.female_children ELSE ct.female_children END,
  ct.marital_single_pct = CASE WHEN city_town.marital_status_percentages IS NOT NULL AND city_town.marital_status_percentages.single IS NOT NULL AND NOT isNaN(city_town.marital_status_percentages.single) THEN city_town.marital_status_percentages.single ELSE ct.marital_single_pct END,
  ct.marital_married_pct = CASE WHEN city_town.marital_status_percentages IS NOT NULL AND city_town.marital_status_percentages.married IS NOT NULL AND NOT isNaN(city_town.marital_status_percentages.married) THEN city_town.marital_status_percentages.married ELSE ct.marital_married_pct END,
  ct.marital_separated_pct = CASE WHEN city_town.marital_status_percentages IS NOT NULL AND city_town.marital_status_percentages.separated IS NOT NULL AND NOT isNaN(city_town.marital_status_percentages.separated) THEN city_town.marital_status_percentages.separated ELSE ct.marital_separated_pct END,
  ct.marital_divorced_pct = CASE WHEN city_town.marital_status_percentages IS NOT NULL AND city_town.marital_status_percentages.divorced IS NOT NULL AND NOT isNaN(city_town.marital_status_percentages.divorced) THEN city_town.marital_status_percentages.divorced ELSE ct.marital_divorced_pct END,
  ct.marital_widowed_pct = CASE WHEN city_town.marital_status_percentages IS NOT NULL AND city_town.marital_status_percentages.widowed IS NOT NULL AND NOT isNaN(city_town.marital_status_percentages.widowed) THEN city_town.marital_status_percentages.widowed ELSE ct.marital_widowed_pct END
MERGE (co)-[:HAS_CITY_TOWN]->(ct);

// ALTERNATIVE: Simpler version using COALESCE for default values
CALL apoc.load.json("file:///var/lib/neo4j/import/ireland.json") YIELD value as country
UNWIND country.provinces as province
UNWIND province.counties as county
UNWIND county.cities_towns as city_town
MATCH (co:County {name: county.name})
MERGE (ct:CityTown {
  name: city_town.name, 
  electoral_ward: COALESCE(city_town.electoral_ward, 'Unknown')
})
ON CREATE SET 
  ct.postal_code = COALESCE(city_town.postal_code, 'Unknown'),
  ct.population = COALESCE(city_town.population, 0),
  ct.average_age = COALESCE(city_town.average_age, 0),
  ct.male_population = COALESCE(city_town.male_population, 0),
  ct.female_population = COALESCE(city_town.female_population, 0),
  ct.male_children = COALESCE(city_town.male_children, 0),
  ct.female_children = COALESCE(city_town.female_children, 0),
  ct.marital_single_pct = COALESCE(city_town.marital_status_percentages.single, 0),
  ct.marital_married_pct = COALESCE(city_town.marital_status_percentages.married, 0),
  ct.marital_separated_pct = COALESCE(city_town.marital_status_percentages.separated, 0),
  ct.marital_divorced_pct = COALESCE(city_town.marital_status_percentages.divorced, 0),
  ct.marital_widowed_pct = COALESCE(city_town.marital_status_percentages.widowed, 0)
ON MATCH SET 
  ct.postal_code = COALESCE(city_town.postal_code, ct.postal_code),
  ct.population = COALESCE(city_town.population, ct.population),
  ct.average_age = COALESCE(city_town.average_age, ct.average_age),
  ct.male_population = COALESCE(city_town.male_population, ct.male_population),
  ct.female_population = COALESCE(city_town.female_population, ct.female_population),
  ct.male_children = COALESCE(city_town.male_children, ct.male_children),
  ct.female_children = COALESCE(city_town.female_children, ct.female_children),
  ct.marital_single_pct = COALESCE(city_town.marital_status_percentages.single, ct.marital_single_pct),
  ct.marital_married_pct = COALESCE(city_town.marital_status_percentages.married, ct.marital_married_pct),
  ct.marital_separated_pct = COALESCE(city_town.marital_status_percentages.separated, ct.marital_separated_pct),
  ct.marital_divorced_pct = COALESCE(city_town.marital_status_percentages.divorced, ct.marital_divorced_pct),
  ct.marital_widowed_pct = COALESCE(city_town.marital_status_percentages.widowed, ct.marital_widowed_pct)
MERGE (co)-[:HAS_CITY_TOWN]->(ct);

// MOST ROBUST VERSION: Filter out records with critical null values
CALL apoc.load.json("file:///var/lib/neo4j/import/ireland.json") YIELD value as country
UNWIND country.provinces as province
UNWIND province.counties as county
UNWIND county.cities_towns as city_town
WITH province, county, city_town 
WHERE city_town.name IS NOT NULL // Only process records with valid names
MATCH (co:County {name: county.name})
MERGE (ct:CityTown {
  name: city_town.name, 
  electoral_ward: COALESCE(city_town.electoral_ward, 'Unknown')
})
ON CREATE SET 
  ct.postal_code = COALESCE(city_town.postal_code, 'Unknown'),
  ct.population = COALESCE(city_town.population, 0),
  ct.average_age = COALESCE(city_town.average_age, 0),
  ct.male_population = COALESCE(city_town.male_population, 0),
  ct.female_population = COALESCE(city_town.female_population, 0),
  ct.male_children = COALESCE(city_town.male_children, 0),
  ct.female_children = COALESCE(city_town.female_children, 0),
  ct.marital_single_pct = COALESCE(city_town.marital_status_percentages.single, 0),
  ct.marital_married_pct = COALESCE(city_town.marital_status_percentages.married, 0),
  ct.marital_separated_pct = COALESCE(city_town.marital_status_percentages.separated, 0),
  ct.marital_divorced_pct = COALESCE(city_town.marital_status_percentages.divorced, 0),
  ct.marital_widowed_pct = COALESCE(city_town.marital_status_percentages.widowed, 0)
ON MATCH SET 
  ct.postal_code = COALESCE(city_town.postal_code, ct.postal_code),
  ct.population = COALESCE(city_town.population, ct.population),
  ct.average_age = COALESCE(city_town.average_age, ct.average_age),
  ct.male_population = COALESCE(city_town.male_population, ct.male_population),
  ct.female_population = COALESCE(city_town.female_population, ct.female_population),
  ct.male_children = COALESCE(city_town.male_children, ct.male_children),
  ct.female_children = COALESCE(city_town.female_children, ct.female_children),
  ct.marital_single_pct = COALESCE(city_town.marital_status_percentages.single, ct.marital_single_pct),
  ct.marital_married_pct = COALESCE(city_town.marital_status_percentages.married, ct.marital_married_pct),
  ct.marital_separated_pct = COALESCE(city_town.marital_status_percentages.separated, ct.marital_separated_pct),
  ct.marital_divorced_pct = COALESCE(city_town.marital_status_percentages.divorced, ct.marital_divorced_pct),
  ct.marital_widowed_pct = COALESCE(city_town.marital_status_percentages.widowed, ct.marital_widowed_pct)
MERGE (co)-[:HAS_CITY_TOWN]->(ct);


// Create Neighbourhood nodes and relate them to Cities/Towns
// Fixed version with null handling for Neighbourhood creation
CALL apoc.load.json("file:///var/lib/neo4j/import/ireland.json") YIELD value as country
UNWIND country.provinces as province
UNWIND province.counties as county
UNWIND county.cities_towns as city_town
WITH city_town WHERE city_town.neighbourhood IS NOT NULL
UNWIND city_town.neighbourhood as neighbourhood
// Filter out neighbourhoods with null required fields
WITH city_town, neighbourhood 
WHERE neighbourhood.name IS NOT NULL
MATCH (ct:CityTown {
  name: city_town.name, 
  electoral_ward: COALESCE(city_town.electoral_ward, 'Unknown')
})
// Use COALESCE to handle null values in the MERGE pattern
MERGE (n:Neighbourhood {
  name: neighbourhood.name, 
  postal_code: COALESCE(neighbourhood.postal_code, 'Unknown')
})
ON CREATE SET 
  n.townlands = COALESCE(neighbourhood.townlands, 'Unknown'),
  n.electoral_ward = COALESCE(neighbourhood.electoral_ward, 'Unknown')
ON MATCH SET 
  n.townlands = COALESCE(neighbourhood.townlands, n.townlands),
  n.electoral_ward = COALESCE(neighbourhood.electoral_ward, n.electoral_ward)
MERGE (ct)-[:HAS_NEIGHBOURHOOD]->(n);

// ALTERNATIVE: More robust version with additional null checks
CALL apoc.load.json("file:///var/lib/neo4j/import/ireland.json") YIELD value as country
UNWIND country.provinces as province
UNWIND province.counties as county
UNWIND county.cities_towns as city_town
WITH city_town WHERE city_town.neighbourhood IS NOT NULL AND size(city_town.neighbourhood) > 0
UNWIND city_town.neighbourhood as neighbourhood
WITH city_town, neighbourhood 
WHERE neighbourhood.name IS NOT NULL AND neighbourhood.name <> ''
MATCH (ct:CityTown {
  name: city_town.name, 
  electoral_ward: COALESCE(city_town.electoral_ward, 'Unknown')
})
MERGE (n:Neighbourhood {
  name: neighbourhood.name, 
  postal_code: COALESCE(neighbourhood.postal_code, 'Unknown')
})
ON CREATE SET 
  n.townlands = COALESCE(neighbourhood.townlands, 'Unknown'),
  n.electoral_ward = COALESCE(neighbourhood.electoral_ward, 'Unknown')
ON MATCH SET 
  n.townlands = COALESCE(neighbourhood.townlands, n.townlands),
  n.electoral_ward = COALESCE(neighbourhood.electoral_ward, n.electoral_ward)
MERGE (ct)-[:HAS_NEIGHBOURHOOD]->(n);

// DEBUGGING VERSION: Check what's causing the null values
CALL apoc.load.json("file:///var/lib/neo4j/import/ireland.json") YIELD value as country
UNWIND country.provinces as province
UNWIND province.counties as county
UNWIND county.cities_towns as city_town
WITH city_town WHERE city_town.neighbourhood IS NOT NULL
UNWIND city_town.neighbourhood as neighbourhood
WITH city_town.name as city_name, 
     neighbourhood.name as neighbourhood_name,
     neighbourhood.postal_code as postal_code,
     neighbourhood.townlands as townlands,
     neighbourhood.electoral_ward as electoral_ward
WHERE neighbourhood_name IS NULL OR postal_code IS NULL
RETURN city_name, neighbourhood_name, postal_code, townlands, electoral_ward
LIMIT 10;

// SAFEST VERSION: Only process neighbourhoods with all required data
CALL apoc.load.json("file:///var/lib/neo4j/import/ireland.json") YIELD value as country
UNWIND country.provinces as province
UNWIND province.counties as county
UNWIND county.cities_towns as city_town
WITH city_town WHERE city_town.neighbourhood IS NOT NULL
UNWIND city_town.neighbourhood as neighbourhood
WITH city_town, neighbourhood 
WHERE neighbourhood.name IS NOT NULL 
  AND neighbourhood.name <> ''
  AND neighbourhood.postal_code IS NOT NULL 
  AND neighbourhood.postal_code <> ''
MATCH (ct:CityTown {
  name: city_town.name, 
  electoral_ward: COALESCE(city_town.electoral_ward, 'Unknown')
})
MERGE (n:Neighbourhood {
  name: neighbourhood.name, 
  postal_code: neighbourhood.postal_code
})
ON CREATE SET 
  n.townlands = COALESCE(neighbourhood.townlands, 'Unknown'),
  n.electoral_ward = COALESCE(neighbourhood.electoral_ward, 'Unknown')
ON MATCH SET 
  n.townlands = COALESCE(neighbourhood.townlands, n.townlands),
  n.electoral_ward = COALESCE(neighbourhood.electoral_ward, n.electoral_ward)
MERGE (ct)-[:HAS_NEIGHBOURHOOD]->(n);

// MOST FLEXIBLE VERSION: Handle any combination of null values
CALL apoc.load.json("file:///var/lib/neo4j/import/ireland.json") YIELD value as country
UNWIND country.provinces as province
UNWIND province.counties as county
UNWIND county.cities_towns as city_town
WITH city_town WHERE city_town.neighbourhood IS NOT NULL
UNWIND city_town.neighbourhood as neighbourhood
WITH city_town, neighbourhood 
WHERE neighbourhood.name IS NOT NULL
MATCH (ct:CityTown {
  name: city_town.name, 
  electoral_ward: COALESCE(city_town.electoral_ward, 'Unknown')
})
WITH ct, neighbourhood,
     neighbourhood.name as n_name,
     COALESCE(neighbourhood.postal_code, 'UNK-' + toString(rand())) as n_postal_code
MERGE (n:Neighbourhood {
  name: n_name, 
  postal_code: n_postal_code
})
ON CREATE SET 
  n.townlands = COALESCE(neighbourhood.townlands, 'Unknown'),
  n.electoral_ward = COALESCE(neighbourhood.electoral_ward, 'Unknown')
ON MATCH SET 
  n.townlands = COALESCE(neighbourhood.townlands, n.townlands),
  n.electoral_ward = COALESCE(neighbourhood.electoral_ward, n.electoral_ward)
MERGE (ct)-[:HAS_NEIGHBOURHOOD]->(n);



// ALTERNATIVE VERSION WITH BETTER UNIQUE CONSTRAINTS
// (Use this version if you want more robust uniqueness handling)

// Alternative: Create Province nodes with composite uniqueness
CALL apoc.load.json("file:///var/lib/neo4j/import/ireland.json") YIELD value as country
MATCH (c:Country {name: country.country})
UNWIND country.provinces as province
MERGE (p:Province {name: province.name, country: country.country})
ON CREATE SET 
  p.population = province.population
ON MATCH SET 
  p.population = province.population
MERGE (c)-[:HAS_PROVINCE]->(p);

// Alternative: Create County nodes with province context
CALL apoc.load.json("file:///var/lib/neo4j/import/ireland.json") YIELD value as country
UNWIND country.provinces as province
UNWIND province.counties as county
MATCH (p:Province {name: province.name, country: country.country})
MERGE (co:County {name: county.name, province: province.name})
ON CREATE SET 
  co.population = county.population,
  co.average_age = county.average_age
ON MATCH SET 
  co.population = county.population,
  co.average_age = county.average_age
MERGE (p)-[:HAS_COUNTY]->(co);

// Alternative: Create City/Town nodes with county context
CALL apoc.load.json("file:///var/lib/neo4j/import/ireland.json") YIELD value as country
UNWIND country.provinces as province
UNWIND province.counties as county
UNWIND county.cities_towns as city_town
MATCH (co:County {name: county.name, province: province.name})
MERGE (ct:CityTown {name: city_town.name, electoral_ward: city_town.electoral_ward, county: county.name})
ON CREATE SET 
  ct.postal_code = city_town.postal_code,
  ct.population = city_town.population,
  ct.average_age = city_town.average_age,
  ct.male_population = city_town.male_population,
  ct.female_population = city_town.female_population,
  ct.male_children = city_town.male_children,
  ct.female_children = city_town.female_children,
  ct.marital_single_pct = city_town.marital_status_percentages.single,
  ct.marital_married_pct = city_town.marital_status_percentages.married,
  ct.marital_separated_pct = city_town.marital_status_percentages.separated,
  ct.marital_divorced_pct = city_town.marital_status_percentages.divorced,
  ct.marital_widowed_pct = city_town.marital_status_percentages.widowed
ON MATCH SET 
  ct.postal_code = city_town.postal_code,
  ct.population = city_town.population,
  ct.average_age = city_town.average_age,
  ct.male_population = city_town.male_population,
  ct.female_population = city_town.female_population,
  ct.male_children = city_town.male_children,
  ct.female_children = city_town.female_children,
  ct.marital_single_pct = city_town.marital_status_percentages.single,
  ct.marital_married_pct = city_town.marital_status_percentages.married,
  ct.marital_separated_pct = city_town.marital_status_percentages.separated,
  ct.marital_divorced_pct = city_town.marital_status_percentages.divorced,
  ct.marital_widowed_pct = city_town.marital_status_percentages.widowed
MERGE (co)-[:HAS_CITY_TOWN]->(ct);

// Alternative: Create Neighbourhood nodes with city context
CALL apoc.load.json("file:///var/lib/neo4j/import/ireland.json") YIELD value as country
UNWIND country.provinces as province
UNWIND province.counties as county
UNWIND county.cities_towns as city_town
WITH city_town, county WHERE city_town.neighbourhood IS NOT NULL
UNWIND city_town.neighbourhood as neighbourhood
MATCH (ct:CityTown {name: city_town.name, electoral_ward: city_town.electoral_ward, county: county.name})
MERGE (n:Neighbourhood {name: neighbourhood.name, postal_code: neighbourhood.postal_code, city: city_town.name})
ON CREATE SET 
  n.townlands = neighbourhood.townlands,
  n.electoral_ward = neighbourhood.electoral_ward
ON MATCH SET 
  n.townlands = neighbourhood.townlands,
  n.electoral_ward = neighbourhood.electoral_ward
MERGE (ct)-[:HAS_NEIGHBOURHOOD]->(n);



// Create indexes for better performance
CREATE CONSTRAINT province_unique IF NOT EXISTS FOR (p:Province) REQUIRE (p.name, p.country) IS UNIQUE;
CREATE CONSTRAINT county_unique IF NOT EXISTS FOR (c:County) REQUIRE (c.name, c.province) IS UNIQUE;
CREATE CONSTRAINT citytown_unique IF NOT EXISTS FOR (ct:CityTown) REQUIRE (ct.name, ct.electoral_ward, ct.county) IS UNIQUE;
CREATE CONSTRAINT neighbourhood_unique IF NOT EXISTS FOR (n:Neighbourhood) REQUIRE (n.name, n.postal_code, n.city) IS UNIQUE;



// Optional: Create additional relationships for geographic queries
// Connect cities/towns that share the same county (sibling relationship)
MATCH (co:County)-[:HAS_CITY_TOWN]->(ct1:CityTown)
MATCH (co)-[:HAS_CITY_TOWN]->(ct2:CityTown)
WHERE ct1 <> ct2
CREATE (ct1)-[:SAME_COUNTY]->(ct2);

// Connect neighbourhoods that share the same postal code
// MATCH (n1:Neighbourhood), (n2:Neighbourhood)
// WHERE n1.postal_code = n2.postal_code AND n1 <> n2
// CREATE (n1)-[:SAME_POSTAL_CODE]->(n2);

// // Connect neighbourhoods that share the same local electoral_ward
// MATCH (n1:Neighbourhood), (n2:Neighbourhood)
// WHERE n1.electoral_ward = n2.electoral_ward AND n1 <> n2
// CREATE (n1)-[:SAME_ELECTORAL_AREA]->(n2);



// Verify the data structure with neighbourhoods
MATCH path = (c:Country)-[:HAS_PROVINCE]->(p:Province)-[:HAS_COUNTY]->(co:County)-[:HAS_CITY_TOWN]->(ct:CityTown)
OPTIONAL MATCH (ct)-[:HAS_NEIGHBOURHOOD]->(n:Neighbourhood)
RETURN c.name as country, 
       p.name as province, 
       co.name as county, 
       ct.name as city_town,
       ct.population as population,
       count(n) as neighbourhood_count
ORDER BY p.name, co.name, ct.population DESC
LIMIT 20;

// Summary statistics including neighbourhoods
MATCH (c:Country)
OPTIONAL MATCH (c)-[:HAS_PROVINCE]->(p:Province)
OPTIONAL MATCH (p)-[:HAS_COUNTY]->(co:County)
OPTIONAL MATCH (co)-[:HAS_CITY_TOWN]->(ct:CityTown)
OPTIONAL MATCH (ct)-[:HAS_NEIGHBOURHOOD]->(n:Neighbourhood)
RETURN c.name as country,
       count(DISTINCT p) as provinces,
       count(DISTINCT co) as counties,
       count(DISTINCT ct) as cities_towns,
       count(DISTINCT n) as neighbourhoods,
       sum(ct.population) as total_city_population;

// Find cities with neighbourhoods
MATCH (ct:CityTown)-[:HAS_NEIGHBOURHOOD]->(n:Neighbourhood)
RETURN ct.name as city,
       ct.electoral_ward as electoral_ward,
       ct.postal_code as city_postal_code,
       count(n) as neighbourhood_count,
       collect(n.name) as neighbourhoods
ORDER BY neighbourhood_count DESC;

// Find largest cities in each province
MATCH (p:Province)-[:HAS_COUNTY]->(co:County)-[:HAS_CITY_TOWN]->(ct:CityTown)
WITH p, ct
ORDER BY ct.population DESC
WITH p, collect(ct)[0] as largest_city
RETURN p.name as province, 
       largest_city.name as largest_city,
       largest_city.population as population
ORDER BY largest_city.population DESC;


// To remove links/edges
// Remove MajorCity label from all nodes
MATCH (ct:MajorCity)
REMOVE ct:MajorCity;

// Remove YoungPopulation label from all nodes
MATCH (ct:YoungPopulation)
REMOVE ct:YoungPopulation;

// Remove HighSinglePopulation label from all nodes
MATCH (ct:HighSinglePopulation)
REMOVE ct:HighSinglePopulation;


// some queries to return neighbourhoods

MATCH (n:Neighbourhood) RETURN count(n);

MATCH (ct:CityTown)-[r:HAS_NEIGHBOURHOOD]->(n:Neighbourhood) 
RETURN ct.name, n.name LIMIT 10;

// Check if neighbourhoods exist
MATCH (n:Neighbourhood) RETURN count(n) as neighbourhood_count;

// Check if HAS_NEIGHBOURHOOD relationships exist
MATCH ()-[r:HAS_NEIGHBOURHOOD]->() RETURN count(r) as neighbourhood_relationships;

// Show specific neighbourhood connections
MATCH (ct:CityTown)-[:HAS_NEIGHBOURHOOD]->(n:Neighbourhood) 
RETURN ct.name as city, collect(n.name) as neighbourhoods 
LIMIT 10;

// Check the full path including neighbourhoods
MATCH p=(ct:CityTown)-[:HAS_NEIGHBOURHOOD]->(n:Neighbourhood) 
RETURN p LIMIT 20;

MATCH ()-[r]->() 
RETURN type(r) as relationship_type, count(r) as count 
ORDER BY count DESC;