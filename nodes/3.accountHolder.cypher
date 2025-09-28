// accountRPType => implies Responsible Party
//
// accountRPType = individual
// accountRPType = corporate

// Bank 1
MERGE (n:AccountHolder {fspiAgentAccountId: "ULSBIE2DECO-437570486"})
ON CREATE SET n = {
    fspiAgentAccountId: "ULSBIE2DECO-437570486",
    accountRPType: "individual",
    pps: "9572840J"
    }
RETURN n;

MERGE (n:AccountHolder {fspiAgentAccountId: "ULSBIE2DECO-427570486"})
ON CREATE SET n = {
    fspiAgentAccountId: "ULSBIE2DECO-427570486",
    accountRPType: "individual",
    pps: "1234567A"
}
RETURN n;                                                                                              

MERGE (n:AccountHolder {fspiAgentAccountId: "ULSBIE2DECO-427570487"})
ON CREATE SET n = {
    fspiAgentAccountId: "ULSBIE2DECO-427570487",
    accountRPType: "individual",
    pps: "2847639B"
}
RETURN n;

MERGE (n:AccountHolder {fspiAgentAccountId: "ULSBIE2DECO-427570488"})
ON CREATE SET n = {
    fspiAgentAccountId: "ULSBIE2DECO-427570488",
    accountRPType: "individual",
    pps: "3519274C"
}
RETURN n;

// Corporate
// AeroMat
MERGE (n:AccountHolder {fspiAgentAccountId: "ULSBIE2DECO-427570489"})
ON CREATE SET n = {
    fspiAgentAccountId: "ULSBIE2DECO-427570489",
    accountRPType: "corporate",
    regId: "1978/0001/1022"
}
RETURN n;


// Bank 2
MERGE (n:AccountHolder {fspiAgentAccountId: "IPBSIE2D-427570488"})
ON CREATE SET n = {
    fspiAgentAccountId: "IPBSIE2D-427570488",
    accountRPType: "individual",
    pps: "5746392E"
}
RETURN n;


MERGE (n:AccountHolder {fspiAgentAccountId: "IPBSIE2D-527570498"})
ON CREATE SET n = {
    fspiAgentAccountId: "IPBSIE2D-527570498",
    accountRPType: "individual",
    pps: "6283947F"
}
RETURN n;


MERGE (n:AccountHolder {fspiAgentAccountId: "IPBSIE2D-724570489"})
ON CREATE SET n = {
    fspiAgentAccountId: "IPBSIE2D-724570489",
    accountRPType: "individual",
    pps: "6283947F"
}
RETURN n;


// Bank 3
MERGE (n:AccountHolder {fspiAgentAccountId: "BOFIIE2D-51052432413"})
ON CREATE SET n = {
    fspiAgentAccountId: "BOFIIE2D-51052432413",
    accountRPType: "individual",
    pps: "6283947F"
}
RETURN n;

MERGE (n:AccountHolder {fspiAgentAccountId: "BOFIIE2D-51052432503"})
ON CREATE SET n = {
    fspiAgentAccountId: "BOFIIE2D-51052432503",
    accountRPType: "individual",
    pps: "7395168G"
}
RETURN n;


MERGE (n:AccountHolder {fspiAgentAccountId: "BOFIIE2D-51062432403"})
ON CREATE SET n = {
    fspiAgentAccountId: "BOFIIE2D-51062432403",
    accountRPType: "individual",
    pps: "8461725H"
}
RETURN n;


MERGE (n:AccountHolder {fspiAgentAccountId: "BOFIIE2D-52052432403"})
ON CREATE SET n = {
    fspiAgentAccountId: "BOFIIE2D-52052432403",
    accountRPType: "individual",
    pps: "8461725H"
}
RETURN n;

// Corporate
// Alu Engineerings
MERGE (n:AccountHolder {fspiAgentAccountId: "BOFIIE2D-51052432423"})
ON CREATE SET n = {
    fspiAgentAccountId: "BOFIIE2D-51052432423",
    accountRPType: "corporate",
    regId: "2011/0201/1185"
}
RETURN n;
