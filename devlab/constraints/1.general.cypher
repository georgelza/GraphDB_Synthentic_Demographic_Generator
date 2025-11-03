// Unique constraints on nodes, used for MERGE update statements as the datastore grow.
CREATE CONSTRAINT bank_node_fspiId_uidx IF NOT EXISTS
FOR (a:Bank) 
REQUIRE a.fspiId IS UNIQUE;

// Similar to MobilePhone Numbers and Landline Numbers, Addresses can be associated with multiple people or corporates.
CREATE INDEX Address_node_parcel_uidx IF NOT EXISTS
FOR (a:Address) 
ON a.parcel_id;
