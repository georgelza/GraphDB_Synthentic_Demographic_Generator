
// Unique constraints on nodes to ensure validity of data.
CREATE CONSTRAINT Address_node_uidx IF NOT EXISTS
FOR (a:Address) 
REQUIRE a.parcel_id IS UNIQUE;

CREATE CONSTRAINT Account_node_uidx IF NOT EXISTS
FOR (a:Account) 
REQUIRE (a.accountId, a.fspiId) IS UNIQUE;

CREATE CONSTRAINT Adults_node_uidx IF NOT EXISTS
FOR (a:Adults) 
REQUIRE (a.nationalId) IS UNIQUE;

CREATE CONSTRAINT Children_node_uidx IF NOT EXISTS
FOR (a:Children) 
REQUIRE (a.nationalId) IS UNIQUE;

CREATE CONSTRAINT Card_node_uidx IF NOT EXISTS
FOR (a:Card) 
REQUIRE (a.cardNumber) IS UNIQUE;