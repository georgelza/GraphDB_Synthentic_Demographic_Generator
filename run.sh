#!/bin/bash

. ./.pws

#export LOCALE=zu_ZA
export LOCALE=en_IE                             # used by faker to localise the name/surnames and addresses generated.
export COUNTRY=Ireland                          # Just used as the country tag in our address structure.
export ECHOCONFIG=1                             # Print to screen our current values as per this file, might make sense to have this as it goes into the log files.
export ECHORECORDS=0                            # If you want to see everything fly by, this will slow things down!!!
export RECCAP=5000000                           # If we're playing around and want to cap the records per age bracket, per day.      
export BLOCKSIZE=10                             # Age block size, 20-30 and 30-40 or 20-25 and 25-30
export BATCHSIZE=400
export AGECAP=10000                              # Record Cap per Age Block, if this number is > than BATCHSIZE then the batch will complete.
export DAYCAP=5000                               # Record Cap per Day/Datw, if this number is > than BATCHSIZE then the batch will complete.


export CONSOLE_DEBUGLEVEL=20                    # Console Handler
export FILE_DEBUGLEVEL=20                       # File Handler
# logging.CRITICAL: 50
# logging.ERROR: 40
# logging.WARNING: 30
# logging.INFO: 20
# logging.DEBUG: 10
# logging.NOTSET: 0

export LOGDIR=logs
export DATADIR=data
export DATASEEDFILE=ireland.json
export BANKSEEDFILE=ie_banks.json

export AGE_GAP=19
export VARIATION=2.5
export VARIATION_PERC=12                                    # 12 = .12 = 12%

export TARGETS=4,4,4
#export TARGETS=2,2,4                                        # Enable/Create Sessions onto DB stores, this MUST match the *_TARGETS below!!!!!
                                                            # order is adults, children and families
# 0 no DB send
# 1 MongoDB
# 2 PostgreSQL
# 3 Redis
# 4 Kafka

# Table Name, Topic Name, Collection Name or ...
export ADULTS_STORE=adults
export CHILDREN_STORE=children
export FAMILY_STORE=families

# Lest define where each of the above will be send, Refactored so that every data product can be routed to it's own Persistent Target.
export ADULTS_TARGET=4
export CHILDREN_TARGET=4        
export FAMILY_TARGET=4    

# MongoDB
export MONGO_ROOT=mongodb
export MONGO_USERNAME=
# export MONGO_PASSWORD=
export MONGO_HOST=localhost
export MONGO_PORT=27017
export MONGO_DIRECT=directConnection=true 
export MONGO_DATASTORE=demog 


# PostgreSQL CDC Source
export POSTGRES_CDC_HOST=localhost
export POSTGRES_CDC_PORT=5432
export POSTGRES_CDC_USER=dbadmin
# export POSTGRES_PASSWORD=
export POSTGRES_CDC_DB=demog        


# REDIS - see .pws
export REDIS_HOST=localhost
export REDIS_PORT=6379
export REDIS_DB=0
export REDIS_SSL=0
# export REDIS_PASSWORD=
# export REDIS_SSL_CERT=
# export REDIS_SSL_KEY=
# export REDIS_SSL_CA=


# KAFKA - see .pws                                          -> Added 18 Aug 2025
export KAFKA_BOOTSTRAP_SERVERS=localhost:9092
export KAFKA_SCHEMAREGISTRY_SERVERS=http://localhost:9081
export KAFKA_SECURITY_PROTOCOL=PLAINTEXT                    # PLAINTEXT or SSL or SASL_PLAINTEXT or SASL_SSL
export KAFKA_SASL_MECHANISMS=PLAIN                          # PLAIN or SCRAM-SHA-256 or SCRAM-SHA-512
export KAFKA_SASL_USERNAME=
# export KAFKA_SASL_PASSWORD=
export KAFKA_MAXRETRIES=4                                   
export KAFKA_DELAY=0.25                                     # delay seconds, which doubled ever retry


python3 app/main.py
