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
  createdAt:    timestamp()
}
ON MATCH SET acc += {
  accountId:    account.accountId,
  fspiId:       account.fspiId,
  fspiAgentId:  account.fspiAgentId,
  accountType:  account.accountType,
  memberName:   account.memberName,
  updatedAt:    timestamp()
}
