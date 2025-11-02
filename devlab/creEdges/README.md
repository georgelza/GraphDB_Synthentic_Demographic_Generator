## Notes

Here we will create the Edge/links between the nodes created as part of the streaming process of nodes being created via the `<root directory>/devlab/creConnect` node create sink jobs.


```cypher
create_LivesAt_edge_trigger.cypher
create_HaveAccount_edge.cypher
create_HaveCreditCard_edge.cypher
```

These could be executed in the `cypher-shell` cli using the `:source <file> syntax`.


## Managing Triggers

### List Triggers

```cypher
:use system;
CALL apoc.trigger.show('neo4j');
```

### Remove Triggers

```cypher
:use system;
CALL apoc.trigger.drop('neo4j', 'triggerName');
```

### Remove specified edge/link

```cypher
:use neo4j;
MATCH p=()-[r:LIVES_AT]->() DETACH DELETE r;
```