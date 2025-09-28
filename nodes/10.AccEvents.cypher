// Transaction 1 - 2299405743564352934
// Outbound    fspiAgentAccountId Paid counterpartyAgentAccountId
//
MERGE (n:AccountEvents {eventId: "9265405743564350480"})
ON CREATE SET
  n.eventId= "9265405743564350480",
  n.fspiAgentAccountId = "ULSBIE2D-427570486",
  n.counterpartyAgentAccountId = "ULSBIE2D-427570487",
  n.transactionID = "2299405743564352934",
  n.eventTime = "20/07/2025 14:02:10",
  n.baseValue = 2342.00,
  n.currency = "EUR",
  n.direction = "outbound",
  n.paymentSystem = "RTPUSHPAY",
  n.settlementMethod = "CLRG",
  n.settlementClearingSystemCode = "RTPay",
  n.paymentMethod = "TRF",
  n.overallScore = null,
  n.riskProfile = "no-risk"
WITH n
CALL (n) {
  OPTIONAL MATCH (AC:AccountEvents {fspiAgentAccountId: "ULSBIE2D-427570486"})
  WHERE AC.eventId <> n.eventId  // Exclude the current node
  WITH AC ORDER BY AC.eventTime DESC LIMIT 1
  RETURN coalesce(AC.eventId, null) AS prevEventId,
         coalesce(AC.accountEventCounter, 0) + 1 AS accountEventCounter
}
SET n.prevEventId = prevEventId,
    n.accountEventCounter = accountEventCounter
RETURN n;

// Inbound  fspiAgentAccountId recieved funds from counterpartyAgentAccountId
//
MERGE (n:AccountEvents {eventId: "9265405743564350471"})
ON CREATE SET
    n.eventId = "9265405743564350471",
    n.fspiAgentAccountId = "ULSBIE2D-427570487",
    n.counterpartyAgentAccountId = "ULSBIE2D-427570486",
    n.transactionID = "2299405743564352934",
    n.eventTime = "20/07/2025 14:02:10",
    n.baseValue = 2342.00,
    n.currency = "EUR",
    n.direction = "inbound",
    n.paymentSystem = "RTPUSHPAY",
    n.settlementMethod = "CLRG",
    n.settlementClearingSystemCode = "RTPay",
    n.paymentMethod = "TRF",
    n.overallScore = null,
    n.riskProfile = "no-risk"
WITH n
CALL (n) {
  OPTIONAL MATCH (AC:AccountEvents {fspiAgentAccountId: "ULSBIE2D-427570487"})
  WHERE AC.eventId <> n.eventId  // Exclude the current node
  WITH AC ORDER BY AC.eventTime DESC LIMIT 1
  RETURN coalesce(AC.eventId, null) AS prevEventId,
         coalesce(AC.accountEventCounter, 0) + 1 AS accountEventCounter
}
SET n.prevEventId = prevEventId,
    n.accountEventCounter = accountEventCounter
RETURN n;

// Transaction 2 - 2299405743564352935
// Outbound
MERGE (n:AccountEvents {eventId: "9265405743564350481"})
ON CREATE SET
    n.eventId = "9265405743564350481",
    n.fspiAgentAccountId = "ULSBIE2D-427570488",
    n.counterpartyAgentAccountId = "ULSBIE2D-427570486",
    n.transactionID = "2299405743564352935",
    n.eventTime = "20/07/2025 14:12:10",
    n.baseValue = 232242.00,
    n.currency = "EUR",
    n.direction = "outbound",
    n.paymentSystem = "10",
    n.settlementMethod = "CLRG",
    n.settlementClearingSystemCode = "PUSSHTRSFR",
    n.paymentMethod = "TRF",
    n.overallScore = null,
    n.riskProfile = "no-risk"
WITH n
CALL (n) {
  OPTIONAL MATCH (AC:AccountEvents {fspiAgentAccountId: "ULSBIE2D-427570488"})
  WHERE AC.eventId <> n.eventId  // Exclude the current node
  WITH AC ORDER BY AC.eventTime DESC LIMIT 1
  RETURN coalesce(AC.eventId, null) AS prevEventId,
         coalesce(AC.accountEventCounter, 0) + 1 AS accountEventCounter
}
SET n.prevEventId = prevEventId,
    n.accountEventCounter = accountEventCounter
RETURN n;
// Inbound
MERGE (n:AccountEvents {eventId: "9265405743564350482"})
ON CREATE SET
    n.eventId = "9265405743564350482",
    n.fspiAgentAccountId = "ULSBIE2D-427570486",
    n.counterpartyAgentAccountId = "ULSBIE2D-427570488",
    n.transactionID = "2299405743564352935",
    n.eventTime = "20/07/2025 14:12:10",
    n.baseValue = 232242.00,
    n.currency = "EUR",
    n.direction = "inbound",
    n.paymentSystem = "10",
    n.settlementMethod = "CLRG",
    n.settlementClearingSystemCode = "PUSSHTRSFR",
    n.paymentMethod = "TRF",
    n.overallScore = null,
    n.riskProfile = "no-risk"
WITH n
CALL (n) {
  OPTIONAL MATCH (AC:AccountEvents {fspiAgentAccountId: "ULSBIE2D-427570486"})
  WHERE AC.eventId <> n.eventId  // Exclude the current node
  WITH AC ORDER BY AC.eventTime DESC LIMIT 1
  RETURN coalesce(AC.eventId, null) AS prevEventId,
         coalesce(AC.accountEventCounter, 0) + 1 AS accountEventCounter
}
SET n.prevEventId = prevEventId,
    n.accountEventCounter = accountEventCounter
RETURN n;


// Transaction 3 - 2299405743564352936
// Outbound
MERGE (n:AccountEvents {eventId: "9265405743564350483"})
ON CREATE SET
    n.eventId = "9265405743564350483",
    n.fspiAgentAccountId = "ULSBIE2D-427570486",
    n.counterpartyAgentAccountId = "BOFIIE2D-51052432423",
    n.transactionID = "2299405743564352936",
    n.eventTime = "20/07/2025 15:01:10",
    n.baseValue = 242.00,
    n.currency = "EUR",
    n.direction = "outbound",
    n.paymentSystem = "10",
    n.settlementMethod = "CLRG",
    n.settlementClearingSystemCode = "PUSSHTRSFR",
    n.paymentMethod = "TRF",
    n.overallScore = null,
    n.riskProfile = "no-risk"
WITH n
CALL (n) {
  OPTIONAL MATCH (AC:AccountEvents {fspiAgentAccountId: "ULSBIE2D-427570486"})
  WHERE AC.eventId <> n.eventId  // Exclude the current node
  WITH AC ORDER BY AC.eventTime DESC LIMIT 1
  RETURN coalesce(AC.eventId, null) AS prevEventId,
         coalesce(AC.accountEventCounter, 0) + 1 AS accountEventCounter
}
SET n.prevEventId = prevEventId,
    n.accountEventCounter = accountEventCounter
RETURN n;
// Inbound
MERGE (n:AccountEvents {eventId: "9265405743564350484"})
ON CREATE SET
    n.eventId = "9265405743564350484",
    n.fspiAgentAccountId = "BOFIIE2D-51052432423",
    n.counterpartyAgentAccountId = "ULSBIE2D-427570486",
    n.transactionID = "2299405743564352936",
    n.eventTime = "20/07/2025 15:01:10",
    n.baseValue = 242.00,
    n.currency = "EUR",
    n.direction = "inbound",
    n.paymentSystem = "10",
    n.settlementMethod = "CLRG",
    n.settlementClearingSystemCode = "PUSSHTRSFR",
    n.paymentMethod = "TRF",
    n.overallScore = null,
    n.riskProfile = "no-risk"
WITH n
CALL (n) {
  OPTIONAL MATCH (AC:AccountEvents {fspiAgentAccountId: "BOFIIE2D-51052432423"})
  WHERE AC.eventId <> n.eventId  // Exclude the current node
  WITH AC ORDER BY AC.eventTime DESC LIMIT 1
  RETURN coalesce(AC.eventId, null) AS prevEventId,
         coalesce(AC.accountEventCounter, 0) + 1 AS accountEventCounter
}
SET n.prevEventId = prevEventId,
    n.accountEventCounter = accountEventCounter
RETURN n;


// Transaction 4 - 2299405743564352941
// Outbound
MERGE (n:AccountEvents {eventId: "9265405743564350485"})
ON CREATE SET
    n.eventId = "9265405743564350485",
    n.fspiAgentAccountId = "BOFIIE2D-51052432423",
    n.counterpartyAgentAccountId = "BOFIIE2D-52052432403",
    n.transactionID = "2299405743564352941",
    n.eventTime = "20/07/2025 15:03:10",
    n.baseValue = 14322.00,
    n.currency = "EUR",
    n.direction = "outbound",
    n.paymentSystem = "10",
    n.settlementMethod = "CLRG",
    n.settlementClearingSystemCode = "PUSSHTRSFR",
    n.paymentMethod = "TRF",
    n.overallScore = null,
    n.riskProfile = "no-risk"
WITH n
CALL (n) {
  OPTIONAL MATCH (AC:AccountEvents {fspiAgentAccountId: "BOFIIE2D-51052432423"})
  WHERE AC.eventId <> n.eventId  // Exclude the current node
  WITH AC ORDER BY AC.eventTime DESC LIMIT 1
  RETURN coalesce(AC.eventId, null) AS prevEventId,
         coalesce(AC.accountEventCounter, 0) + 1 AS accountEventCounter
}
SET n.prevEventId = prevEventId,
    n.accountEventCounter = accountEventCounter
RETURN n;
// Inbound
MERGE (n:AccountEvents {eventId: "9265405743564350486"})
ON CREATE SET
    n.eventId = "9265405743564350486",
    n.fspiAgentAccountId = "BOFIIE2D-52052432403",
    n.counterpartyAgentAccountId = "BOFIIE2D-51052432423",
    n.transactionID = "2299405743564352941",
    n.eventTime = "20/07/2025 15:03:10",
    n.baseValue = 14322.00,
    n.currency = "EUR",
    n.direction = "inbound",
    n.paymentSystem = "10",
    n.settlementMethod = "CLRG",
    n.settlementClearingSystemCode = "PUSSHTRSFR",
    n.paymentMethod = "TRF",
    n.overallScore = null,
    n.riskProfile = "no-risk"
WITH n
CALL (n) {
  OPTIONAL MATCH (AC:AccountEvents {fspiAgentAccountId: "BOFIIE2D-52052432403"})
  WHERE AC.eventId <> n.eventId  // Exclude the current node
  WITH AC ORDER BY AC.eventTime DESC LIMIT 1
  RETURN coalesce(AC.eventId, null) AS prevEventId,
         coalesce(AC.accountEventCounter, 0) + 1 AS accountEventCounter
}
SET n.prevEventId = prevEventId,
    n.accountEventCounter = accountEventCounter
RETURN n;


// Transaction 5 - 2299405743564362941
// Outbound
MERGE (n:AccountEvents {eventId: "9265405743564352485"})
ON CREATE SET
    n.eventId = "9265405743564352485",
    n.fspiAgentAccountId = "BOFIIE2D-51052432423",
    n.counterpartyAgentAccountId = "BOFIIE2D-52052432403",
    n.transactionID = "2299405743564362941",
    n.eventTime = "20/07/2025 16:03:10",
    n.baseValue = 11322.00,
    n.currency = "EUR",
    n.direction = "outbound",
    n.paymentSystem = "10",
    n.settlementMethod = "CLRG",
    n.settlementClearingSystemCode = "PUSSHTRSFR",
    n.paymentMethod = "TRF",
    n.overallScore = null,
    n.riskProfile = "no-risk"
WITH n
CALL (n) {
  OPTIONAL MATCH (AC:AccountEvents {fspiAgentAccountId: "BOFIIE2D-51052432423"})
  WHERE AC.eventId <> n.eventId  // Exclude the current node
  WITH AC ORDER BY AC.eventTime DESC LIMIT 1
  RETURN coalesce(AC.eventId, null) AS prevEventId,
         coalesce(AC.accountEventCounter, 0) + 1 AS accountEventCounter
}
SET n.prevEventId = prevEventId,
    n.accountEventCounter = accountEventCounter
RETURN n;
// Inbound
MERGE (n:AccountEvents {eventId: "9265405743564351486"})
ON CREATE SET
    n.eventId = "9265405743564351486",
    n.fspiAgentAccountId = "BOFIIE2D-52052432403",
    n.counterpartyAgentAccountId = "BOFIIE2D-51052432423",
    n.transactionID = "2299405743564362941",
    n.eventTime = "20/07/2025 16:03:10",
    n.baseValue = 11322.00,
    n.currency = "EUR",
    n.direction = "inbound",
    n.paymentSystem = "10",
    n.settlementMethod = "CLRG",
    n.settlementClearingSystemCode = "PUSSHTRSFR",
    n.paymentMethod = "TRF",
    n.overallScore = null,
    n.riskProfile = "no-risk"
WITH n
CALL (n) {
  OPTIONAL MATCH (AC:AccountEvents {fspiAgentAccountId: "BOFIIE2D-52052432403"})
  WHERE AC.eventId <> n.eventId  // Exclude the current node
  WITH AC ORDER BY AC.eventTime DESC LIMIT 1
  RETURN coalesce(AC.eventId, null) AS prevEventId,
         coalesce(AC.accountEventCounter, 0) + 1 AS accountEventCounter
}
SET n.prevEventId = prevEventId,
    n.accountEventCounter = accountEventCounter
RETURN n;


// Transaction 6 - 2239405743564352951
// Outbound
MERGE (n:AccountEvents {eventId: "9265425743564350485"})
ON CREATE SET
    n.eventId = "9265425743564350485",
    n.fspiAgentAccountId = "ULSBIE2D-427570489",
    n.counterpartyAgentAccountId = "BOFIIE2D-51052432423",
    n.transactionID = "2239405743564352951",
    n.eventTime = "20/07/2025 17:03:10",
    n.baseValue = 14350.00,
    n.currency = "EUR",
    n.direction = "outbound",
    n.paymentSystem = "RTPUSHPAY",
    n.settlementMethod = "CLRG",
    n.settlementClearingSystemCode = "RTPay",
    n.paymentMethod = "TRF",
    n.overallScore = null,
    n.riskProfile = "no-risk"
WITH n
CALL (n) {
  OPTIONAL MATCH (AC:AccountEvents {fspiAgentAccountId: "ULSBIE2D-427570489"})
  WHERE AC.eventId <> n.eventId  // Exclude the current node
  WITH AC ORDER BY AC.eventTime DESC LIMIT 1
  RETURN coalesce(AC.eventId, null) AS prevEventId,
         coalesce(AC.accountEventCounter, 0) + 1 AS accountEventCounter
}
SET n.prevEventId = prevEventId,
    n.accountEventCounter = accountEventCounter
RETURN n;
// Inbound
MERGE (n:AccountEvents {eventId: "9265415743564350486"})
ON CREATE SET
    n.eventId = "9265415743564350486",
    n.fspiAgentAccountId = "BOFIIE2D-51052432423",
    n.counterpartyAgentAccountId = "ULSBIE2D-427570489",
    n.transactionID = "2239405743564352951",
    n.eventTime = "20/07/2025 17:03:10",
    n.baseValue = 14350.00,
    n.currency = "EUR",
    n.direction = "inbound",
    n.paymentSystem = "RTPUSHPAY",
    n.settlementMethod = "CLRG",
    n.settlementClearingSystemCode = "RTPay",
    n.paymentMethod = "TRF",
    n.overallScore = null,
    n.riskProfile = "no-risk"
WITH n
CALL (n) {
  OPTIONAL MATCH (AC:AccountEvents {fspiAgentAccountId: "BOFIIE2D-51052432423"})
  WHERE AC.eventId <> n.eventId  // Exclude the current node
  WITH AC ORDER BY AC.eventTime DESC LIMIT 1
  RETURN coalesce(AC.eventId, null) AS prevEventId,
         coalesce(AC.accountEventCounter, 0) + 1 AS accountEventCounter
}
SET n.prevEventId = prevEventId,
    n.accountEventCounter = accountEventCounter
RETURN n;


// Transaction 7 - 2299405743564352955
// Outbound
MERGE (n:AccountEvents {eventId: "9265405743564350490"})
ON CREATE SET
    n.eventId = "9265405743564350490",
    n.fspiAgentAccountId = "ULSBIE2D-427570489",
    n.counterpartyAgentAccountId = "BOFIIE2D-51062432403",
    n.transactionID = "2299405743564352955",
    n.eventTime = "20/07/2025 18:03:10",
    n.baseValue = 1092.00,
    n.currency = "EUR",
    n.direction = "outbound",
    n.paymentSystem = "RTPUSHPAY",
    n.settlementMethod = "CLRG",
    n.settlementClearingSystemCode = "RTPay",
    n.paymentMethod = "TRF",
    n.overallScore = null,
    n.riskProfile = "no-risk"
WITH n
CALL (n) {
  OPTIONAL MATCH (AC:AccountEvents {fspiAgentAccountId: "ULSBIE2D-427570489"})
  WHERE AC.eventId <> n.eventId  // Exclude the current node
  WITH AC ORDER BY AC.eventTime DESC LIMIT 1
  RETURN coalesce(AC.eventId, null) AS prevEventId,
         coalesce(AC.accountEventCounter, 0) + 1 AS accountEventCounter
}
SET n.prevEventId = prevEventId,
    n.accountEventCounter = accountEventCounter
RETURN n;
// Inbound
MERGE (n:AccountEvents {eventId: "9265405743564350491"})
ON CREATE SET
    n.eventId = "9265405743564350491",
    n.fspiAgentAccountId = "BOFIIE2D-51062432403",
    n.counterpartyAgentAccountId = "ULSBIE2D-427570489",
    n.transactionID = "2299405743564352955",
    n.eventTime = "20/07/2025 18:03:10",
    n.baseValue = 1092.00,
    n.currency = "EUR",
    n.direction = "inbound",
    n.paymentSystem = "RTPUSHPAY",
    n.settlementMethod = "CLRG",
    n.settlementClearingSystemCode = "RTPay",
    n.paymentMethod = "TRF",
    n.overallScore = null,
    n.riskProfile = "no-risk"
WITH n
CALL (n) {
  OPTIONAL MATCH (AC:AccountEvents {fspiAgentAccountId: "BOFIIE2D-51062432403"})
  WHERE AC.eventId <> n.eventId  // Exclude the current node
  WITH AC ORDER BY AC.eventTime DESC LIMIT 1
  RETURN coalesce(AC.eventId, null) AS prevEventId,
         coalesce(AC.accountEventCounter, 0) + 1 AS accountEventCounter
}
SET n.prevEventId = prevEventId,
    n.accountEventCounter = accountEventCounter
RETURN n;


// Transaction 8 - 2299405743564352973
// Outbound
MERGE (n:AccountEvents {eventId: "9265405743564350494"})
ON CREATE SET
    n.eventId = "9265405743564350494",
    n.fspiAgentAccountId = "ULSBIE2D-437570486",
    n.counterpartyAgentAccountId = "BOFIIE2D-51052432413",
    n.transactionID = "2299405743564352973",
    n.eventTime = "21/07/2025 10:43:10",
    n.baseValue = 1998.00,
    n.currency = "EUR",
    n.direction = "outbound",
    n.paymentSystem = "10",
    n.settlementMethod = "CLRG",
    n.settlementClearingSystemCode = "PUSSHTRSFR",
    n.paymentMethod = "TRF",
    n.overallScore = null,
    n.riskProfile = "no-risk"
WITH n
CALL (n) {
  OPTIONAL MATCH (AC:AccountEvents {fspiAgentAccountId: "ULSBIE2D-437570486"})
  WHERE AC.eventId <> n.eventId  // Exclude the current node
  WITH AC ORDER BY AC.eventTime DESC LIMIT 1
  RETURN coalesce(AC.eventId, null) AS prevEventId,
         coalesce(AC.accountEventCounter, 0) + 1 AS accountEventCounter
}
SET n.prevEventId = prevEventId,
    n.accountEventCounter = accountEventCounter
RETURN n;
// Inbound
MERGE (n:AccountEvents {eventId: "9265405743564350495"})
ON CREATE SET
    n.eventId = "9265405743564350495",
    n.fspiAgentAccountId = "BOFIIE2D-51052432413",
    n.counterpartyAgentAccountId = "ULSBIE2D-437570486",
    n.transactionID = "2299405743564352973",
    n.eventTime = "21/07/2025 10:43:10",
    n.baseValue = 1998.00,
    n.currency = "EUR",
    n.direction = "inbound",
    n.paymentSystem = "10",
    n.settlementMethod = "CLRG",
    n.settlementClearingSystemCode = "PUSSHTRSFR",
    n.paymentMethod = "TRF",
    n.overallScore = null,
    n.riskProfile = "no-risk"
WITH n
CALL (n) {
  OPTIONAL MATCH (AC:AccountEvents {fspiAgentAccountId: "BOFIIE2D-51052432413"})
  WHERE AC.eventId <> n.eventId  // Exclude the current node
  WITH AC ORDER BY AC.eventTime DESC LIMIT 1
  RETURN coalesce(AC.eventId, null) AS prevEventId,
         coalesce(AC.accountEventCounter, 0) + 1 AS accountEventCounter
}
SET n.prevEventId = prevEventId,
    n.accountEventCounter = accountEventCounter
RETURN n;


// Transaction 9 - 2299405743564352974 XXX
// Outbound
MERGE (n:AccountEvents {eventId: "9265405743564350496"})
ON CREATE SET
    n.eventId = "9265405743564350496",
    n.fspiAgentAccountId = "ULSBIE2D-437570486",
    n.counterpartyAgentAccountId = "BOFIIE2D-51052432413",
    n.transactionID = "2299405743564352974",
    n.eventTime = "22/07/2025 15:43:10",
    n.baseValue = 2998.00,
    n.currency = "EUR",
    n.direction = "outbound",
    n.paymentSystem = "10",
    n.settlementMethod = "CLRG",
    n.settlementClearingSystemCode = "PUSSHTRSFR",
    n.paymentMethod = "TRF",
    n.overallScore = null,
    n.riskProfile = "no-risk"
WITH n
CALL (n) {
  OPTIONAL MATCH (AC:AccountEvents {fspiAgentAccountId: "ULSBIE2D-437570486"})
  WHERE AC.eventId <> n.eventId  // Exclude the current node
  WITH AC ORDER BY AC.eventTime DESC LIMIT 1
  RETURN coalesce(AC.eventId, null) AS prevEventId,
         coalesce(AC.accountEventCounter, 0) + 1 AS accountEventCounter
}
SET n.prevEventId = prevEventId,
    n.accountEventCounter = accountEventCounter
RETURN n;
// Inbound
MERGE (n:AccountEvents {eventId: "9265405743564350498"})
ON CREATE SET
    n.eventId = "9265405743564350498",
    n.fspiAgentAccountId = "BOFIIE2D-51052432413",
    n.counterpartyAgentAccountId = "ULSBIE2D-437570486",
    n.transactionID = "2299405743564352974",
    n.eventTime = "22/07/2025 15:43:10",
    n.baseValue = 2998.00,
    n.currency = "EUR",
    n.direction = "inbound",
    n.paymentSystem = "10",
    n.settlementMethod = "CLRG",
    n.settlementClearingSystemCode = "PUSSHTRSFR",
    n.paymentMethod = "TRF",
    n.overallScore = null,
    n.riskProfile = "no-risk"
WITH n
CALL (n) {
  OPTIONAL MATCH (AC:AccountEvents {fspiAgentAccountId: "BOFIIE2D-51052432413"})
  WHERE AC.eventId <> n.eventId  // Exclude the current node
  WITH AC ORDER BY AC.eventTime DESC LIMIT 1
  RETURN coalesce(AC.eventId, null) AS prevEventId,
         coalesce(AC.accountEventCounter, 0) + 1 AS accountEventCounter
}
SET n.prevEventId = prevEventId,
    n.accountEventCounter = accountEventCounter
RETURN n;


// Transaction 10 - 2299405743564352074 XXX
// Outbound
MERGE (n:AccountEvents {eventId: "9265405743564350416"})
ON CREATE SET
    n.eventId = "9265405743564350416",
    n.fspiAgentAccountId = "ULSBIE2D-437570486",
    n.counterpartyAgentAccountId = "BOFIIE2D-51052432413",
    n.transactionID = "2299405743564352074",
    n.eventTime = "23/07/2025 11:43:10",
    n.baseValue = 2907.00,
    n.currency = "EUR",
    n.direction = "outbound",
    n.paymentSystem = "RTPUSHPAY",
    n.settlementMethod = "CLRG",
    n.settlementClearingSystemCode = "RTPay",
    n.paymentMethod = "TRF",
    n.overallScore = null,
    n.riskProfile = "no-risk"
WITH n
CALL (n) {
  OPTIONAL MATCH (AC:AccountEvents {fspiAgentAccountId: "ULSBIE2D-437570486"})
  WHERE AC.eventId <> n.eventId  // Exclude the current node
  WITH AC ORDER BY AC.eventTime DESC LIMIT 1
  RETURN coalesce(AC.eventId, null) AS prevEventId,
         coalesce(AC.accountEventCounter, 0) + 1 AS accountEventCounter
}
SET n.prevEventId = prevEventId,
    n.accountEventCounter = accountEventCounter
RETURN n;
// Inbound
MERGE (n:AccountEvents {eventId: "9265405743564350418"})
ON CREATE SET
    n.eventId = "9265405743564350418",
    n.fspiAgentAccountId = "BOFIIE2D-51052432413",
    n.counterpartyAgentAccountId = "ULSBIE2D-437570486",
    n.transactionID = "2299405743564352074",
    n.eventTime = "23/07/2025 11:43:10",
    n.baseValue = 2907.00,
    n.currency = "EUR",
    n.direction = "inbound",
    n.paymentSystem = "RTPUSHPAY",
    n.settlementMethod = "CLRG",
    n.settlementClearingSystemCode = "RTPay",
    n.paymentMethod = "TRF",
    n.overallScore = null,
    n.riskProfile = "no-risk"
WITH n
CALL (n) {
  OPTIONAL MATCH (AC:AccountEvents {fspiAgentAccountId: "BOFIIE2D-51052432413"})
  WHERE AC.eventId <> n.eventId  // Exclude the current node
  WITH AC ORDER BY AC.eventTime DESC LIMIT 1
  RETURN coalesce(AC.eventId, null) AS prevEventId,
         coalesce(AC.accountEventCounter, 0) + 1 AS accountEventCounter
}
SET n.prevEventId = prevEventId,
    n.accountEventCounter = accountEventCounter
RETURN n;


// Transaction 11 - 3299415743564352074
// Outbound
MERGE (n:AccountEvents {eventId: "9365405743564351416"})
ON CREATE SET
    n.eventId = "9365405743564351416",
    n.fspiAgentAccountId = "BOFIIE2D-51052432413",
    n.counterpartyAgentAccountId = "IPTSIEDD-724570489",
    n.transactionID = "3299415743564352074",
    n.eventTime = "23/07/2025 13:13:10",
    n.baseValue = 12907.00,
    n.currency = "EUR",
    n.direction = "outbound",
    n.paymentSystem = "10",
    n.settlementMethod = "CLRG",
    n.settlementClearingSystemCode = "PUSSHTRSFR",
    n.paymentMethod = "TRF",
    n.overallScore = null,
    n.riskProfile = "no-risk"
WITH n
CALL (n) {
  OPTIONAL MATCH (AC:AccountEvents {fspiAgentAccountId: "BOFIIE2D-51052432413"})
  WHERE AC.eventId <> n.eventId  // Exclude the current node
  WITH AC ORDER BY AC.eventTime DESC LIMIT 1
  RETURN coalesce(AC.eventId, null) AS prevEventId,
         coalesce(AC.accountEventCounter, 0) + 1 AS accountEventCounter
}
SET n.prevEventId = prevEventId,
    n.accountEventCounter = accountEventCounter
RETURN n;
// Inbound
MERGE (n:AccountEvents {eventId: "9365405743564351424"})
ON CREATE SET
    n.eventId = "9365405743564351424",
    n.fspiAgentAccountId = "IPTSIEDD-724570489",
    n.counterpartyAgentAccountId = "BOFIIE2D-51052432413",
    n.transactionID = "3299415743564352074",
    n.eventTime = "23/07/2025 13:13:10",
    n.baseValue = 12907.00,
    n.currency = "EUR",
    n.direction = "inbound",
    n.paymentSystem = "10",
    n.settlementMethod = "CLRG",
    n.settlementClearingSystemCode = "PUSSHTRSFR",
    n.paymentMethod = "TRF",
    n.overallScore = null,
    n.riskProfile = "no-risk"
WITH n
CALL (n) {
  OPTIONAL MATCH (AC:AccountEvents {fspiAgentAccountId: "IPTSIEDD-724570489"})
  WHERE AC.eventId <> n.eventId  // Exclude the current node
  WITH AC ORDER BY AC.eventTime DESC LIMIT 1
  RETURN coalesce(AC.eventId, null) AS prevEventId,
         coalesce(AC.accountEventCounter, 0) + 1 AS accountEventCounter
}
SET n.prevEventId = prevEventId,
    n.accountEventCounter = accountEventCounter
RETURN n;

// Transaction 12 - 2299415743564352074
// Outbound
MERGE (n:AccountEvents {eventId: "9265405743564351416"})
ON CREATE SET
    n.eventId = "9265405743564351416",
    n.fspiAgentAccountId = "ULSBIE2D-437570486",
    n.counterpartyAgentAccountId = "BOFIIE2D-51052432413",
    n.transactionID = "2299415743564352074",
    n.eventTime = "23/07/2025 16:43:10",
    n.baseValue = 5907.00,
    n.currency = "EUR",
    n.direction = "outbound",
    n.paymentSystem = "10",
    n.settlementMethod = "CLRG",
    n.settlementClearingSystemCode = "PUSSHTRSFR",
    n.paymentMethod = "TRF",
    n.overallScore = 0.440,
    n.riskProfile = "review"
WITH n
CALL (n) {
  OPTIONAL MATCH (AC:AccountEvents {fspiAgentAccountId: "ULSBIE2D-437570486"})
  WHERE AC.eventId <> n.eventId  // Exclude the current node
  WITH AC ORDER BY AC.eventTime DESC LIMIT 1
  RETURN coalesce(AC.eventId, null) AS prevEventId,
         coalesce(AC.accountEventCounter, 0) + 1 AS accountEventCounter
}
SET n.prevEventId = prevEventId,
    n.accountEventCounter = accountEventCounter
RETURN n;
// Inbound
MERGE (n:AccountEvents {eventId: "9265405743564352418"})
ON CREATE SET
    n.eventId = "9265405743564352418",
    n.fspiAgentAccountId = "BOFIIE2D-51052432413",
    n.counterpartyAgentAccountId = "ULSBIE2D-437570486",
    n.transactionID = "2299415743564352074",
    n.eventTime = "23/07/2025 16:43:10",
    n.baseValue = 5907.00,
    n.currency = "EUR",
    n.direction = "inbound",
    n.paymentSystem = "10",
    n.settlementMethod = "CLRG",
    n.settlementClearingSystemCode = "PUSSHTRSFR",
    n.paymentMethod = "TRF",
    n.overallScore = 0.220,
    n.riskProfile = "review"
WITH n
CALL (n) {
  OPTIONAL MATCH (AC:AccountEvents {fspiAgentAccountId: "BOFIIE2D-51052432413"})
  WHERE AC.eventId <> n.eventId  // Exclude the current node
  WITH AC ORDER BY AC.eventTime DESC LIMIT 1
  RETURN coalesce(AC.eventId, null) AS prevEventId,
         coalesce(AC.accountEventCounter, 0) + 1 AS accountEventCounter
}
SET n.prevEventId = prevEventId,
    n.accountEventCounter = accountEventCounter
RETURN n;

// Transaction 13 - 3299415743564352071  PROBLEM
// Outbound
MERGE (n:AccountEvents {eventId: "9365405743564351419"})
ON CREATE SET
    n.eventId = "9365405743564351419",
    n.fspiAgentAccountId = "BOFIIE2D-5105243241",
    n.counterpartyAgentAccountId = "IPTSIEDD-527570498",
    n.transactionID = "3299415743564352071",
    n.eventTime = "23/07/2025 15:13:10",
    n.baseValue = 14907.00,
    n.currency = "EUR",
    n.direction = "outbound",
    n.paymentSystem = "RTPUSHPAY",
    n.settlementMethod = "CLRG",
    n.settlementClearingSystemCode = "RTPay",
    n.paymentMethod = "TRF",
    n.overallScore = 0.820,
    n.riskProfile = "risk-no-review"
WITH n
CALL (n) {
  OPTIONAL MATCH (AC:AccountEvents {fspiAgentAccountId: "BOFIIE2D-5105243241"})
  WHERE AC.eventId <> n.eventId  // Exclude the current node
  WITH AC ORDER BY AC.eventTime DESC LIMIT 1
  RETURN coalesce(AC.eventId, null) AS prevEventId,
         coalesce(AC.accountEventCounter, 0) + 1 AS accountEventCounter
}
SET n.prevEventId = prevEventId,
    n.accountEventCounter = accountEventCounter
RETURN n;
// Inbound
MERGE (n:AccountEvents {eventId: "9365405743564352418"})
ON CREATE SET
    n.eventId = "9365405743564352418",
    n.fspiAgentAccountId = "IPTSIEDD-527570498",
    n.counterpartyAgentAccountId = "BOFIIE2D-5105243241",
    n.transactionID = "3299415743564352071",
    n.eventTime = "23/07/2025 15:13:10",
    n.baseValue = 14907.00,
    n.currency = "EUR",
    n.direction = "inbound",
    n.paymentSystem = "RTPUSHPAY",
    n.settlementMethod = "CLRG",
    n.settlementClearingSystemCode = "RTPay",
    n.paymentMethod = "TRF",
    n.overallScore = 0.520,
    n.riskProfile = "risk-no-review"
WITH n
CALL (n) {
  OPTIONAL MATCH (AC:AccountEvents {fspiAgentAccountId: "IPTSIEDD-527570498"})
  WHERE AC.eventId <> n.eventId  // Exclude the current node
  WITH AC ORDER BY AC.eventTime DESC LIMIT 1
  RETURN coalesce(AC.eventId, null) AS prevEventId,
         coalesce(AC.accountEventCounter, 0) + 1 AS accountEventCounter
}
SET n.prevEventId = prevEventId,
    n.accountEventCounter = accountEventCounter
RETURN n;


// Transaction 14 - 3299415743564352075
// Outbound
MERGE (n:AccountEvents {eventId: "9375405743564351416"})
ON CREATE SET
    n.eventId = "9375405743564351416",
    n.fspiAgentAccountId = "BOFIIE2D-51052432413",
    n.counterpartyAgentAccountId = "IPTSIEDD-527570498",
    n.transactionID = "3299415743564352075",
    n.eventTime = "24/07/2025 11:13:10",
    n.baseValue = 4907.00,
    n.currency = "EUR",
    n.direction = "outbound",
    n.paymentSystem = "10",
    n.settlementMethod = "CLRG",
    n.settlementClearingSystemCode = "PUSSHTRSFR",
    n.paymentMethod = "TRF",
    n.overallScore = null,
    n.riskProfile = "no-risk"
WITH n
CALL (n) {
  OPTIONAL MATCH (AC:AccountEvents {fspiAgentAccountId: "BOFIIE2D-51052432413"})
  WHERE AC.eventId <> n.eventId  // Exclude the current node
  WITH AC ORDER BY AC.eventTime DESC LIMIT 1
  RETURN coalesce(AC.eventId, null) AS prevEventId,
         coalesce(AC.accountEventCounter, 0) + 1 AS accountEventCounter
}
SET n.prevEventId = prevEventId,
    n.accountEventCounter = accountEventCounter
RETURN n;
// Inbound
MERGE (n:AccountEvents {eventId: "9365505743564352418"})
ON CREATE SET
    n.eventId = "9365505743564352418",
    n.fspiAgentAccountId = "IPTSIEDD-527570498",
    n.counterpartyAgentAccountId = "BOFIIE2D-51052432413",
    n.transactionID = "3299415743564352075",
    n.eventTime = "24/07/2025 11:13:10",
    n.baseValue = 4907.00,
    n.currency = "EUR",
    n.direction = "inbound",
    n.paymentSystem = "10",
    n.settlementMethod = "CLRG",
    n.settlementClearingSystemCode = "PUSSHTRSFR",
    n.paymentMethod = "TRF",
    n.overallScore = null,
    n.riskProfile = "no-risk"
WITH n
CALL (n) {
  OPTIONAL MATCH (AC:AccountEvents {fspiAgentAccountId: "IPTSIEDD-527570498"})
  WHERE AC.eventId <> n.eventId  // Exclude the current node
  WITH AC ORDER BY AC.eventTime DESC LIMIT 1
  RETURN coalesce(AC.eventId, null) AS prevEventId,
         coalesce(AC.accountEventCounter, 0) + 1 AS accountEventCounter
}
SET n.prevEventId = prevEventId,
    n.accountEventCounter = accountEventCounter
RETURN n;


// Transaction 15 - 3299415743564352175
// Outbound
MERGE (n:AccountEvents {eventId: "9365405843564351416"})
ON CREATE SET
    n.eventId = "9365405843564351416",
    n.fspiAgentAccountId = "BOFIIE2D-51052432413",
    n.counterpartyAgentAccountId = "ULSBIE2D-427570488",
    n.transactionID = "3299415743564352175",
    n.eventTime = "24/07/2025 12:13:10",
    n.baseValue = 32907.00,
    n.currency = "EUR",
    n.direction = "outbound",
    n.paymentSystem = "10",
    n.settlementMethod = "CLRG",
    n.settlementClearingSystemCode = "PUSSHTRSFR",
    n.paymentMethod = "TRF",
    n.overallScore = 0.020,
    n.riskProfile = "review"
WITH n
CALL (n) {
  OPTIONAL MATCH (AC:AccountEvents {fspiAgentAccountId: "BOFIIE2D-51052432413"})
  WHERE AC.eventId <> n.eventId  // Exclude the current node
  WITH AC ORDER BY AC.eventTime DESC LIMIT 1
  RETURN coalesce(AC.eventId, null) AS prevEventId,
         coalesce(AC.accountEventCounter, 0) + 1 AS accountEventCounter
}
SET n.prevEventId = prevEventId,
    n.accountEventCounter = accountEventCounter
RETURN n;
// Inbound
MERGE (n:AccountEvents {eventId: "9365425743564352418"})
ON CREATE SET
    n.eventId = "9365425743564352418",
    n.fspiAgentAccountId = "ULSBIE2D-427570488",
    n.counterpartyAgentAccountId = "BOFIIE2D-51052432413",
    n.transactionID = "3299415743564352175",
    n.eventTime = "24/07/2025 12:13:10",
    n.baseValue = 32907.00,
    n.currency = "EUR",
    n.direction = "inbound",
    n.paymentSystem = "10",
    n.settlementMethod = "CLRG",
    n.settlementClearingSystemCode = "PUSSHTRSFR",
    n.paymentMethod = "TRF",
    n.overallScore = 0.010,
    n.riskProfile = "review"
WITH n
CALL (n) {
  OPTIONAL MATCH (AC:AccountEvents {fspiAgentAccountId: "ULSBIE2D-427570488"})
  WHERE AC.eventId <> n.eventId  // Exclude the current node
  WITH AC ORDER BY AC.eventTime DESC LIMIT 1
  RETURN coalesce(AC.eventId, null) AS prevEventId,
         coalesce(AC.accountEventCounter, 0) + 1 AS accountEventCounter
}
SET n.prevEventId = prevEventId,
    n.accountEventCounter = accountEventCounter
RETURN n;
