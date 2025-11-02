// Where they share the same parcel_id


// Adults with Accounts
// One way of setting property on relationship is using triggers
:use system;
CALL apoc.trigger.install(
  'neo4j',
  'createAdultHaveAccount_adltside',
  'UNWIND $createdNodes AS adlt
   MATCH (acc:Account)
   WHERE acc.accountId IS NOT NULL and adlt.nationalId = acc.nationalId
   MERGE (adlt)-[r:HAVE_ACCOUNT]->(acc)
   ON CREATE SET r.nationalId = acc.nationalId, r.accountId = acc.accountId, r.memberName = acc.memberName',
  {phase: 'after'}
);


// Another way of setting property on relationship is using triggers
CALL apoc.trigger.install(
  'neo4j',
  'createAdultHaveAccount_accside',
  'UNWIND $createdNodes AS acc
   MATCH (adlt:Adults)
   WHERE acc.accountId IS NOT NULL and adlt.nationalId = acc.nationalId
   MERGE (adlt)-[r:HAVE_ACCOUNT {nationalId: acc.nationalId, accountId: acc.accountId, memberName: acc.memberName}]->(acc)',
  {phase:'after'}
);


// notice the ON CREATE SET
:use neo4j;

MATCH (adlt:Adults)
MATCH (acc:Account)
WHERE acc.accountId IS NOT NULL and adlt.nationalId = acc.nationalId
MERGE (adlt)-[r:HAVE_ACCOUNT]->(acc);


//:use system;
// CALL apoc.trigger.show('neo4j');
// CALL apoc.trigger.drop('neo4j', 'triggerName');

//:use neo4j;
// TO remove all HAVE_ACCOUNT edges
// MATCH p=()-[r:HAVE_ACCOUNT]->() DETACH DELETE r;
