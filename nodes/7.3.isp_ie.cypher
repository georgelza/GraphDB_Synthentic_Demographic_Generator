// Note: IP ranges are examples and should be verified with current RIPE/WHOIS data


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// What is an ASN?
// An Autonomous System Number (ASN) is a unique identifier assigned to a network or group of networks that are under the control of a single organization and have a unified routing policy.
// Key Points:
// Format:

// ASNs are written as "AS" followed by a number (e.g., AS1213, AS31122)
// Originally 16-bit numbers (1-65535), now extended to 32-bit (up to ~4.3 billion)

// Purpose:

// Internet Routing: ASNs are used in BGP (Border Gateway Protocol) to identify different networks on the internet
// Path Selection: Routers use ASNs to determine the best path for data to travel between networks
// Policy Control: Each AS can set its own routing policies and decide which networks it will connect to

// Real Examples from the Irish ISPs:

// AS1213 - HEAnet (Ireland's research network) - established 1992, one of the oldest
// AS31122 - Digiweb Ltd - a major Irish broadband provider
// AS2128 - INEX (Internet Exchange) - where multiple ISPs connect to each other

// Why ASNs Matter for ISPs:

// Network Identity: Each ISP needs an ASN to participate in global internet routing
// Peering Agreements: ISPs use ASNs to identify each other when establishing connections
// Traffic Engineering: ASNs help control how traffic flows between networks
// Security: ASNs are used in route filtering and preventing routing hijacks

// In Practice:
// When you send data from your computer to a website:

// Your ISP (with its ASN) receives your request
// BGP uses ASNs to find the best path across multiple networks
// Each network along the path has its own ASN
// The data eventually reaches the destination network (also with its ASN)

// Think of ASNs like postal codes for internet networks - they help route data to the right destination efficiently across the global internet infrastructure.

// Major Mobile Network Operators
CREATE (three:ISP {
  id: "ie-three-001",
  name: "Three Ireland",
  domain: "threeislands.com",
  type: "Mobile Network Operator",
  country: "Ireland",
  countryCode: "ie",
  asn: ["AS25255"],
  public_ip_ranges: [
    "87.194.0.0/16",
    "46.114.0.0/16",
    "185.98.0.0/16"
  ],
  status: "Active"
});

CREATE (vodafone:ISP {
  id: "ie-vodafone-002", 
  name: "Vodafone Ireland Limited",
  domain: "vodafoneie.com",
  type: "Mobile Network Operator",
  country: "Ireland",
  countryCode: "ie",
  asn: ["AS15502"],
  public_ip_ranges: [
    "212.183.0.0/16",
    "87.32.0.0/16",
    "46.226.0.0/16"
  ],
  status: "Active"
});

CREATE (eir:ISP {
  id: "ie-eir-003",
  name: "Eir",
  domain: "eir.com",
  type: "Fixed Line & Mobile Operator",
  country: "Ireland",
  countryCode: "ie",
  asn: ["AS5466"],
  public_ip_ranges: [
    "159.134.0.0/16",
    "87.122.0.0/16",
    "213.94.0.0/16"
  ],
  status: "Active"
});

CREATE (virginmedia:ISP {
  id: "ie-virgin-004",
  name: "Virgin Media Ireland Limited",
  domain: "virginmedia.com",
  type: "Cable & Broadband Provider", 
  country: "Ireland",
  countryCode: "ie",
  asn: ["AS12388"],
  public_ip_ranges: [
    "217.78.0.0/16",
    "81.18.0.0/16",
    "213.120.0.0/16"
  ],
  ipv4_prefixes: 1,
  date_allocated: "1999-04-23",
  status: "Active"
});

CREATE (sky:ISP {
  id: "ie-sky-005",
  name: "Sky Ireland",
  domain: "sky.com",
  type: "Satellite & Broadband Provider",
  country: "Ireland",
  countryCode: "ie",
  asn: ["AS5607"],
  public_ip_ranges: [
    "87.194.0.0/24"
  ],
  status: "Active"
});

// Major Fixed-line and Broadband Providers
CREATE (digiweb:ISP {
  id: "ie-digiweb-006",
  name: "Digiweb Ltd",
  domain: "iedigiweb.com",
  type: "Broadband Provider",
  country: "Ireland",
  countryCode: "ie",
  asn: ["AS31122"],
  public_ip_ranges: [
    "194.125.0.0/16",
    "87.233.0.0/16"
  ],
  ipv4_prefixes: 46,
  ipv6_prefixes: 6,
  date_allocated: "2004/03/03",
  status: "Active"
});

CREATE (magnet:ISP {
  id: "ie-magnet-007",
  name: "Magnet Networks Limited",
  domain: "digmagnetworks.co.ie",
  type: "Broadband Provider",
  country: "Ireland",
  countryCode: "ie",
  asn: ["AS34245"],
  public_ip_ranges: [
    "217.115.0.0/16",
    "87.36.0.0/16"
  ],
  ipv4_prefixes: 21,
  ipv6_prefixes: 2,
  date_allocated: "2004/11/26",
  status: "Active"
});

CREATE (blacknight:ISP {
  id: "ie-blacknight-008",
  name: "Blacknight Internet Solutions Limited",
  domain: "blacknight.co.ie",
  type: "Web Hosting & Domain Provider",
  country: "Ireland",
  countryCode: "ie",
  asn: ["AS39122"],
  public_ip_ranges: [
    "85.13.0.0/16",
    "46.22.0.0/16"
  ],
  ipv4_prefixes: 26,
  ipv6_prefixes: 6,
  date_allocated: "2005/12/16",
  status: "Active"
});

// Educational and Government Networks
CREATE (heanet:ISP {
  id: "ie-heanet-009",
  name: "HEAnet - National Research and Education Network",
  domain: "heanetlabs.co.ie",
  type: "Educational Network Provider",
  country: "Ireland",
  countryCode: "ie",
  asn: ["AS1213"],
  public_ip_ranges: [
    "134.226.0.0/16",
    "147.252.0.0/16",
    "193.1.0.0/16"
  ],
  ipv4_prefixes: 17,
  ipv6_prefixes: 1,
  date_allocated: "1992/06/17",
  status: "Active"
});

CREATE (ucd:ISP {
  id: "ie-ucd-010",
  name: "University College Dublin",
  type: "University Network",
  country: "Ireland",
  countryCode: "ie",
  asn: ["AS2850"],
  public_ip_ranges: [
    "137.43.0.0/16"
  ],
  ipv4_prefixes: 1,
  date_allocated: "1993/12/14",
  status: "Active"
});

// Regional and Smaller ISPs
CREATE (eastcork:ISP {
  id: "ie-eastcork-011",
  name: "East Cork Broadband Limited",
  domain: "eastcork.com",
  type: "Regional Broadband Provider",
  country: "Ireland",
  countryCode: "ie",
  asn: ["AS15405"],
  public_ip_ranges: [
    "87.192.0.0/24"
  ],
  ipv4_prefixes: 5,
  date_allocated: "2008/05/28",
  status: "Active"
});

CREATE (rapidbb:ISP {
  id: "ie-rapid-012",
  name: "Rapid Broadband Ltd",
  domain: "rapibservices.com",
  type: "Regional Broadband Provider",
  country: "Ireland",
  countryCode: "ie",
  asn: ["AS42090"],
  public_ip_ranges: [
    "46.17.0.0/24"
  ],
  ipv4_prefixes: 6,
  date_allocated: "2006/12/15",
  status: "Active"
});

CREATE (celtic:ISP {
  id: "ie-celtic-013",
  name: "Celtic Broadband Limited",
  domain: "celticbroadband.com",
  type: "Rural Broadband Provider",
  country: "Ireland",
  countryCode: "ie",
  asn: ["AS201607"],
  public_ip_ranges: [
    "185.19.0.0/24"
  ],
  ipv4_prefixes: 1,
  date_allocated: "2014/09/05",
  status: "Active"
});

CREATE (aptus:ISP {
  id: "ie-aptus-014",
  name: "Aptus Ltd",
  domain: "aptus_business.com",
  type: "Business ISP",
  country: "Ireland",
  countryCode: "ie",
  asn: ["AS49567"],
  public_ip_ranges: [
    "95.142.0.0/24"
  ],
  ipv4_prefixes: 7,
  ipv6_prefixes: 1,
  date_allocated: "2009/07/06",
  status: "Active"
});

// Technology and Cloud Providers
CREATE (apple:ISP {
  id: "ie-apple-015",
  name: "Apple Distribution International Ltd",
  domain: "appleinternational.com",
  type: "Technology Company Network",
  country: "Ireland",
  countryCode: "ie",
  asn: ["AS31128"],
  public_ip_ranges: [
    "17.0.0.0/8"
  ],
  ipv4_prefixes: 7,
  ipv6_prefixes: 6,
  date_allocated: "2005/02/22",
  status: "Active"
});

CREATE (google:ISP {
  id: "ie-google-016",
  name: "Google Ireland Limited",
  type: "Technology Company Network",
  country: "Ireland",
  countryCode: "ie",
  asn: ["AS43515"],
  public_ip_ranges: [
    "216.58.0.0/16"
  ],
  ipv4_prefixes: 5,
  ipv6_prefixes: 2,
  date_allocated: "2007/08/15",
  status: "Active"
});

CREATE (googlecloud:ISP {
  id: "ie-googlecloud-017",
  name: "Google Cloud EMEA Ltd",
  domain: "googleemea.com",
  type: "Cloud Provider",
  country: "Ireland",
  countryCode: "ie",
  asn: ["AS214611"],
  public_ip_ranges: [
    "34.89.0.0/16"
  ],
  ipv4_prefixes: 1,
  ipv6_prefixes: 1,
  date_allocated: "2024/06/28",
  status: "Active"
});

// Business and Enterprise Providers
CREATE (bt:ISP {
  id: "ie-bt-018",
  name: "BT Communications Ireland Limited",
  domain: "btbusiness.com",
  type: "Business Communications Provider",
  country: "Ireland",
  countryCode: "ie",
  asn: ["AS24622"],
  public_ip_ranges: [
    "213.121.0.0/24"
  ],
  ipv4_prefixes: 1,
  date_allocated: "2015/07/15",
  status: "Active"
});

CREATE (airspeed:ISP {
  id: "ie-airspeed-019",
  name: "Airspeed Communications Unlimited Company",
  type: "Business ISP",
  country: "Ireland",
  countryCode: "ie",
  asn: ["AS29644"],
  public_ip_ranges: [
    "212.59.0.0/24"
  ],
  ipv4_prefixes: 7,
  ipv6_prefixes: 3,
  date_allocated: "2003/10/30",
  status: "Active"
});

CREATE (iptelecom:ISP {
  id: "ie-iptelecom-020",
  name: "Internet Protocol Telecom Ltd",
  domain: "ipt.com",
  type: "Business ISP",
  country: "Ireland",
  countryCode: "ie",
  asn: ["AS50326"],
  public_ip_ranges: [
    "46.25.0.0/24"
  ],
  ipv4_prefixes: 7,
  date_allocated: "2009/12/19",
  status: "Active"
});

// Hosting and Data Centers
CREATE (inex:ISP {
  id: "ie-inex-021",
  name: "Internet Neutral Exchange Association Company Limited By Guarantee",
  domain: "neutralexchange.com",
  type: "Internet Exchange",
  country: "Ireland",
  countryCode: "ie",
  asn: ["AS2128"],
  public_ip_ranges: [
    "194.88.240.0/24"
  ],
  ipv4_prefixes: 3,
  ipv6_prefixes: 2,
  date_allocated: "1993/03/22",
  status: "Active"
});

CREATE (noraina:ISP {
  id: "ie-noraina-022",
  name: "Noraina Ltd",
  domain: "norainaltd.com",
  type: "Hosting Provider",
  country: "Ireland",
  countryCode: "ie",
  asn: ["AS48305"],
  public_ip_ranges: [
    "185.158.0.0/24"
  ],
  ipv4_prefixes: 7,
  ipv6_prefixes: 5,
  date_allocated: "2015/02/24",
  status: "Active"
});

CREATE (bringo:ISP {
  id: "ie-bringo-023",
  name: "Bringo Limited",
  type: "Hosting Provider",
  country: "Ireland",
  countryCode: "ie",
  asn: ["AS51046"],
  public_ip_ranges: [
    "185.230.0.0/24"
  ],
  ipv4_prefixes: 5,
  ipv6_prefixes: 1,
  date_allocated: "2022/11/30",
  status: "Active"
});

CREATE (orixcom:ISP {
  id: "ie-orixcom-024",
  name: "Orixcom Limited",
  domain: "orixcomlimited.com",
  type: "Business ISP & Hosting",
  country: "Ireland",
  countryCode: "ie",
  asn: ["AS60924"],
  public_ip_ranges: [
    "185.47.0.0/24"
  ],
  ipv4_prefixes: 9,
  ipv6_prefixes: 3,
  date_allocated: "2013/04/11",
  status: "Active"
});