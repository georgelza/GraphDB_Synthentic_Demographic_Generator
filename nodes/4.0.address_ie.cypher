// BUSINESS ADDRESSES (4 total) - Limerick City County

// Business Address 1 - Limerick City City Centre
MERGE (n:Address {parcel_id: "V94 C928-10010"})
ON CREATE SET n = {
  street_1: "3rd Floor, 125 O'Connell Street",
  street_2: "City Quarter Building",
  neighbourhood: "King's Island",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 C928",
  country: "Ireland",
  parcel_id: "V94 C928-10010"
}
ON MATCH SET n = {
  street_1: "3rd Floor, 125 O'Connell Street",
  street_2: "City Quarter Building",
  neighbourhood: "Georgian Quarter",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 W5P3",
  country: "Ireland"
}
RETURN n;

// Business Address 2 - Castletroy
MERGE (n:Address {parcel_id: "V94 N2H6-10020"})
ON CREATE SET n = {
  street_1: "Ground Floor, Plassey Technology Park",
  street_2: "National Technology Park",
  neighbourhood: "Thomondgate",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 N2H6",
  country: "Ireland",
  parcel_id: "V94 N2H6-10020"
}
ON MATCH SET n = {
  street_1: "Ground Floor, Plassey Technology Park",
  street_2: "National Technology Park",
  neighbourhood: "Thomondgate",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 N2H6",
  country: "Ireland"
}
RETURN n;

// Business Address 3 - Dooradoyle
MERGE (n:Address {parcel_id: "V94 W8N2-10030"})
ON CREATE SET n = {
  street_1: "Unit 15, Crescent Shopping Centre",
  street_2: "Dooradoyle Road",
  neighbourhood: "Dooradoyle",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 W8N2",
  country: "Ireland",
  parcel_id: "V94 W8N2-10030"
}
ON MATCH SET n = {
  street_1: "Unit 15, Crescent Shopping Centre",
  street_2: "Dooradoyle Road",
  neighbourhood: "Dooradoyle",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 W8N2",
  country: "Ireland"
}
RETURN n;

// Business Address 4 - Newcastle West
MERGE (n:Address {parcel_id: "V42 X6W9-10040"})
ON CREATE SET n = {
  street_1: "Bishop Street Business Park",
  street_2: "Unit 7",
  neighbourhood: "The Square",
  town: "Newcastle West",
  county: "Limerick",
  province: "Munster",
  postal_code: "V42 X6W9",
  country: "Ireland",
  parcel_id: "V42 X6W9-10040"
}
ON MATCH SET n = {
  street_1: "Bishop Street Business Park",
  street_2: "Unit 7",
  neighbourhood: "Bishop Street",
  town: "Newcastle West",
  county: "Limerick",
  province: "Munster",
  postal_code: "V42 K4R2",
  country: "Ireland"
}
RETURN n;

// RESIDENTIAL ADDRESSES (46 total) - Limerick City County

// Limerick City City Residential Areas

// Georgian Quarter
MERGE (n:Address {parcel_id: "V94 W5P3-20010"})
ON CREATE SET n = {
  street_1: "15 Pery Square",
  street_2: null,
  neighbourhood: "Georgian Quarter",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 W5P3",
  country: "Ireland",
  parcel_id: "V94 W5P3-20010"
}
ON MATCH SET n = {
  street_1: "15 Pery Square",
  street_2: null,
  neighbourhood: "Georgian Quarter",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 W5P3",
  country: "Ireland"
}
RETURN n;

MERGE (n:Address {parcel_id: "V94 W5P3-20020"})
ON CREATE SET n = {
  street_1: "42 Barrington Street",
  street_2: null,
  neighbourhood: "Georgian Quarter",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 W5P3",
  country: "Ireland",
  parcel_id: "V94 W5P3-20020"
}
ON MATCH SET n = {
  street_1: "42 Barrington Street",
  street_2: null,
  neighbourhood: "Georgian Quarter",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 W5P3",
  country: "Ireland"
}
RETURN n;

// Castletroy
MERGE (n:Address {parcel_id: "V94 T7K8-20030"})
ON CREATE SET n = {
  street_1: "78 Millfield",
  street_2: null,
  neighbourhood: "Newtown Pery",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 T7K8",
  country: "Ireland",
  parcel_id: "V94 T7K8-20030"
}
ON MATCH SET n = {
  street_1: "78 Millfield",
  street_2: null,
  neighbourhood: "Newtown Pery",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 T7K8",
  country: "Ireland"
}
RETURN n;

MERGE (n:Address {parcel_id: "V94 T7K8-20040"})
ON CREATE SET n = {
  street_1: "23 Elm Park",
  street_2: null,
  neighbourhood: "Newtown Pery",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 T7K8",
  country: "Ireland",
  parcel_id: "V94 T7K8-20040"
}
ON MATCH SET n = {
  street_1: "23 Elm Park",
  street_2: null,
  neighbourhood: "Newtown Pery",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 T7K8",
  country: "Ireland"
}
RETURN n;

// Southill
MERGE (n:Address {parcel_id: "V94 R9E1-20050"})
ON CREATE SET n = {
  street_1: "56 Raheen Square",
  street_2: null,
  neighbourhood: "Southill",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 R9E1",
  country: "Ireland",
  parcel_id: "V94 R9E1-20050"
}
ON MATCH SET n = {
  street_1: "56 Raheen Square",
  street_2: null,
  neighbourhood: "Southill",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 R9E1",
  country: "Ireland"
}
RETURN n;

MERGE (n:Address {parcel_id: "V94 R9E1-20060"})
ON CREATE SET n = {
  street_1: "134 Clonmacken Road",
  street_2: null,
  neighbourhood: "Southill",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 R9E1",
  country: "Ireland",
  parcel_id: "V94 R9E1-20060"
}
ON MATCH SET n = {
  street_1: "134 Clonmacken Road",
  street_2: null,
  neighbourhood: "Southill",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 R9E1",
  country: "Ireland"
}
RETURN n;

// Thomondgate
MERGE (n:Address {parcel_id: "V94 N2H6-20070"})
ON CREATE SET n = {
  street_1: "89 Thomondgate Road",
  street_2: null,
  neighbourhood: "Thomondgate",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 N2H6",
  country: "Ireland",
  parcel_id: "V94 N2H6-20070"
}
ON MATCH SET n = {
  street_1: "89 Thomondgate Road",
  street_2: null,
  neighbourhood: "Thomondgate",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 N2H6",
  country: "Ireland"
}
RETURN n;

MERGE (n:Address {parcel_id: "V94 N2H6-20080"})
ON CREATE SET n = {
  street_1: "12 Crescent Avenue",
  street_2: null,
  neighbourhood: "Thomondgate",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 N2H6",
  country: "Ireland",
  parcel_id: "V94 N2H6-20080"
}
ON MATCH SET n = {
  street_1: "12 Crescent Avenue",
  street_2: null,
  neighbourhood: "Thomondgate",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 N2H6",
  country: "Ireland"
}
RETURN n;

// Newtown Pery
MERGE (n:Address {parcel_id: "V94 T7K8-20090"})
ON CREATE SET n = {
  street_1: "67 Old Cratloe Road",
  street_2: null,
  neighbourhood: "Newtown Pery",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 T7K8",
  country: "Ireland",
  parcel_id: "V94 T7K8-20090"
}
ON MATCH SET n = {
  street_1: "67 Old Cratloe Road",
  street_2: null,
  neighbourhood: "Newtown Pery",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 T7K8",
  country: "Ireland"
}
RETURN n;

MERGE (n:Address {parcel_id: "V94 T7K8-20100"})
ON CREATE SET n = {
  street_1: "245 Corbally Road",
  street_2: null,
  neighbourhood: "Newtown Pery",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 T7K8",
  country: "Ireland",
  parcel_id: "V94 T7K8-20100"
}
ON MATCH SET n = {
  street_1: "245 Newtown Pery Road",
  street_2: null,
  neighbourhood: "Newtown Pery",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 T7K8",
  country: "Ireland"
}
RETURN n;

// Ballinacurra Weston
MERGE (n:Address {parcel_id: "V94 R2K8-20110"})
ON CREATE SET n = {
  street_1: "34 Childers Road",
  street_2: null,
  neighbourhood: "Ballinacurra Weston",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 R2K8",
  country: "Ireland",
  parcel_id: "V94 R2K8-20110"
}
ON MATCH SET n = {
  street_1: "34 Childers Road",
  street_2: null,
  neighbourhood: "Ballinacurra Weston",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 R2K8",
  country: "Ireland"
}
RETURN n;

MERGE (n:Address {parcel_id: "V94 R2K8-20120"})
ON CREATE SET n = {
  street_1: "91 Shelbourne Road",
  street_2: null,
  neighbourhood: "Ballinacurra Weston",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 R2K8",
  country: "Ireland",
  parcel_id: "V94 R2K8-20120"
}
ON MATCH SET n = {
  street_1: "91 Shelbourne Road",
  street_2: null,
  neighbourhood: "Ballinacurra Weston",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 R2K8",
  country: "Ireland"
}
RETURN n;

// Ennis Road
MERGE (n:Address {parcel_id: "V94 T8K3-20130"})
ON CREATE SET n = {
  street_1: "156 Ennis Road",
  street_2: null,
  neighbourhood: "Ennis Road",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 T8K3",
  country: "Ireland",
  parcel_id: "V94 T8K3-20130"
}
ON MATCH SET n = {
  street_1: "156 Ennis Road",
  street_2: null,
  neighbourhood: "Ennis Road",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 T8K3",
  country: "Ireland"
}
RETURN n;

MERGE (n:Address {parcel_id: "V94 T8K3-20140"})
ON CREATE SET n = {
  street_1: "73 Clancy Strand",
  street_2: null,
  neighbourhood: "Ennis Road",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 T8K3",
  country: "Ireland",
  parcel_id: "V94 T8K3-20140"
}
ON MATCH SET n = {
  street_1: "73 Clancy Strand",
  street_2: null,
  neighbourhood: "Ennis Road",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 T8K3",
  country: "Ireland"
}
RETURN n;

// Southill
MERGE (n:Address {parcel_id: "V94 H2K8-20150"})
ON CREATE SET n = {
  street_1: "28 O'Malley Park",
  street_2: null,
  neighbourhood: "Southill",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 H2K8",
  country: "Ireland",
  parcel_id: "V94 H2K8-20150"
}
ON MATCH SET n = {
  street_1: "28 O'Malley Park",
  street_2: null,
  neighbourhood: "Southill",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 H2K8",
  country: "Ireland"
}
RETURN n;

MERGE (n:Address {parcel_id: "V94 H2K8-20160"})
ON CREATE SET n = {
  street_1: "105 Carew Park",
  street_2: null,
  neighbourhood: "Southill",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 H2K8",
  country: "Ireland",
  parcel_id: "V94 H2K8-20160"
}
ON MATCH SET n = {
  street_1: "105 Carew Park",
  street_2: null,
  neighbourhood: "Southill",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 H2K8",
  country: "Ireland"
}
RETURN n;

// Garryowen
MERGE (n:Address {parcel_id: "V94 F2K8-20170"})
ON CREATE SET n = {
  street_1: "47 Rosbrien Road",
  street_2: null,
  neighbourhood: "Garryowen",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 F2K8",
  country: "Ireland",
  parcel_id: "V94 F2K8-20170"
}
ON MATCH SET n = {
  street_1: "47 Rosbrien Road",
  street_2: null,
  neighbourhood: "Garryowen",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 F2K8",
  country: "Ireland"
}
RETURN n;

MERGE (n:Address {parcel_id: "V94 F2K8-20180"})
ON CREATE SET n = {
  street_1: "82 Greenfields",
  street_2: null,
  neighbourhood: "Garryowen",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 F2K8",
  country: "Ireland",
  parcel_id: "V94 F2K8-20180"
}
ON MATCH SET n = {
  street_1: "82 Greenfields",
  street_2: null,
  neighbourhood: "Garryowen",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 F2K8",
  country: "Ireland"
}
RETURN n;

// Moyross
MERGE (n:Address {parcel_id: "V94 D2K8-20190"})
ON CREATE SET n = {
  street_1: "19 Delmege Park",
  street_2: null,
  neighbourhood: "Moyross",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 D2K8",
  country: "Ireland",
  parcel_id: "V94 D2K8-20190"
}
ON MATCH SET n = {
  street_1: "19 Delmege Park",
  street_2: null,
  neighbourhood: "Moyross",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 D2K8",
  country: "Ireland"
}
RETURN n;

MERGE (n:Address {parcel_id: "V94 D2K8-20200"})
ON CREATE SET n = {
  street_1: "63 Pineview Gardens",
  street_2: null,
  neighbourhood: "Moyross",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 D2K8",
  country: "Ireland",
  parcel_id: "V94 D2K8-20200"
}
ON MATCH SET n = {
  street_1: "63 Pineview Gardens",
  street_2: null,
  neighbourhood: "Moyross",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 D2K8",
  country: "Ireland"
}
RETURN n;

// King's Island
MERGE (n:Address {parcel_id: "V94 A2K8-20210"})
ON CREATE SET n = {
  street_1: "124 King's Island",
  street_2: null,
  neighbourhood: "King's Island",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 A2K8",
  country: "Ireland",
  parcel_id: "V94 A2K8-20210"
}
ON MATCH SET n = {
  street_1: "124 King's Island",
  street_2: null,
  neighbourhood: "King's Island",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 A2K8",
  country: "Ireland"
}
RETURN n;

MERGE (n:Address {parcel_id: "V94 A2K8-20220"})
ON CREATE SET n = {
  street_1: "37 St. Mary's Park",
  street_2: null,
  neighbourhood: "King's Island",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 A2K8",
  country: "Ireland",
  parcel_id: "V94 A2K8-20220"
}
ON MATCH SET n = {
  street_1: "37 St. Mary's Park",
  street_2: null,
  neighbourhood: "King's Island",
  town: "Limerick City",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 A2K8",
  country: "Ireland"
}
RETURN n;

// County Limerick City Towns and Villages

// Adare
MERGE (n:Address {parcel_id: "V94 N6K2-30010"})
ON CREATE SET n = {
  street_1: "45 Main Street",
  street_2: null,
  neighbourhood: "Main Street",
  town: "Adare",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 N6K2",
  country: "Ireland",
  parcel_id: "V94 N6K2-30010"
}
ON MATCH SET n = {
  street_1: "45 Main Street",
  street_2: null,
  neighbourhood: "Main Street",
  town: "Adare",
  county: "Limerick",
  province: "Munster",
  postal_code: "V94 N6K2",
  country: "Ireland"
}
RETURN n;

MERGE (n:Address {parcel_id: "V35 H2T7-30020"})
ON CREATE SET n = {
  street_1: "78 Station Road",
  street_2: null,
  neighbourhood: "Castle Matrix",
  town: "Adare",
  county: "Limerick",
  province: "Munster",
  postal_code: "V35 H2T7",
  country: "Ireland",
  parcel_id: "V35 H2T7-30020"
}
ON MATCH SET n = {
  street_1: "78 Station Road",
  street_2: null,
  neighbourhood: "Chapel Street",
  town: "Adare",
  county: "Limerick",
  province: "Munster",
  postal_code: "V35 W5K1",
  country: "Ireland"
}
RETURN n;

MERGE (n:Address {parcel_id: "V35 Y8V4-30030"})
ON CREATE SET n = {
  street_1: "156 Killarney Road",
  street_2: null,
  neighbourhood: "Main Street",
  town: "Adare",
  county: "Limerick",
  province: "Munster",
  postal_code: "V35 Y8V4",
  country: "Ireland",
  parcel_id: "V35 Y8V4-30030"
}
ON MATCH SET n = {
  street_1: "156 Killarney Road",
  street_2: null,
  neighbourhood: "Castle Matrix",
  town: "Adare",
  county: "Limerick",
  province: "Munster",
  postal_code: "V35 H2T7",
  country: "Ireland"
}
RETURN n;

// Newcastle West
MERGE (n:Address {parcel_id: "V42 X6W9-30040"})
ON CREATE SET n = {
  street_1: "23 The Square",
  street_2: null,
  neighbourhood: "The Square",
  town: "Newcastle West",
  county: "Limerick",
  province: "Munster",
  postal_code: "V42 X6W9",
  country: "Ireland",
  parcel_id: "V42 X6W9-30040"
}
ON MATCH SET n = {
  street_1: "23 The Square",
  street_2: null,
  neighbourhood: "Churchtown",
  town: "Newcastle West",
  county: "Limerick",
  province: "Munster",
  postal_code: "V42 C1N8",
  country: "Ireland"
}
RETURN n;
