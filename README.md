## Synthetic Demographic Data Generator.

Graph based visualising of Synthentic_Demographic_Generator generated data together with Fake Adults, Children, Addresses and Accounts.


So ye, this did not start with this, it was more a lets create a couple of people for the local Locale thats more like real people, families (well it was idea out of my **Neo4J** / **GraphDB** blog).

Ok, In **part 1** we created our basic GraphDB model with synthentic data of banks, accounts, corporates, people and their associated information like addresses, mobile devices, land line numbers etc.

In **part 2** we added temporal (aka being able to se how a node changed over time, storing versions, referencing the previous version).

This is **part 3**. So what are we doing here. Well, I'm not sure, a couple of things, it changed a couple of times along the way... ;) 

In our previusly blog we manually created the nodes using cypher `MERGE` statements followed by using `MERGE` statements again to create our edges/links. This was to show the power of **Neo4J** as a **GraphDB** and what we have available to work with, the power.

In this blog we will take those concepts one step further, we will now make this dynamic, using inbound data as a stream via Kafka topics, together with automated creation of our edges/links using triggers.

I intend to show a couple of things learned, different ways to accomplish what we want, and as always a little off the beaten track of same 101 level examples.

We will be publishing messages containing complex **JSON** onto **Kafka** topics, the `Families` (which we currently do nothing with), `Children` and `Adults` containing a `Address` tag, this we need to be extracted, we then have the `Adults` topic containing a field called `Cccounts` which is an array or records, something I found very few examples out on the internet actually demostrate.

See `<project root>/examples` for examples of these payloads.

We will be creating various Kafka Connect sink jobs creating our nodes on the inbound data from these topic.
For this we will consume our topics: `Adults` and `Children` into multiple nodes.

- First we will extract the `Address` from the `Children` topic into `Address` nodes, using a merge, that will either create the node if not exist or update if already exist.

- Second we will create the `Children` nodes.

- Next we will consume the `Adults` topic into nodes, first, again creating similar `Adderess` nodes, again using a merge, that will either create the node if not exist or update if already exist.
  
- Next we will unwind the `Account` tag, which is an array of records. Creating bank `Accounts` nodes, if the bank `accountId` is provided, otherwise we will create `Card` nodes, if the `cardnumber` is provided.

- At this point we will define triggers to create edges/links on the above inbound topics as data is consumed after which we will manually create/add edges/links on already present data.

To accommodate data arriving last on the `Address` node or last on the `Children` node we will use two triggers, one on the `Children` node and one on the `Address` node, similar pattern will be followed for the `Adults` and `Address`, `Adults` and `Accounts` and `Adults` and `Card` nodes. Thus ensuring irrespective of which Kafka topic payload created a node first or last, we will always get a edge/link added.

I also show in the `<project root>/devlab/creConnect` the working version of shell and cypher scripts and then in the `v1` directory, a set of scripts that by all rights should have worked, but did not... simply showing how a small change resulted in a big difference. This was resolved with the help of MichaelD from Neo4J fame.

- To execute all the shell scripts to create our nodes see the `devlab/creConnect/deploy.sh`.

- To create the Edges see devlab/creEdges. These cypher scripts can also be executed indivdually using a `Makefile` command, see `devlab/Makefile`, the constraints option or by using the `cypher-shell` cli and the `:source` pattern. See `devlab/creEdges/README.md`


In a previously blog we created anapplication that creates a synthetic demographic dataset (see Blog []). For that blog posted all data into a single target data store. I've modified this version so that each of our data products can go into it's own data store (As per a earlier blog in my serious, not all data comes nicely package all via your one magical source). 

This is a capability of our Python Application, now able to post onto **Kafka**, **PostgreSQL**, **Redis** or **MongoDB**.

I've also aligned/extended the cypher commands from ./nodes/* to align with the data created by our python data generator. The app will now create a nice "Synthetic Demographic dataset" representing Ireland, 4 provinces, multiple counties containing towns which have neighbourhoods. Similar we will create some of the most popular Irish banks and branches for them.


To make sure I don't trip over anyone locally looking, having problems with things like PPI/GDPR/PII. I modelled the data as per Ireland, hey, I'm part Irish so allowed to ;). 

But if you look at the data folder, containing `ie_banks.json` and `ireland.json` you will realise it wont take much to model to your own locale.

At the moment this version can post data directly into either a **MongoDB**, **PostgreSQL**, **Redis** or **Kafka**. That is intentional, based on personal requirements, or make that to attract the attention of a friend (PS, **PostgreSQL** here also means **CockroachDB** as it's fully **PostgreSQL** line compatible). It can of course easily be extended to cover other db's. For this blog it will all go onto **Kafka** topics however.

**WHY**: well it allows us to say push the `children` to a **Redis** store, the `adults` to **PostgreSql** and `families` to **Kafka**. With this we can then use a streaming/batch engine like **Apache Flink CDC** to source the adults from the **PostgreSql** store and suck it via **Apache Flink**, push it up to **Apache Kafka** after some data manipulation, and sink it onto **Neo4J** as per this blog. 


NOTE: those that follow my blogs, I've discovered a bug in my previous logger function which has been fixed here, the file_level and console_levels has also been aligned with public standards.


This BLOG: []()

GIT REPO: [GraphDB_Synthentic_Demographic_Generator](https://github.com/georgelza/GraphDB_Synthentic_Demographic_Generator.git)


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
