## Synthetic Demographic Data Generator.


This is still called Fraud Analytics as thats the larger use case I'm exploring, but what we are demonstrating is generic use. This blog is not going to be showing you Funky Graph images, or example after example. It's here to be a building blog, of capability, of options, of tools available to the user.

Overview

So ye, this did not start with this, it was more a lets create a couple of people for the local Locale thats more like real people, families (well it was idea out of my [Neo4J](https://neo4j.com/) / **GraphDB** blog).

This is part 3 of a series… not yet sure how many parts there will be.

- In [part 1](https://medium.com/@georgelza/fraud-analytics-using-a-different-approach-graphdb-data-platform-part-1-807c68d03bff) we explored how to push data into a GraphDB platform (build using Neo4J) as a graph based data model using the cypher language.

- In [part 2](https://medium.com/@georgelza/fraud-analytics-using-a-different-approach-graphdb-data-platform-part-2-b7f69d872192) we took the transaction data and added a lineage component to it, also called temporarily, all just fancy words for we link the previous transaction to the next to show the transactions for an account.

This is [part 3](https://medium.com/@georgelza/fraud-analytics-using-a-different-approach-graphdb-data-platform-part-3-b24a833d22be). So what are we doing here. Well, I'm not sure, a couple of things, it changed a couple of times along the way... ;) 

After part 1 and 2, I created a "little" Python application to create synthetic demographic data for us, at volume, all driven by a couple if JSON configuration/seed files.

See: [Synthetic Demographic Data Generator](https://github.com/georgelza/Synthentic_Demographic_Generator).

Let's face it, we're not going to load our data/create nodes by hand using the Cypher language and we're not going to create the edges/links by hand.

We also don't want to dump our real world data to flat files and then load them manually, so what are we to do.

Well, we're in the world of real time streaming data now, and anything batch based is old school, to old, out of date to be effective to prevent i.e.: fraud, or to prevent a machine from failing due to some upstream problems.

So how do we take our stream of data and get it into our GraphDB (based on [Neo4J](https://neo4j.com/)) in real time… and create the edges/links… as data arrives.

Well this is what we will explore here.

In this blog we will take our basic Graph concepts & capabilities as discussed in the previous blogs, and bring them closer to the real world. We will now make this slightly dynamic, consuming our inbound data from our Kafka topics using the Kafka Connect Framework, then sinking the data into our Neo4J data store, thus creating nodes as data arrive, all while creating our edges/links in real time using trigger events.

Our Data flowThe GIT Repo: [GraphDB Synthetic Demographic Generator](https://github.com/georgelza/GraphDB_Synthentic_Demographic_Generator.git) contains the project code.

I intend to show a couple of things learned, along the way, different ways to accomplish what we want, and as always a little off the beaten track, from 101 common level examples out on the internet.

As per the previously blog, we created an Python application that creates a synthetic demographic dataset (see Blog). The application itself is capable of storing the generated data in:

- Kafka,
- PostgreSQL
- Redis
- MongoDB

The app creates a nice "Synthetic Demographic dataset" representing Ireland, based on our 4 provinces, multiple counties containing towns which have neighbourhoods. Similar we will create some of the most popular Irish banks and branches for them.

To make sure I don't trip over anyone locally looking, having problems with things like PPI/GDPR/POPI. I modelled the data as per Ireland, hey, I have Irish ancestry so why not ;).

But if you look at the data folder, containing `ie_banks.json` and `ireland.json` you will realise it won't take much to model to your own locale.

I've aligned the application generated records to match the records from our previous blog where we manually created nodes using our raw cypher commands, these can be found in `devlab/nodes/*` and `devlab/edges/*`.

Basically, we're using the same Banks, provinces, counties & towns (and their associated codes) etc.

As mentioned previously this version can post data directly into either a **MongoDB**, **PostgreSQL**, **Redis** or **Kafka**. This is intentional, based on personal requirements, or make that to attract the attention of a friend (PS, PostgreSQL here also means **Cockroach DB** as its fully **PostgreSQL** line compatible). It can of course easily be extended to cover other databases.

For this blog we will however only publish messages/payloads onto Kafka topics.

**NOTE**: those that followed my blogs, I've discovered a bug in my previous Python logger function which has been fixed here, the file_level and console_levels has also been aligned with public standards.

**WHY** all of this, you ask, well, the world is not always wrapped in a nice ribbon, with all our data coming via a single source. We need to be able to consume our data products where ever they are.

This is where products like [Apache Flink](https://flink.apache.org/) with its native  [CDC](https://nightlies.apache.org/flink/flink-cdc-docs-stable/)(Change data capture) capability helps us, allowing us to source data where it is stored, i.e.: our PostgreSQL, allowing us to injest the data, ensuring we can QA the  source data first, then enrich it, followed publishing to Apache Kafka topics, for consumption by others.

Next we utilise a technology like the [Kafka Connect Framework](https://www.confluent.io/lp/confluent-connectors/) to sink those records onto **Neo4J**, creating our nodes as the output of an automated stream.

Now we have many more ways to source our data, we can also push/store it directly into Neo4J using the various API's available using languages like i.e. Python. But in the end, we want to make data available as fast as possible, available as widely as possible.

Data follows a simple rule, the more people that use data products created the more valuable that data becomes to business.
For this Blog, we will be publishing payloads comprised out of complex JSON onto 3 Kafka topics:

- Families (which we currently do nothing with),
- Children
- Adults

See `<project root>/examples` for examples of these payloads.

- adults.json
- children.json
- families.json


The `Children` and `Adults` payloads both contain an `Address` record, this we will extract, creating `Address` nodes.
Next the `Adults` topics payload include a tag called `Account` which is an array or records, interestingly a structure I found very few example of online, that actually demonstrate how to work with.

We will be creating 6 Kafka Connect sink jobs, to create our nodes based on the inbound payloads from these topic.
For this we will consume our topics: `Adults` and `Children` into multiple nodes types.

First we will create the `Children` nodes, to ensure we don't create duplicate records we've defined a unique constraint on the nationalId property using a constraint created. See: `devlab/constraints/general.cypher`.

Next we will extract the `Address` from the `Children` payload into `Address` nodes, using a merge statement. This will either create the `Address` node if it does not exist or update if already existing. We also ensure that each `Address` is only created once using a unique index. This unique index create is again shown in the above general.cypher script.

Next we will consume the `Adults` topic. We will first create the `Address` nodes from the `address` tag, again using merge syntax, again, this will either create the node if not existing or update if already present. We're also again ensuring we're not creating duplicate `address` nodes by having our previously created unique constraint on the addr`ess node.

Next (and this is where things got interesting) we will unwind the `account` tag present in the `Adults` payload, which is an array of records. We'll create either a bank `Accounts` node, for each record in the array, if the bank `accountId` is provided, otherwise we will create `Card` node, if the `cardnumber` is provided. The account tag contains an array of records, each record containing either the detail of a bank `account` or credit `card`.

At this point we will define triggers to create edges/links on the above created nodes created from data received from our inbound topics.

Ok, so here I discovered something, as we're creating the edge/links between an `Adults` node and an `Address` node, we might have the situation that we create the `Adults` node, but the `Address` node where the adult lives does not exist yet, this means we now need to create the link only once the `Address` node is created.

This require us to have a trigger on the latter. But now the curve ball, this all can happen in reverse.
We could end in the scenario where the `address` node was created first, the trigger fired, but the `adult` node did not exist yet… So for this example we now need the trigger on the `adult` node, to create the edge/link when the `adult` node is created. This all resulted in 2 triggers being required.

A similar pattern was created for `Children` and `Address` nodes, and `Adults` and `Accounts` and `Adults` and `Cards`.
Thus ensuring irrespective of which Kafka topic payload created a node first or last, we will always get an edge/link added.

Below I show one of the Kafka Sink jobs and the associated Cypher to execute the above.

We create the Kafka Sink jobs using 2 files, first is a shell/script file and the second is our Cypher syntax that is executed when new data arrives on the configured topic.

All these can be found in `<project root>/devlab/creConnect` directory.

Also shared, in the `devlab/creConnect/v1` sub-directory, is a set of scripts that by all rights should have worked, but did not… I'm simply sharing these to demonstrate how a very small change made resulted in a big difference. Well, it made it work, repeatedly.

The stranger fact here, using the v1 pattern I had some sinks jobs consuming messages from our Kafka topics that operated successfully, but then others that did not, which means it's not a production dependable solution.

This was eventually resolved with the help of MichaelD from Neo4J fame, well, in truth, he provided the entire solution… and I beggingly asked, pleeeasseee help, I'm going mad here …. ;)

To execute all the shell scripts to deploy sink jobs that will create our Neo4J nodes see the `devlab/creConnect/deploy.sh`.

To create the triggers that will create our edge/links see: `devlab/creEdges/README.md`.

We'll be using the cypher-shell cli and the `:source` pattern/command.
See: `devlab/creEdges/README.md`

While in our `<project root>/devlab`, execute:
`make cypher`

This will open a cypher-shell terminal in our Neo4J container, after which we can copy/pasting the name of the 3 files located in devlab/creEdges into the terminal.

`:source /cypher/create_LivesAt_edge_trigger.cypher`

The above script, as an example will first create a trigger for us, instructing the system to create an edge/link when a new node is created.

After we've build/instantiated this trigger, we want to create edges/links for all nodes that are already pre-existing.

Now, what's still coming. Well, nothing is complete today if we're not using AI and AI is built on first embedding your data (calculating a vector representation of it using a AI model), and then storing those embeddings as vectors in a vector capable database, which Neo4J just so happen to be able to do.

The series is not complete. You will notice in the `README.md` I have some more rabbit hole to explore.

Thanks for following. Till next time.

This BLOG: [](https://medium.com/@georgelza/fraud-analytics-using-a-different-approach-graphdb-data-platform-part-3-b24a833d22be)



### Standing Up the environment

- We will run the services as defined in `devlab/docker-compose.yml` which can be brought online by executing below commands, (this will use `devlab/.env` file for the various variables required).

  - the `make run` as defined in `data/Makefile`
  

**NOTE**: you first need to pull and the various Kafka images and build the custom connect container and pull Neo4J base containers , this is done by executing: 

  - `make build` in the `<project root>/infrastructure`


### The App


To run the Generator, execute (from `<project root>` directory):

Prepare Python environment:

- `python3 -m venv ./venv`

- `source venv/bin/activate`

- `pip install --upgrade pip`

- `pip install -r requirements`


Now execute:

- First, next make sure you've execited `make run` from the `<project root>/devlab`, to start all our containers.

- Next execute `<project root>/run.sh` which will use `.pws` for passwords and various other variables etc. 

Have it run a couple of lines and then Control C to kill.


### Our Data structures / data products

Below are some of the data structures used along the way, Also see the `app/option_lists.py` for various structures and weightings.


**Adults:**
    Name
    Surname
    Genders
    DOB
    National Identity Number (i.e; PPS, SSN ZA ID Number)
    Account
    Marital Status
    Status (Living/Deceased)
    Address


**Children:**
    Name
    Surname
    Genders
    DOB
    National Identity Number (i.e; PPS, SSN ZA ID Number)
    Father 
    Mother
    Address


**Family's:**
    Husband
    Wife
    Kids
    Address


**Addresses:**
    Country
        Provinces
            Counties
                Towns/Cities
                    Streets 1
                    Streets 2
                    Neighbrouhoods
                    Postal Code
                    parcel_id

**Banks:**
    fspiId
    memberName
    displayName
    bicfiCode
    swiftCode
    ibanCode
    memberNo
    sponsoredBy
    branchStart
    branchEnd
    card_network
    headquarters
    branches
    Account Types
        Current Accounts
        Savings/Deposit
        Cheque Accounts
        Business Accounts




**Ireland and Banks**

- The **Ireland** synthetic demographic dataset is first loaded by loading `ireland.json` as nodes and then creating the associated edges.

- Next up is loading our banks by loading `ie_banks.json`. these banks are then used when we run the application, in combination to the above Ireland demographic data set.


This is all done via the scripts in the <project root>/data directory.


### MISC

If you want to... Execute the scripts from the nodes/edges and constraints directories as per below.

In the `<project root>/devlab/nodes` and `<project root>/<devlab>/devlab/edges` & `<project root>/<devlab>/constraints` directories


This will build nodes for:

    Continents
    Classification Blocks
    Countries
        Africa
        North Ameria
        South America
        Europe
        Oceana
        Antartica


**By: George Leonard**
- georgelza@gmail.com
- https://www.linkedin.com/in/george-leonard-945b502/
- https://medium.com/@georgelza



**More Reading re Neo4J, AI, ML, RAG etc.**

https://towardsdatascience.com/graphrag-in-action/

https://neo4j.com/blog/developer/agentic-ai-with-java-and-neo4j/?utm_source=LinkedIn&utm_medium=OrganicSocial&utm_content=AT_AOdevblog
https://neo4j.com/blog/developer/genai-powered-song-finder/
https://neo4j.com/blog/developer/graphrag-pure-cypher/


https://neo4j.com/developer/industry-use-cases/finserv/
https://neo4j.com/developer/industry-use-cases/finserv/retail-banking/transaction-monitoring/transaction-monitoring-introduction/
https://neo4j.com/developer/industry-use-cases/data-models/transactions/transactions-base-model/
