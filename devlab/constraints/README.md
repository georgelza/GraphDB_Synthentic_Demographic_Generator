## Indexes always help, (NOT)

Indexes are a useful tool, and like any tool can be used for good performance improvements but can also be used incorrectly.

A easy good place to use them on are the key's used during a `MERGE` statement for nodes.

Consider the following cypher `MERGE` statement.

We should add a unique index on `fspiId`. 

These can be executed by executing `make cypher` in `<project root>/devlab` followed by pasting into the presented cli `:source /constraints/<scriptName>.cypher`


### Misc Notes

```cypher
MERGE (n:Bank { fspiId: "ULSBIE2D"})
ON CREATE SET n = {
    fspiId: "ULSBIE2D",
    fspiAgentId: "ULSBIE2D",
    memberName: "Ulster Bank Ireland DAC",
    displayName: "UBI",
    bicfi: "ULSBIE2D", 
    memberNo: "210004", 
    sponsoredBy: "210004", 
    branchStart: 440000, 
    branchEnd: 449999, 
    swiftCode:  "ULSBIE2D"
}
```


### Example of Index Creates for Nodes

Unique Constraint on Bank.fspiId nodes.

```cypher
CREATE CONSTRAINT bank_node_fspiId_uidx IF NOT EXISTS
FOR (a:Bank) 
REQUIRE a.fspiId IS UNIQUE;
```

Standard Index for Bank.swiftCode

```cypher
CREATE INDEX bank_node_swiftCode_idx IF NOT EXISTS
FOR (b:Bank) 
ON b.swiftCode;
```

Only in commercial edition, forces uniquecness and ensures value is specified, acts as a not null on the property.

```cypher
CREATE CONSTRAINT Address_node_parcel_uidx IF NOT EXISTS
FOR (a:Address) 
REQUIRE (a.parcel_id) IS NODE KEY;
```

### Example of Index Creates for Edges

Unique constraints on eventId for both relationship types (edges), This ensures each event ()edge is processed only once.

```cypher
CREATE CONSTRAINT eventId_unique_paid 
FOR ()-[r:PAID_FUNDS_TO]-() 
REQUIRE r.eventId IS UNIQUE;

CREATE CONSTRAINT eventId_unique_received 
FOR ()-[r:RECEIVED_FUNDS_FROM]-() 
REQUIRE r.eventId IS UNIQUE;
```

Verify/Show indexes are created

```cypher
SHOW INDEXES;
SHOW CONSTRAINTS;
```