// Where they share the same parcel_id


// Children
// One way of setting property on relationship is using triggers
:use system;
CALL apoc.trigger.install(
  'neo4j',
  'createChildrenLivesAtAddress_chldside',
  'UNWIND $createdNodes AS chld
   WITH chld WHERE chld.parcel_id IS NOT NULL
   MATCH (addr:address {parcel_id: chld.parcel_id})
   MERGE (chld)-[r:LIVES_AT]->(addr)
   ON CREATE SET r.parcel_id: addr.parcel_id',
  {phase: 'after'}
);


// Another way of setting property on relationship is using triggers
CALL apoc.trigger.install(
  'neo4j',
  'createChildrenLivesAtAddress_addrside',
  'UNWIND $createdNodes AS addr
   WITH addr WHERE addr.parcel_id IS NOT NULL
   MATCH (addr:address {parcel_id: chld.parcel_id})
   MERGE (chld)-[:LIVES_AT {parcel_id: addr.parcel_id}]->(addr)',
  {phase:'after'}
);


// Adults
// One way of setting property on relationship is using triggers
CALL apoc.trigger.install(
  'neo4j',
  'createAdultLivesAtAddress_adltside',
  'UNWIND $createdNodes AS adlt
   WITH adlt WHERE adlt.parcel_id IS NOT NULL
   MATCH (addr:address {parcel_id: adlt.parcel_id})
   MERGE (adlt)-[:LIVES_AT]->(addr)
   ON CREATE SET r.parcel_id: addr.parcel_id',
  {phase: 'after'}
);


// Another way of setting property on relationship is using triggers
CALL apoc.trigger.install(
  'neo4j',
  'createAdultLivesAtAddress_addrside',
  'UNWIND $createdNodes AS addr
   WITH addr WHERE addr.parcel_id IS NOT NULL
   MATCH (addr:address {parcel_id: adlt.parcel_id})
   MERGE (adlt)-[:LIVES_AT {parcel_id: addr.parcel_id}]->(addr)',
  {phase:'after'}
);


// notice the {} property that we're setting on the edge/link
:use neo4j;
MATCH (chld:Children )
MATCH (addr:Address)
WHERE chld.parcel_id = addr.parcel_id
MERGE (chld)-[:LIVES_AT {parcel_id: addr.parcel_id}]->(addr);

// Adults
// notice the ON CREATE SET
MATCH (adlt:Adults)
MATCH (addr:Address)
WHERE adlt.parcel_id = addr.parcel_id
MERGE (adlt)-[r:LIVES_AT {parcel_id: addr.parcel_id}]->(addr);


:use system;
// CALL apoc.trigger.show('neo4j');
// CALL apoc.trigger.drop('neo4j', 'triggerName');

:use neo4j;
// TO remove all LIVES_AT edges
// MATCH p=()-[r:LIVES_AT]->() DETACH DELETE r;

