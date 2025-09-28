## Synthetic Demographic Data Generator.

Graph based visualising of Synthentic_Demographic_Generator generated data together with Fake Adults, Children, Addresses and Accounts.


So ye, this did not start with this, it was more a lets create a couple of people for the local Locale thats more like real people, families (well it was idea out of my **Neo4J** / **GraphDB** blog).

Ok, In part 1 we created our basic GraphDB model with synthentic data of banks, accounts, corporates, people and their associated information like addresses, mobile devices, land line numbers etc.

In part 2 we added temporal (aka being able to se how a node changed over time, storing versions, referencing the previous version).

This is part 3. So what are we doing here. Well, I'm not sure, a couple of things. 

#1 we previously created a app that creates a synthetic demographic dataset (see Blog). We for that blog posted all data into a single target data store. Firstly I've modified this version so that each of our data products can go into it's own data store.

I've also aligned/extended the cypher commands from ./nodes/* to align with the data created by our python data generator. The app will now create a nice "Synthetic Demographic dataset" representing Ireland.

We can then from here create Kafka sink jobs that will 
We then have our Cypher commands that can create transactions 

To make sure I don't trip over anyone locally looking, having problems with things like PPI/GDPR/PII, I modelled the data as per Ireland. But if you look at the data folder, containing `ie_banks.json` and `ireland.json` you will realise it wont take much to model to your own locale.

At the moment this version will/can post data directly into either a **MongoDB**, **PostgreSQL**, **Redis** or **Kafka**. That is intentional, based on personal requirements, but sure it can be extended to cover other db's. I also added the ability for each of the data products to be created `adults`, `children` and `families` to go into seperate/different data stores.

For the Blog where we will create Node4J nodes for the Python app creating data we will use the app to push data onto our Kafka topics, from where we will use Kafka's connect framework to create the desired nodes.

The app itself is capable of the below however:

**WHY**: well it allows us to say push the `children` to a **Redis** store, the `adults` to **PostgreSql** and `families` to **Kafka**. With this we can then use **Apache Flink CDC** to source the adults from the PostgreSql store and suck it via **Apache Flink**, push it up to **Apache Kafka** and sink it into **Neo4J**. While at the same time pull the data thats published on **Apache Kafka** and pull that into **Apache Flink** also, and similar for **Redis**. 

This will now allow us to sink everything into **Apache Fluss** with a lakehouse configuration of **Apache Paimon** defined for additional analytics, and as we have everything in Kafka we can additionally sink it from there into our **GraphDB** datastore.

Basically, we have options once we bring the power of **Apache Flink's CDC** as a source connector, and **Apache Flink** & **Apache Kafka**'s sink connector frameworks.

NOTE: those that follow my blogs, I've discovered a bug in my previous logger function which has been fixed here, the file_level and console_levels has also been aligned with standards.

BLOG: []()

GIT REPO: [GraphDB_Synthentic_Demographic_Generator](https://github.com/georgelza/GraphDB_Synthentic_Demographic_Generator.git)

**The base environment:**

- `devlab/docker-compose.yml` which can be brought online by executing below, (this will use `.env`).

- `the make run` as defined in `data/Makefile`
  

**The App:** 

To run the Generator, execute (from root directory):

- `python3 -m venv ./venv`

- `source venv/bin/activate`

- `pip install --upgrade pip`

- `pip install -r requirements`

- cd nodes
- 1.*
- 2.*
- .. ->

- `run.sh` will use `.pws` for passwords etc. 


**Data Flow/Stream**

We'll be decomposing them, or is that mapping them to Apache Flink Tables (we'll use Flink CDC to ingest data from the PostgreSQL datastore), from where we will push the data products into:

#1 Confluent Kafka and onto wards to Neo4J


### Data structures used:

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

**Core**
    mobile_devices
    landline_numbers
    address_ie -> We create these associating with the ireland meographic data set/frame set created below.
    drivers Licenses
    ISP's
    Sessions
    eMails

**Ireland and Banks**

- The Ireland synthetic demographic dataset is first loaded by loading ireland.json as nodes and then creating the associated edges.
- Next up is loading our banks by loading ie_banks.json. these banks are then used when we run the application, in combination to the above ireland demographic data set.



**MISC**
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
