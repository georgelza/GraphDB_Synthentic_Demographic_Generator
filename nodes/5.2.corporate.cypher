
MERGE (n:Corporate {regId: "1978/0001/1022"})
ON CREATE SET n = {
    regId: "1978/0001/1022",
    name: "AeroMat",
    estDate: "1978/01/23"
}
ON MATCH SET n += {
    parcel: null,
    address: "V94 C928-10010"
}
RETURN n;

MERGE (n:Corporate {regId: "2011/0201/1185"})
ON CREATE SET n = {
    regId: "2011/0201/1185",
    name: "Alu Engineerings",
    estDate: "2011/02/25"
}
ON MATCH SET n += {
    parcel: null,
    address: "V94 N2H6-10020"
}
RETURN n;

MERGE (n:Corporate {regId: "1987/0401/1785"})
ON CREATE SET n = {
    regId: "1987/0401/1785",
    name: "TopSpec's Workshop",
    estDate: "1987/04/2035"
}
ON MATCH SET n += {
    parcel: null,
    address: "V94 W8N2-10030"
}
RETURN n;

