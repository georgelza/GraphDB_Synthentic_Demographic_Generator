// Where they share the same parcel_id


// Adults with Credit Cards
// One way of setting property on relationship is using triggers
:use system;
CALL apoc.trigger.install(
  'neo4j',
  'createAdultHaveCard_adltside',
  'UNWIND $createdNodes AS adlt
   MATCH (cc:Card)
   WHERE cc.cardNumber IS NOT NULL and adlt.nationalId = cc.nationalId
   MERGE (adlt)-[r:HAVE_CARD]->(cc)
   ON CREATE SET r.nationalId = cc.nationalId, r.cardNumber = cc.cardNumber, r.cardNetwork = cc.cardNetwork',
  {phase: 'after'}
);


// Another way of setting property on relationship is using triggers
CALL apoc.trigger.install(
  'neo4j',
  'createAdultHaveCard_accside',
  'UNWIND $createdNodes AS cc
   MATCH (adlt:Adults)
   WHERE cc.cardNumber IS NOT NULL and adlt.nationalId = cc.nationalId
   MERGE (adlt)-[r:HAVE_CARD {nationalId: cc.nationalId, cardNumber: cc.cardNumber, cardNetwork: cc.cardNetwork}]->(cc)',
  {phase:'after'}
);


// notice the ON CREATE SET
:use neo4j;

MATCH (adlt:Adults)
MATCH (cc:Card)
WHERE cc.cardNumber IS NOT NULL and adlt.nationalId = cc.nationalId
MERGE (adlt)-[r:HAVE_CARD {nationalId: cc.nationalId, cardNumber: cc.cardNumber, cardNetwork: cc.cardNetwork}]->(cc);


//:use system;
// CALL apoc.trigger.show('neo4j');
// CALL apoc.trigger.drop('neo4j', 'triggerName');

//:use neo4j;
// TO remove all HAVE_CARD edges
// MATCH p=()-[r:HAVE_CARD]->() DETACH DELETE r;
