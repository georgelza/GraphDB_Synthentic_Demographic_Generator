## How To

Well I can say go read the root README.md, but as you're here... ;)... and well, full disclosure, there is allot more in that file than really required, so lets go.


cd for us to `<project root>/infrastructure/connect`, followed by excuting `make pull` and then `make build` then come back here.

Now lets bring up our stack by executing:

`cd devlab`
`make run`

We can now prep our Python application and create a small set of data.

We start by cd'ing to the <project root> directory again if you not there,
then copy/paste the following commands into your terminal.

`python3 -m venv ./venv`

`source venv/bin/activate`

`pip install --upgrade pip`

`pip install -r requirements`

Now execute to `run.sh` shell file, let it run for say 10 lines then control C.

Now lets start playing **Neo4J...**

First we're going to create our Basic nodes. This can be done by executing the below commands, while located in the devlab directory.

`cd devlab`
`make creNodes`

Next up we want to create some Links/edges for the data created above.
For this we're going to execute some cypher commands, this will be done using the `cypher-shell` cli.

Our `cypher-shell` we'll be usingis part of our neo4j docker container.  

To execute our cypher scripts (these are mounted into our container into the `cypher` directory), locally they are in `devlab/creEdges/` if you want to have a look. Please execute:

`make cypher`

Once inside the `cypher-shell` cli copy/paste the following lines into the prompt and hit enter one by one.

```cypher
:source /cypher/1.create_LivesAt_edge_trigger.cypher
:source /cypher/2.create_HaveAccount_edge.cypher
:source /cypher/3.create_Card_edge.cypher
```

The above would have created some `Adults`, `Children`, `Addresses`, Bank `Accounts` and Credit `Cards`.

And I think this is where we will end this Blog. Next up we will bring in some AI embedding using the Neo4J Graph Neurol Networking capabilities to compute embeddings and store them into the nodes as vectors.
