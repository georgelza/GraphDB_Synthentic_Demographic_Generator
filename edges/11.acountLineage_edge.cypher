// Temporarl/Time based linking of accountEvents to an previous accountEvent.
//
// Now we're linking n+1 to n with a previous and it as label=PREVIOUS_ACCOUNTEVENT, this is all based on eventId => prevEventId
// prevEventId is determined/build at the time of the accountEvent Merge load, see nodes/10.AccEvents.cypher

MATCH (aec:AccountEvents)
MATCH (aep:AccountEvents)
WHERE aec.eventId = aep.prevEventId 
MERGE (aep)-[:PREVIOUS_ACCOUNTEVENT]->(aec);
