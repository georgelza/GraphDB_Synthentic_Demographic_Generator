// 

MERGE (n:Account {fspiAgentAccountId: "ULSBIE2DECO-437570486"})
ON CREATE SET n = {
    fspiAgentAccountId: "ULSBIE2DECO-437570486",
    accountId: "437570486",
    fspiId: "ULSBIE2DECO",
    fspiAgentId: "ULSBIE2DECO",
    accountType: "Current Accounts",
    createOn: "2000/05/02"
}
RETURN n;

MERGE (n:Account {fspiAgentAccountId: "ULSBIE2DECO-427570486"})
ON CREATE SET n = {
    fspiAgentAccountId: "ULSBIE2DECO-427570486",
    accountId: "427570486",
    fspiId: "ULSBIE2DECO",
    fspiAgentId: "ULSBIE2DECO",
    accountType: "Savings/Deposit",
    createOn: "1998/05/14"
}
RETURN n;


MERGE (n:Account {fspiAgentAccountId: "ULSBIE2DECO-427570487"})
ON CREATE SET n = {
    fspiAgentAccountId: "ULSBIE2DECO-427570487",
    accountId: "427570487",
    fspiId: "ULSBIE2DECO",
    fspiAgentId: "ULSBIE2DECO",
    accountType: "Savings/Deposit",
    createOn: "2001/04/10"
}
RETURN n;


MERGE (n:Account {fspiAgentAccountId: "ULSBIE2DECO-427570488"})
ON CREATE SET n = {
    fspiAgentAccountId: "ULSBIE2DECO-427570488",
    accountId: "427570488",
    fspiId: "ULSBIE2DECO",
    fspiAgentId: "ULSBIE2DECO",
    accountType: "Savings/Deposit",
    createOn: "2012/07/22"
}
RETURN n;


MERGE (n:Account {fspiAgentAccountId: "ULSBIE2DECO-427570489"})
ON CREATE SET n = {
    fspiAgentAccountId: "ULSBIE2DECO-427570489",
    accountId: "427570489",
    fspiId: "ULSBIE2DECO",
    fspiAgentId: "ULSBIE2DECO",
    accountType: "Business Accounts",
    createOn: "1996/04/30"
}
RETURN n;


// Bank 2
MERGE (n:Account {fspiAgentAccountId: "IPBSIE2D-427570488"})
ON CREATE SET n = {
    fspiAgentAccountId: "IPBSIE2D-427570488",
    accountId: "427570488",
    fspiId: "IPBSIE2D",
    fspiAgentId: "IPBSIE2D",
    accountType: "Cheque Accounts",
    createOn: "2006/02/15"
}
RETURN n;


MERGE (n:Account {fspiAgentAccountId: "IPBSIE2D-527570498"})
ON CREATE SET n = {
    fspiAgentAccountId: "IPBSIE2D-527570498",
    accountId: "527570498",
    fspiId: "IPBSIE2D",
    fspiAgentId: "IPBSIE2D",
    accountType: "Savings/Deposit",
    createOn: "2005/01/05"
}
RETURN n;


MERGE (n:Account {fspiAgentAccountId: "IPBSIE2D-724570489"})
ON CREATE SET n = {
    fspiAgentAccountId: "IPBSIE2D-724570489",
    accountId: "724570489",
    fspiId: "IPBSIE2D",
    fspiAgentId: "IPBSIE2D",
    accountType: "Current Accounts",
    createOn: "2002/11/28"
}
RETURN n;


// Bank 3
MERGE (n:Account {fspiAgentAccountId: "BOFIIE2D-51052432413"})
ON CREATE SET n = {
    fspiAgentAccountId: "BOFIIE2D-51052432413",
    accountId: "51052432413",
    fspiId: "BOFIIE2D",
    fspiAgentId: "BOFIIE2D",
    accountType: "Current Accounts",
    createOn: "1982/08/26"
}
RETURN n;


MERGE (n:Account {fspiAgentAccountId: "BOFIIE2D-51052432503"})
ON CREATE SET n = {
    fspiAgentAccountId: "BOFIIE2D-51052432503",
    accountId: "51052432503",
    fspiId: "BOFIIE2D",
    fspiAgentId: "BOFIIE2D",
    accountType: "Cheque Accounts",
    createOn: "1980/09/10"
}
RETURN n;


MERGE (n:Account {fspiAgentAccountId: "BOFIIE2D-51062432403"})
ON CREATE SET n = {
    fspiAgentAccountId: "BOFIIE2D-51062432403",
    accountId: "51062432403",
    fspiId: "BOFIIE2D",
    fspiAgentId: "BOFIIE2D",
    accountType: "Current Accounts",
    createOn: "1984/03/13"
}
RETURN n;


MERGE (n:Account {fspiAgentAccountId: "BOFIIE2D-52052432403"})
ON CREATE SET n = {
    fspiAgentAccountId: "BOFIIE2D-52052432403",
    accountId: "52052432403",
    fspiId: "BOFIIE2D",
    fspiAgentId: "BOFIIE2D",
    accountType: "Current Accounts",
    createOn: "1998/10/14"
}
RETURN n;

// Note this only populates the fields in the OnCreate at first.
// accountType and createdOn is only added if it is executed and a previous record is found, then the ON MATCH block executes
MERGE (n:Account {fspiAgentAccountId: "BOFIIE2D-51052432423"})
ON CREATE SET n = {
    fspiAgentAccountId: "BOFIIE2D-51052432423",
    accountId: "51052432423",
    fspiId: "BOFIIE2D",
    fspiAgentId: "BOFIIE2D"}
ON MATCH SET n += {
    accountType: "Business Accounts",
    createOn: "1996/08/14"
}
RETURN n;

