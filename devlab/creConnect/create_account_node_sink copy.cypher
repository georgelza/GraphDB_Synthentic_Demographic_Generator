WITH event as data
UNWIND data.account AS account
MERGE (acc:Account {fspiAgentAccountId: account.fspiAgentAccountId})
ON CREATE SET acc += {
  nationalid:   data.nationalid,
  accountId:    account.accountId,
  fspiId:       account.fspiId,
  fspiAgentId:  account.fspiAgentId,
  accountType:  account.accountType,
  memberName:   account.memberName,
  cardHolder:   account.cardHolder,
  cardNumber:   account.cardNumber,
  expDate:      account.expDate,
  cardNetwork:  account.cardNetwork,  
  issuingBank:  account.issuingBank,
  createdAt:    timestamp()
}
ON MATCH SET acc += {
  accountId:    account.accountId,
  fspiId:       account.fspiId,
  fspiAgentId:  account.fspiAgentId,
  accountType:  account.accountType,
  memberName:   account.memberName,
  cardHolder:   account.cardHolder,
  cardNumber:   account.cardNumber,
  expDate:      account.expDate,
  cardNetwork:  account.cardNetwork,
  issuingBank:  account.issuingBank,
  updatedAt:    timestamp()
}

WITH event AS data

UNWIND data.account AS account

MERGE (acc:Account {fspiAgentAccountId: account.fspiAgentAccountId})
ON CREATE SET
  acc.nationalid = data.nationalid,
  acc.accountId = account.accountId,
  acc.fspiId = account.fspiId,
  acc.fspiAgentId = account.fspiAgentId,
  acc.accountType = account.accountType,
  acc.memberName = account.memberName,
  acc.cardHolder = account.cardHolder,
  acc.cardNumber = account.cardNumber,
  acc.expDate = account.expDate,
  acc.cardNetwork = account.cardNetwork,
  acc.issuingBank = account.issuingBank,
  acc.createdAt = timestamp()
ON MATCH SET
  acc.updatedAt = timestamp()