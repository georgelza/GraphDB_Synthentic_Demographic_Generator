// LANDLINE NUMBERS (Irish Format)
// Linked with Person based on ID Number or Registration ID.
// A single Id Number can have multiple landline numbers associated with it.

MERGE (n:LandLine_number {phone_number: "061-874-945"})
ON CREATE SET n = {
    phone_number: "061-874-945",
    pps: "1234567A"
}
RETURN n;

MERGE (n:LandLine_number {phone_number: "061-307-406"})
ON CREATE SET n = {
    phone_number: "061-307-406",
    pps: "3519274C"
}
RETURN n;

MERGE (n:LandLine_number {phone_number: "061-307-506"})
ON CREATE SET n = {
    phone_number: "061-307-506",
    pps: "3519274C"
}
RETURN n;

MERGE (n:LandLine_number {phone_number: "061-365-406"})
ON CREATE SET n = {
    phone_number: "061-365-406",
    pps: "5746392E"
}
RETURN n;

MERGE (n:LandLine_number {phone_number: "061-303-406"})
ON CREATE SET n = {
    phone_number: "061-303-406",
    regId: "1978/0001/1022"
}
RETURN n;

MERGE (n:LandLine_number {phone_number: "061-307-407"})
ON CREATE SET n = {
    phone_number: "061-307-407",
    regId: "1978/0001/1022"
}
RETURN n;

MERGE (n:LandLine_number {phone_number: "061-356-508"})
ON CREATE SET n = {
    phone_number: "061-356-508",
    regId: "1978/0001/1022"
}
RETURN n;

MERGE (n:LandLine_number {phone_number: "061-907-406"})
ON CREATE SET n = {
    phone_number: "061-907-406",
    pps: "6283947F"
}
RETURN n;