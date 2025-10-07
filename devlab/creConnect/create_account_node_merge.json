MERGE (t:Accounts {fspiAgentAccountId: event.fspiAgentAccountId}) 
ON CREATE SET t += {
  fspiAgentAccountId: event.fspiAgentAccountId, 
  accountId: event.accountId, 
  fspiId: event.fspiId, 
  fspiAgentId: event.fspiAgentId, 
  accountType: event.accountType, 
  memberName: event.memberName
} 
ON MATCH SET t += {
  accountId: event.accountId, 
  fspiId: event.fspiId, 
  fspiAgentId: event.fspiAgentId, 
  accountType: event.accountType, 
  memberName: event.memberName
}
