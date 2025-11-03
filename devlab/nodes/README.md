## Cypher commands to build basic nodes to see all fit together.

Execute Order:

- 0.ireland.cypher
- 1.banks_ie.cypher
- 6.continents.cypher
- 6.1*.countries_*.cypher

These can be executed by executing `make cypher` in `<project root>/devlab` followed by pasting into the presented cli `:source /nodes/<scriptName>.cypher`

We now first need to run the Python application to generate some data, followed by defining/creating the Kafka connect sink jobs as per `<project root>/devlab/creConnect/*`.


### Misc Notes

- -> Next execute  constraints/constraints.cypher

- -> Then execute the edges/* after which you can return here. 

