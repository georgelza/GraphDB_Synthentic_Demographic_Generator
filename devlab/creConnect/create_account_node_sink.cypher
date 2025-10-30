WITH event as data
UNWIND data.account AS account
WITH data, account WHERE account.accountId IS NOT NULL
MERGE (acc:Account {accountId: account.accountId, fspiId: account.fspiId})
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