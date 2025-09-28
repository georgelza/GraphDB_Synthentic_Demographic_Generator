//
// When organizing the world into continental collections, the standard geographical approach divides it into 7 continents:
//
// 6.0.continents  (Africa, Asia, North America, South America, Europe, Oceania, Antarctica)
//
// - 6.11.Africa, 
// - 6.12.Asia - The largest collection, including:
//  - East Asia (China, Japan, Korea, Mongolia)
//  - Southeast Asia (Indonesia, Thailand, Vietnam, Philippines, etc.)
//  - South Asia (India, Pakistan, Bangladesh, Sri Lanka, etc.)
//  - Central Asia (Kazakhstan, Uzbekistan, etc.)
//  - Western Asia/Middle East (Saudi Arabia, Iran, Turkey, etc.)
//
// - 6.13.North America,    - Canada, United States, Mexico, and Central American countries down to Panama
// - 6.14.South America,    - All countries from Colombia down to Chile and Argentina
// - 6.15.Europe            - From Iceland to Russia (western part), including the UK, Nordic countries, Eastern Europe, etc.
// - 6.16.Oceania           - Australia, New Zealand, Papua New Guinea, and Pacific island nations (Fiji, Samoa, etc.
// - 6.17.Antarctica,       - No permanent countries, but claimed territories by various nations
//
// 6.1.classification_block
//
// Some alternative organizational approaches you might consider for your database:
//
//  Economic/Regional Blocks:   EU, ASEAN, NAFTA/USMCA, African Union, etc.
//  UN Regional Groups:         Africa, Asia-Pacific, Eastern Europe, Latin America & Caribbean, Western Europe & Others
//  Cultural/Linguistic:        Francophone, Anglophone, Arabic-speaking, etc.
//  Development Classification: Developed, Developing, Least Developed Countries

// To execute/load all of 6.* see the following options.
// There are several ways to execute a Cypher file in Neo4j. Here are the main approaches:

// 1. Using Neo4j Browser (Web Interface)
// cypher
// // Load and execute a cypher file
// :source /path/to/your/file.cypher
//
// Or using APOC:
// cypher
// // Execute cypher file using APOC
// CALL apoc.cypher.runFile("file:///var/lib/neo4j/import/6.0.continents.cypher")

// 2. Using Neo4j-shell or Cypher-shell (Command Line)
// Cypher-shell (Neo4j 3.0+)
// bash
// # Execute file directly
// cypher-shell -u neo4j -p your_password -f /path/to/your/file.cypher

// # Or connect first, then source
// cypher-shell -u neo4j -p your_password
// > :source /path/to/your/file.cypher
// With specific database
// bash
// cypher-shell -u neo4j -p your_password -d your_database -f /path/to/your/file.cypher

// 3. Using APOC Procedures (Within Neo4j)
// cypher
// // For local files in import directory
// CALL apoc.cypher.runFile("file:///var/lib/neo4j/import/6.0.continents.cypher")

// // For files with parameters
// CALL apoc.cypher.runFile("file:///var/lib/neo4j/import/your_script.cypher", {param1: "value1"})

// // For multiple statements
// CALL apoc.cypher.runFiles(["file:///var/lib/neo4j/import/script1.cypher", "file:///var/lib/neo4j/import/script2.cypher"])

// NOTE: each country 6.1* has a links/edges to 6.0/countinent and 6.1 classifications :
// Continent        => continent: Africa, etc -> See below / 7
// RegionalBlock    => rb_code: 
// UN Code          => un_code: 
// LinguisticGroup  => lg_code: 
// DevelopmentGroup => dg_code: 

MERGE (c:Continent {name: "Africa"}) 
ON CREATE SET c = { 
    name: "Africa", 
    code: "AF", 
    area: 30370000, 
    population: 1400000000,
    countries: 54,
    description: "The second-largest and second-most populous continent"
} 
RETURN c;

MERGE (c:Continent {name: "Asia"}) 
ON CREATE SET c = { 
    name: "Asia", 
    code: "AS", 
    area: 44579000, 
    population: 4600000000,
    countries: 50,
    description: "The largest and most populous continent"
} 
RETURN c;

MERGE (c:Continent {name: "Europe"}) 
ON CREATE SET c = { 
    name: "Europe", 
    code: "EU", 
    area: 10180000, 
    population: 750000000,
    countries: 44,
    description: "A continent located entirely in the Northern Hemisphere"
} 
RETURN c;

MERGE (c:Continent {name: "North America"}) 
ON CREATE SET c = { 
    name: "North America", 
    code: "NA", 
    area: 24709000, 
    population: 580000000,
    countries: 23,
    description: "A continent in the Northern Hemisphere, almost entirely within the Western Hemisphere"
} 
RETURN c;

MERGE (c:Continent {name: "South America"}) 
ON CREATE SET c = { 
    name: "South America", 
    code: "SA", 
    area: 17840000, 
    population: 430000000,
    countries: 12,
    description: "A continent in the Western Hemisphere, mostly in the Southern Hemisphere"
} 
RETURN c;

MERGE (c:Continent {name: "Oceania"}) 
ON CREATE SET c = { 
    name: "Oceania", 
    code: "OC", 
    area: 8600000, 
    population: 45000000,
    countries: 14,
    description: "The smallest continent, also known as Oceania, includes Australia and Pacific islands"
} 
RETURN c;

MERGE (c:Continent {name: "Antarctica"}) 
ON CREATE SET c = { 
    name: "Antarctica", 
    code: "AN", 
    area: 14200000, 
    population: 0,
    countries: 0,
    description: "The southernmost continent, covered by ice, with no permanent residents"
} 
RETURN c;