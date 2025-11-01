## Notes

Here we will create the Edge/links between the nodes created as part of the streaming process of nodes being created via the creConnect node create sink jobs.


1.create_LivesAt_edge_trigger.cypher
2.create_HaveAccount_edge.cypher
3.create_HaveCreditCard_edge.cypher


## Managing Triggers

### List Triggers

:use system;
CALL apoc.trigger.show('neo4j');


### Remove Triggers

:use system;
CALL apoc.trigger.drop('neo4j', 'triggerName');


### Remove specified edge/link

:use neo4j;
MATCH p=()-[r:LIVES_AT]->() DETACH DELETE r;
