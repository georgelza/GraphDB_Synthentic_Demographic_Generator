// Unique constraints on nodes, used for MERGE update statements as the datastore grow.
CREATE CONSTRAINT bank_node_fspiId_uidx IF NOT EXISTS
FOR (a:Bank) 
REQUIRE a.fspiId IS UNIQUE;

// Only one fspiAgentAccountId
CREATE CONSTRAINT Account_node_fspiAgentAccountId_uidx IF NOT EXISTS
FOR (a:Account) 
REQUIRE a.fspiAgentAccountId IS UNIQUE;

CREATE CONSTRAINT AccountHolder_node_fspiAgentAccountId_uidx IF NOT EXISTS
FOR (a:AccountHolder) 
REQUIRE a.fspiAgentAccountId IS UNIQUE;

CREATE CONSTRAINT Corporate_node_regId_uidx IF NOT EXISTS
FOR (a:Corporate) 
REQUIRE a.regId IS UNIQUE;

CREATE CONSTRAINT Person_node_pps_uidx IF NOT EXISTS
FOR (a:Person) 
REQUIRE a.pps IS UNIQUE;

// Mobile Phone Numbers and Landline can not be unique as it can be associated with multiple people living at the same address.
CREATE INDEX Mobile_device_node_mobile_number_uidx IF NOT EXISTS
FOR (a:Mobile_device) 
ON a.mobile_number;

CREATE INDEX LandLine_number_node_phone_number_uidx IF NOT EXISTS
FOR (a:LandLine_number) 
ON a.phone_number;

// Similar to MobilePhone Numbers and Landline Numbers, Addresses can be associated with multiple people or corporates.
CREATE INDEX Address_node_parcel_uidx IF NOT EXISTS
FOR (a:Address) 
ON a.parcel;
