// Country Classifications - Neo4j Cypher Script

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ECONOMIC/REGIONAL BLOCKS
MERGE (r:RegionalBlock {name: "European Union"}) 
ON CREATE SET r = { 
    name: "European Union", 
    code: "EU", 
    type: "Economic/Political Union",
    founded: 1993,
    headquarters: "Brussels, Belgium",
    members: 27,
    description: "Political and economic union of European countries"
} 
RETURN r;

MERGE (r:RegionalBlock {name: "ASEAN"}) 
ON CREATE SET r = { 
    name: "Association of Southeast Asian Nations", 
    code: "ASEAN", 
    type: "Economic/Political Union",
    founded: 1967,
    headquarters: "Jakarta, Indonesia",
    members: 10,
    description: "Economic and political association of Southeast Asian countries"
} 
RETURN r;

MERGE (r:RegionalBlock {name: "USMCA"}) 
ON CREATE SET r = { 
    name: "United States-Mexico-Canada Agreement", 
    code: "USMCA", 
    type: "Trade Agreement",
    founded: 2020,
    headquarters: null,
    members: 3,
    description: "Trade agreement between US, Mexico, and Canada, replacing NAFTA"
} 
RETURN r;

MERGE (r:RegionalBlock {name: "African Union"}) 
ON CREATE SET r = { 
    name: "African Union", 
    code: "AU", 
    type: "Political Union",
    founded: 2001,
    headquarters: "Addis Ababa, Ethiopia",
    members: 55,
    description: "Continental union of African states"
} 
RETURN r;

MERGE (r:RegionalBlock {name: "MERCOSUR"}) 
ON CREATE SET r = { 
    name: "Southern Common Market", 
    code: "MERCOSUR", 
    type: "Trade Block",
    founded: 1991,
    headquarters: "Montevideo, Uruguay",
    members: 4,
    description: "South American trade bloc"
} 
RETURN r;

MERGE (r:RegionalBlock {name: "Arab League"}) 
ON CREATE SET r = { 
    name: "League of Arab States", 
    code: "AL", 
    type: "Political/Cultural Union",
    founded: 1945,
    headquarters: "Cairo, Egypt",
    members: 22,
    description: "Regional organization of Arab countries"
} 
RETURN r;

MERGE (r:RegionalBlock {name: "ECOWAS"}) 
ON CREATE SET r = { 
    name: "Economic Community of West African States", 
    code: "ECOWAS", 
    type: "Economic Union",
    founded: 1975,
    headquarters: "Abuja, Nigeria",
    members: 15,
    description: "West African economic union"
} 
RETURN r;

MERGE (r:RegionalBlock {name: "GCC"}) 
ON CREATE SET r = { 
    name: "Gulf Cooperation Council", 
    code: "GCC", 
    type: "Political/Economic Union",
    founded: 1981,
    headquarters: "Riyadh, Saudi Arabia",
    members: 6,
    description: "Regional intergovernmental political and economic union of Gulf states"
} 
RETURN r;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// UN REGIONAL GROUPS
MERGE (u:UNRegion {name: "Africa Group"}) 
ON CREATE SET u = { 
    name: "African Group", 
    code: "AFR", 
    type: "UN Regional Group",
    members: 54,
    description: "UN regional group representing African countries"
} 
RETURN u;

MERGE (u:UNRegion {name: "Asia-Pacific Group"}) 
ON CREATE SET u = { 
    name: "Asia-Pacific Group", 
    code: "ASPAC", 
    type: "UN Regional Group",
    members: 53,
    description: "UN regional group representing Asia-Pacific countries"
} 
RETURN u;

MERGE (u:UNRegion {name: "Eastern European Group"}) 
ON CREATE SET u = { 
    name: "Eastern European Group", 
    code: "EEG", 
    type: "UN Regional Group",
    members: 23,
    description: "UN regional group representing Eastern European countries"
} 
RETURN u;

MERGE (u:UNRegion {name: "Latin American and Caribbean Group"}) 
ON CREATE SET u = { 
    name: "Latin American and Caribbean Group", 
    code: "GRULAC", 
    type: "UN Regional Group",
    members: 33,
    description: "UN regional group representing Latin American and Caribbean countries"
} 
RETURN u;

MERGE (u:UNRegion {name: "Western European and Others Group"}) 
ON CREATE SET u = { 
    name: "Western European and Others Group", 
    code: "WEOG", 
    type: "UN Regional Group",
    members: 28,
    description: "UN regional group representing Western European and other developed countries"
} 
RETURN u;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// CULTURAL/LINGUISTIC GROUPS
MERGE (l:LinguisticGroup {name: "Francophone"}) 
ON CREATE SET l = { 
    name: "Francophone Countries", 
    code: "FR", 
    type: "Linguistic Group",
    language: "French",
    organization: "Organisation internationale de la Francophonie",
    members: 88,
    description: "Countries where French is an official or widely spoken language"
} 
RETURN l;

MERGE (l:LinguisticGroup {name: "Anglophone"}) 
ON CREATE SET l = { 
    name: "Anglophone Countries", 
    code: "EN", 
    type: "Linguistic Group",
    language: "English",
    organization: "Commonwealth of Nations",
    members: 67,
    description: "Countries where English is an official or widely spoken language"
} 
RETURN l;

MERGE (l:LinguisticGroup {name: "Hispanophone"}) 
ON CREATE SET l = { 
    name: "Spanish-speaking Countries", 
    code: "ES", 
    type: "Linguistic Group",
    language: "Spanish",
    organization: "Association of Spanish Language Academies",
    members: 21,
    description: "Countries where Spanish is an official language"
} 
RETURN l;

MERGE (l:LinguisticGroup {name: "Arabophone"}) 
ON CREATE SET l = { 
    name: "Arabic-speaking Countries", 
    code: "AR", 
    type: "Linguistic Group",
    language: "Arabic",
    organization: "Arab League",
    members: 22,
    description: "Countries where Arabic is an official language"
} 
RETURN l;

MERGE (l:LinguisticGroup {name: "Lusophone"}) 
ON CREATE SET l = { 
    name: "Portuguese-speaking Countries", 
    code: "PT", 
    type: "Linguistic Group",
    language: "Portuguese",
    organization: "Community of Portuguese Language Countries",
    members: 9,
    description: "Countries where Portuguese is an official language"
} 
RETURN l;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// DEVELOPMENT CLASSIFICATIONS
MERGE (d:DevelopmentGroup {name: "Developed Countries"}) 
ON CREATE SET d = { 
    name: "Developed Countries", 
    code: "DEV", 
    type: "Development Classification",
    criteria: "High Human Development Index, high GDP per capita",
    members: 37,
    description: "Countries with advanced economies and high living standards"
} 
RETURN d;

MERGE (d:DevelopmentGroup {name: "Developing Countries"}) 
ON CREATE SET d = { 
    name: "Developing Countries", 
    code: "DEVG", 
    type: "Development Classification",
    criteria: "Medium Human Development Index, middle-income economies",
    members: 126,
    description: "Countries with emerging economies and improving living standards"
} 
RETURN d;

MERGE (d:DevelopmentGroup {name: "Least Developed Countries"}) 
ON CREATE SET d = { 
    name: "Least Developed Countries", 
    code: "LDC", 
    type: "Development Classification",
    criteria: "Low GDP per capita, weak human assets, high economic vulnerability",
    members: 46,
    description: "UN category for countries with lowest socioeconomic development"
} 
RETURN d;

MERGE (d:DevelopmentGroup {name: "Small Island Developing States"}) 
ON CREATE SET d = { 
    name: "Small Island Developing States", 
    code: "SIDS", 
    type: "Development Classification",
    criteria: "Small island nations with unique development challenges",
    members: 58,
    description: "Distinct group of developing countries facing similar sustainable development challenges"
} 
RETURN d;

MERGE (d:DevelopmentGroup {name: "Landlocked Developing Countries"}) 
ON CREATE SET d = { 
    name: "Landlocked Developing Countries", 
    code: "LLDC", 
    type: "Development Classification",
    criteria: "Developing countries with no direct access to sea",
    members: 32,
    description: "Developing countries that do not have direct access to the sea"
} 
RETURN d;