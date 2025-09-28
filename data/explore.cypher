// Lets edxplore our demographic data.

// Explore a province and its counties and its cities and it's Neighbourhood
// SET PARAMETERS
:param provinceName => "Leinster"

// Query 1: Return everything as a graph (nodes + relationships)
MATCH (p:Province {name: $provinceName})
OPTIONAL MATCH path1 = (p)-[:HAS_COUNTY]->(c:County)
OPTIONAL MATCH path2 = (c)-[:HAS_CITY_TOWN]->(city:CityTown)
OPTIONAL MATCH path3 = (city)-[:HAS_NEIGHBOURHOOD]->(n:Neighbourhood)
RETURN p, c, city, n, path1, path2, path3;

// Query 2: Return complete paths showing the full hierarchy
MATCH (p:Province {name: $provinceName})
OPTIONAL MATCH fullPath = (p)-[:HAS_COUNTY]->(c:County)-[:HAS_CITY_TOWN]->(city:CityTown)-[:HAS_NEIGHBOURHOOD]->(n:Neighbourhood)
RETURN p, fullPath;


// Query 3: Visual graph result - shows everything connected
MATCH (p:Province {name: $provinceName})
OPTIONAL MATCH (p)-[:HAS_COUNTY]->(c:County)
OPTIONAL MATCH (c)-[:HAS_CITY_TOWN]->(city:CityTown)
OPTIONAL MATCH (city)-[:HAS_NEIGHBOURHOOD]->(n:Neighbourhood)
RETURN *;


// Query 4: For Neo4j Browser visualization (best for visual exploration)
MATCH (p:Province {name: $provinceName})
MATCH (p)-[:HAS_COUNTY*0..]->(connected_nodes)
RETURN *;


// Query 5: Variable-length path query (shows all connected nodes)
MATCH (p:Province {name: $provinceName})
OPTIONAL MATCH path = (p)-[*1..3]->(connected)
RETURN p, path, connected;


// BONUS: For debugging - see what relationships actually exist
:param provinceName => "Leinster"
MATCH (p:Province {name: $provinceName})
CALL apoc.path.subgraphAll(p, {maxLevel: 3}) YIELD nodes, relationships
RETURN nodes, relationships;



// Explore a county and its cities and it's Neighbourhood
// SET PARAMETERS
:param provinceName => "Leinster"
:param countyName => "Dublin"

// Query 1
MATCH (p:Province {name: $provinceName})-[r1:HAS_COUNTY]->(c:County {name: $countyName})
OPTIONAL MATCH (c)-[r2:HAS_CITY_TOWN]->(city:CityTown)
OPTIONAL MATCH (city)-[r3:HAS_NEIGHBOURHOOD]->(n:Neighbourhood)
RETURN p, r1, c,
       collect(DISTINCT city) as cities,
       collect(DISTINCT n) as neighbourhoods,
       collect(DISTINCT r2) as county_city_relationships,
       collect(DISTINCT r3) as city_neighbourhood_relationships;


// Query 2: Variable-length path (shows all connections from province to neighbourhoods)
MATCH (p:Province {name: $provinceName})-[:HAS_COUNTY]->(c:County {name: $countyName})
OPTIONAL MATCH path = (p)-[*1..3]->(connected)
WHERE connected = c OR (c)-[:HAS_CITY_TOWN*0..]->(connected)
RETURN p, c, path, connected;



// Explore a city and it's Neighbourhood
// SET PARAMETERS
:param provinceName => "Leinster"
:param countyName => "Dublin"
:param cityName => "Arklow"

// Query 1:
MATCH (p:Province {name: $provinceName})-[r1:HAS_COUNTY]->(c:County {name: $countyName})-[r2:HAS_CITY_TOWN]->(city:CityTown {name: $cityName})
OPTIONAL MATCH (city)-[r3:HAS_NEIGHBOURHOOD]->(n:Neighbourhood)
RETURN p, r1, c, r2, city, 
       collect(n) as neighbourhoods,
       collect(r3) as city_neighbourhood_relationships;
