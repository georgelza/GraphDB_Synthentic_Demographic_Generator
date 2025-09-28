#######################################################################################################################
#
#
#  	Project     	: 	Generic Data generator.
#                   :   Refactored with OOP based Database Connections
#
#   File            :   main.py
#
#   Description     :   Create a dataset representing a demographic distribution
#
#   Created     	:   06 Aug 2025
#                   :   23 Aug 2025 - Modified faker_address, added neighbourhood, 
#                   :                   modified faker_bankAccount and getAccount to match previous blog close i.e 
#                   :                   fspiId instead of id, 
#                   :                   swiftCode instead of swift_code, etc. 
#                   :   24 Aug 2025 - Refactored so that each data product can go to a individual specified persistent/DB target
#                   :               - as such modified "getDataStoreConnection" & "generate_population" to accomodate.
#                   :               - as such modified the input variables from run.sh
#
#                   :   We're heavily using the Python Faker package, see below for more reading.
#                       https://towardsdatascience.com/fake-almost-everything-with-faker-a88429c500f1/
#                       https://fakerjs.dev/guide/localization
#
#
########################################################################################################################
__author__      = "Generic Data playground"
__email__       = "georgelza@gmail.com"
__version__     = "0.2"
__copyright__   = "Copyright 2025, - George Leonard"


import uuid, sys
from datetime import datetime, timedelta
from dateutil.relativedelta import relativedelta
from time import perf_counter
from faker import Faker

# My Packages/Functions
from utils import *
from connections import DatabaseManager, DatabaseConnectionError, DatabaseOperationError
from packager import *
from weighted_random import *
from option_lists import *
from faker_nationalIdNumber import *
from faker_bankAccount import *
from faker_address import *
from faker_bank import *
from faker_expdate import *
from getNationalIdNumber import *

def getDataStoreConnection(config_params, mylogger):

    mongodb_conn    = None
    postgresql_conn = None
    redis_conn      = None
    kafka_conn      = None
    
    try:
        if 1 in config_params["TARGETS"]:
            mylogger.debug("Let's configure a connection to MongoDB:")
            
            mongodb_conn = DatabaseManager.connect('mongodb',       config_params, mylogger)
            mongodb_conn.connect()
            
            mylogger.debug("Configured connection to MongoDB:")

        if 2 in config_params["TARGETS"]:
            mylogger.debug("Let's configure a connection to PostgreSql:")
            
            postgresql_conn = DatabaseManager.connect('postgresql', config_params, mylogger)
            postgresql_conn.connect()
            
            mylogger.debug("Configured connection to PostgreSql:")

        if 3 in config_params["TARGETS"]:
            mylogger.debug("Let's configure a connection to Redis:")
            
            redis_conn = DatabaseManager.connect('redis',           config_params, mylogger)
            redis_conn.connect()
            
            mylogger.debug("Configured connection to Redis:")

        if 4 in config_params["TARGETS"]:
            mylogger.debug("Let's configure a connection to Kakfa:")
            
            kafka_conn = DatabaseManager.connect('kafka',           config_params, mylogger)
            kafka_conn.connect()
            
            mylogger.debug("Configured connection to Kakfa:")
            
    except (DatabaseConnectionError, ValueError) as err:
        mylogger.error('Failed to setup database connections:{targets} {err}'.format(
            targets = config_params["TARGETS"],
            err = err
        ))       
        
        #end try
    return mongodb_conn, postgresql_conn, redis_conn, kafka_conn
#end getDataStoreConnection


def generate_population(config_params, mylogger):
    
    try:
        mylogger.info("STARTING run, logfile => {logfile}".format(
            logfile=config_params["LOGGINGFILE"]
        ))
        print("")

        # We need to make sure our connections created matches the adults, children and family targets.
        stores = []
        stores.append(config_params["ADULTS_TARGET"])
        stores.append(config_params["CHILDREN_TARGET"])
        stores.append(config_params["FAMILY_TARGET"])
        if set(stores) != set(config_params["TARGETS"]):
            mylogger.warning("Configured *_Stores Mismatch, Adults:{adults}, Children:{children}, Family:{family} <> DB *_Targets Specified:{targets}".format(
                adults    = config_params["ADULTS_TARGET"],
                children  = config_params["CHILDREN_TARGET"],
                family    = config_params["FAMILY_TARGET"],
                targets   = config_params["TARGETS"]
            ))
            sys.exit(1)
        # end if

        # Our Global timer    
        step0starttime  = datetime.now()
        step0start      = perf_counter()
        
        mylogger.info("Configuring Persistent stores:")
        
        step1starttime  = datetime.now()
        step1start      = perf_counter()

        mongodb_conn, postgresql_conn, redis_conn, kafka_conn = getDataStoreConnection(config_params, mylogger)        

        step1endtime    = datetime.now()
        step1end        = perf_counter()
        step1time       = round((step1end - step1start),2)

        print("")
                
        # Faker and custom providers    
        fake = Faker(config_params["LOCALE"])                   # en_IE used for demo
        fake.add_provider(SAIdNumberProvider)                   # => Local South Africa
        fake.add_provider(IrishPpsNumberProvider)               # => Local Ireland
        fake.add_provider(IrishBankAccountProvider)             # => Irish Bank numbers based on IBAN number
        fake.add_provider(DateMMYYProvider)                     # used by getAccount.createCCAccount()
        
        # load seed data
        seedfull_path    = config_params["DATASEEDFILE"]
        geo_provider     = GeographicDataProvider(fake, file_path=seedfull_path, mylogger=mylogger)
        fake.add_provider(geo_provider)

        # load banks based data
        bankfull_path    = config_params["BANKSEEDFILE"]
        bank_provider    = BankProvider(fake, file_path=bankfull_path, mylogger=mylogger)
        fake.add_provider(bank_provider)

        ageBlockSize     = config_params["BLOCKSIZE"]           # 10 yrs, this needs to align with option_list => age_distribution_ireland 
        batch_size       = config_params["BATCHSIZE"]           # i.e.: 100 minimum per batch

        cntTotalAdults   = 0
        cntTotalChildren = 0
        cntTotalFamilies = 0
        cntTotal         = 0

        todayDate        = datetime.now()
            
        province_options, total_province_population = fake.get_provinces()
    
        # Kids                                                            
        ageGap           = config_params["AGE_GAP"]
        variation        = config_params["VARIATION"]/config_params["VARIATION_PERC"]        # VARIATIONPERC implies %
            
        # Generate people for each age bracket
        for age_bracket in age_distribution_ireland:
        
            # per Age bracket execution timer
            step2starttime      = datetime.now()
            step2start          = perf_counter()

            start_age           = age_bracket["name"]          # e.g., 20
            end_age             = start_age + ageBlockSize     # e.g., 20 + 10 = 30
            people_count        = age_bracket["count"]         # e.g., total number of ppl to create for age_bracket (including kids)
            
            cntAdultsBlock      = 0
            cntChildrenBlock    = 0
            cntFamiliesBlock    = 0
            cntTotalBlock       = 0
                    
            # Calculate the number of dates to pick
            number_of_dates     = int(people_count / batch_size)

            # Calculate the date range for the entire block
            start_date_range    = todayDate - relativedelta(years=end_age)
            end_date_range      = todayDate - relativedelta(years=start_age)
            total_days_in_block = (end_date_range - start_date_range).days

            # Calculate the uniform interval
            interval            = total_days_in_block / number_of_dates

            selected_dates      = []
            current_date        = start_date_range        
            
            # build/pick our selected dates 
            for _ in range(number_of_dates):
                jitter          = random.randint(-5, 5) 
                current_date   += timedelta(days=interval + jitter)
                selected_dates.append(current_date)
    
            #end for
                    
            print("")
            mylogger.info("Creating {people_count} people for age bracket {start_age}-{end_age} across {number_of_dates} dates in batches of {batch_size}".format(
                people_count    = people_count,
                start_age       = start_age,
                end_age         = end_age,
                number_of_dates = number_of_dates,
                batch_size      = batch_size
            ))
                    
            # Loop over the pre-selected dates instead of every single day
            for dob_date in selected_dates:
                
                # Per day execution timer
                step3starttime  = datetime.now()
                step3start      = perf_counter()
                
                cntAdultsDay    = 0
                cntChildrenDay  = 0
                cntFamiliesDay  = 0
                cntDay          = 0
                
                n               = 0
                idx_index       = 0
                            
                arAdults        = []
                arChildren      = [] 
                arFamilies      = []
                
                dob             = dob_date.strftime('%y/%m/%d')
                nationalIDs     = generate_nationalID(fake, config_params,  dob, "male", batch_size)      

                # Inner loop: create the batch of people for this single, pre-selected date

                while n < batch_size:
                    
                    # Get a batch of ID Numbers
                    maleId      = nationalIDs[idx_index]      
                    idx_index  += 1
                    arKids      = []
                                
                    # Provincees - For every loop lets pick a new random province
                    province_selected = WeightedRandomSelector(province_options, scale=total_province_population).get_random()
                                        
                    # Counties - For every loop lets pick a new random County
                    county_options, total_county_population = fake.get_counties(province_selected)
                    
                    if county_options is None:
                        mylogger.warning("No counties found for province {province_selected}, using default".format(
                            province_selected = province_selected
                        ))
                        county_selected         = "Unknown County"
                        city_selected           = "Unknown City"
                        neighbourhood_selected  = "Unknown Neighbourhood"
                        
                    else:
                        county_selected = WeightedRandomSelector(county_options, scale=total_county_population).get_random()

                        # Towns/Cities - For every loop lets pick a new random Town/City
                        city_options, total_city_population = fake.get_cities_towns(province_selected, county_selected)
                        if city_options is None:
                            mylogger.warning("No cities found for {county_selected}, {province_selected}, using county name".format(
                                county_selected   = county_selected,
                                province_selected = province_selected
                            ))
                            city_selected = county_selected
                        
                        else:
                            city_selected = WeightedRandomSelector(city_options, scale=total_city_population).get_random()
                        #end if
                        
                        # Find a Neighbourhood for the City we've not so randomly selected.
                        neighbourhood_options, neighbourhood_count = fake.get_neighbourhoods(province_selected, county_selected, city_selected)
                                                              
                        if neighbourhood_count == 0:
                            mylogger.warning("No neighbourhoods found for {city_selected}, {county_selected}, {province_selected}, using City name".format(
                                city_selected     = city_selected,
                                county_selected   = county_selected,
                                province_selected = province_selected
                            ))
                            neighbourhood_selected = city_selected

                        else:
                            neighbourhood_selected = WeightedRandomSelector(neighbourhood_options, scale=neighbourhood_count).get_random()
                            
                        #end if
                    #end if
                    
                    
                    if neighbourhood_count != 0:
                        # Get Temple Bar neighbourhood info
                        neighbourhood_info      = fake.get_neighbourhood_info(
                            neighbourhood_name  = neighbourhood_selected,
                            city_town_name      = city_selected, 
                            county_name         = county_selected, 
                            province_name       = province_selected
                        )

                        address = fake.unique.generate_address(
                            neighbourhood   = neighbourhood_selected, 
                            town            = city_selected, 
                            county          = county_selected, 
                            province_state  = province_selected, 
                            country         = config_params["COUNTRY"],
                            postal_code     = neighbourhood_info['postal_code']
                        )
                    else:
                        address = fake.unique.generate_address(
                            neighbourhood   = neighbourhood_selected, 
                            town            = city_selected, 
                            county          = county_selected, 
                            province_state  = province_selected, 
                            country         = config_params["COUNTRY"]
                        )
                    #end if
                    
                    marital_status  = WeightedRandomSelector(marital_options, scale=1.0).get_random()
                        
                    # Calculate/Keep track of people this iteration has created
                    if marital_status == "Single":
                        n += 1                  # Single adult
                        
                    else:                    
                        n += 2                  # husband + wife
                        # Check for children
                        if WeightedRandomSelector(children_yn_options, scale=1.0).get_random() == 1:
                            kids_result = WeightedRandomSelector(kids_options, scale=1.0).get_random()

                        else: 
                            kids_result = 0
                            
                        #end if 
                        n += kids_result
                    #end if - Married or ... => marital_status


                    # Single Adult
                    if marital_status == "Single":
                        
                        cntAdultsDay += 1
                        cntDay       += 1
                        
                        surname       = fake.last_name()
                        
                        if WeightedRandomSelector(gender_options, scale=1.0).get_random() == "Male":    # Male Adult
                            firstName           = fake.first_name_male()
                            adultDOB            = dob
                            adultId             = maleId
                            adultGender         = "M"

                        else:                                                                           # Female Adult
                            firstName           = fake.first_name_female()
                            adultDOB            = generate_birth_date(dob, 4, 4)            
                            adultId             = generate_nationalID(fake, config_params, adultDOB, "Female", 1)[0]
                            adultGender         = "F"
                            
                        #end if

                        single_adult = {
                            "_id":              str(uuid.uuid4()),
                            "surname":          surname,
                            "name":             firstName,
                            "nationalid":       adultId,
                            "marital_status":   "Single",
                            "status":           "Living",
                            "dob":              adultDOB,
                            "gender":           adultGender,
                            "address":          address,
                            "account":          createBankAccount(fake, firstName[0], surname)
                        }

                        arAdults.append(single_adult)
                            
                    else:    # Family Logic, so either Married, Divorced, Seperated or Widowed with or without Children
                        
                        # Generate a unique ID for the family at the beginning of the loop
                        family_unique_id = str(uuid.uuid4())
                        
                        cntAdultsDay   += 2         # Husband and Wife
                        cntDay         += 2         # Total count for the day, mildy simalar to variable n

                        surname         = fake.last_name()
                        femaleDOB       = generate_birth_date(dob, 4, 4)            
                        femaleId        = generate_nationalID(fake, config_params, femaleDOB, "Female", 1)[0]
                        
                        motherCustody_status  = WeightedRandomSelector(motherCustody_options, scale=1.0).get_random()
                        
                        childPackage = {
                            "surname":      surname,
                            "femaleDOB":    femaleDOB,
                            "femaleId":     femaleId,
                            "maleId":       maleId,
                            "ageGap":       ageGap,
                            "variation":    variation, 
                            "address":      address,
                            "family_id":    family_unique_id
                        }
                        

                        if kids_result > 0:
                            for i in range(kids_result):

                                cntChildrenDay += 1
                                cntDay         += 1

                                child_a, child_b = packageChild(fake, config_params, childPackage)

                                arKids.append(child_a)                  # We split "child" record into 2 copies, one without address as it's being added to family that has a address 
                                arChildren.append(child_b)              # and one with a address as per family which is inserted into it's own children collection/table.
                                            
                        #end if
                        
                                            
                        # Widowed - No Children - Adults     
                        if marital_status == "Widowed":
                            
                            male_livingstatus_status        = WeightedRandomSelector(livingstatus_yn_options, scale=1.0).get_random()
                            female_livingstatus_status      = WeightedRandomSelector(livingstatus_yn_options, scale=1.0).get_random() 
                            
                            # Just in case we some how get both as Deceased, let miraculously resurect ;) the Male
                            if male_livingstatus_status == "Deceased" and female_livingstatus_status == "Deceased":
                                female_livingstatus_status  = "Deceased"
                                male_livingstatus_status    = "Living"

                            elif male_livingstatus_status == "Living" and female_livingstatus_status == "Living":
                                female_livingstatus_status  = "Living"
                                male_livingstatus_status    = "Deceased"
                                
                            familyPackage = {
                                "m_surname":                    surname,
                                "f_surname":                    surname,
                                "m_address":                    address,
                                "f_address":                    address,
                                "maleId":                       maleId,
                                "maleDOB":                      dob,
                                "femaleId":                     femaleId,
                                "femaleDOB":                    femaleDOB,
                                "marital_status":               marital_status,
                                "male_livingstatus_status":     male_livingstatus_status,
                                "female_livingstatus_status":   female_livingstatus_status,
                                "family_id":                    family_unique_id
                            }   
                                                                    
                            family_male_a, \
                            family_female_a, \
                            family_male_b, \
                            family_female_b = \
                                packageAdults(fake, familyPackage, mylogger)

                            
                            if kids_result > 0:
                                family = {
                                    "_id":      family_unique_id,  # Use the generated UUID
                                    "husband":  family_male_a,
                                    "wife":     family_female_a,
                                    "address":  address,
                                    "children": arKids
                                }
                            else:
                                family = {
                                    "_id":      family_unique_id,  # Use the generated UUID
                                    "husband":  family_male_a,
                                    "wife":     family_female_a,
                                    "address":  address    
                                }
                            #end if
                            arAdults.append(family_male_b)
                            arAdults.append(family_female_b)
                            arFamilies.append(family)
                            cntFamiliesDay += 1                    
                        #end if
                                    
                        male_livingstatus_status   = "Living"
                        female_livingstatus_status = "Living"
                    
                        if marital_status == "Seperated" or marital_status == "Divorced":
                                
                            femSurname = fake.last_name()
                    
                            femAddress = fake.unique.generate_address(
                                town            = city_selected, 
                                neighbourhood   = neighbourhood_selected, 
                                county          = county_selected, 
                                province_state  = province_selected, 
                                country         = config_params["COUNTRY"],
                                postal_code     = neighbourhood_info['postal_code']
                            )
                            
                            
                            familyPackage = {
                                "m_surname":                    surname,
                                "f_surname":                    femSurname,
                                "m_address":                    address,
                                "f_address":                    femAddress,
                                "maleId":                       maleId,
                                "maleDOB":                      dob,
                                "femaleId":                     femaleId,
                                "femaleDOB":                    femaleDOB,
                                "marital_status":               marital_status,
                                "male_livingstatus_status":     male_livingstatus_status,
                                "female_livingstatus_status":   female_livingstatus_status,
                                "family_id":                    family_unique_id
                            }   

                            family_male_a, \
                            family_female_a, \
                            family_male_b, \
                            family_female_b = \
                                packageAdults(fake, familyPackage, mylogger)

                            if kids_result > 0:
                                if motherCustody_status == 1:
                                    family = {
                                        "_id":      family_unique_id,  # Use the generated UUID
                                        "wife":     family_female_a,
                                        "address":  femAddress,
                                        "children": arKids
                                    }
                                else:
                                    family = {
                                        "_id":      family_unique_id,  # Use the generated UUID
                                        "husband":  family_male_a,
                                        "address":  address,
                                        "children": arKids
                                    }
                                #end if   
                                arFamilies.append(family) 
                                cntFamiliesDay += 1                    
                            #end if                  
                            arAdults.append(family_male_b)
                            arAdults.append(family_female_b)
                                                        
                        elif marital_status == "Married":

                            familyPackage = {
                                "m_surname":                    surname,
                                "f_surname":                    surname,
                                "m_address":                    address,
                                "f_address":                    address,
                                "maleId":                       maleId,
                                "maleDOB":                      dob,
                                "femaleId":                     femaleId,
                                "femaleDOB":                    femaleDOB,
                                "marital_status":               marital_status,
                                "male_livingstatus_status":     male_livingstatus_status,
                                "female_livingstatus_status":   female_livingstatus_status,
                                "family_id":                    family_unique_id
                            }

                            family_male_a, \
                            family_female_a, \
                            family_male_b, \
                            family_female_b = \
                                packageAdults(fake, familyPackage, mylogger)
                                                
                            if kids_result > 0:                                                            
                                family = {
                                    "_id":      family_unique_id,  # Use the generated UUID
                                    "husband":  family_male_a,
                                    "wife":     family_female_a,
                                    "address":  address,
                                    "children": arKids
                                }
                            else:
                                family = {
                                    "_id":      family_unique_id,  # Use the generated UUID
                                    "husband":  family_male_a,
                                    "wife":     family_female_a,
                                    "address":  address
                                    }                                            
                            #end if
        
                            arAdults.append(family_male_b)
                            arAdults.append(family_female_b)
                            arFamilies.append(family) 
                            cntFamiliesDay += 1                    

                        #end if Married                                       
                    #end if
                #end for
                
                
                # Flush at end of a day
                try:
                    if 1 in config_params["TARGETS"]:     # We're storing something into MongoDB
                        if config_params["ADULTS_TARGET"] == 1:                        
                            if len(arAdults) > 0:
                                result = mongodb_conn.insert_multiple(arAdults, store_name=config_params["ADULTS_STORE"])
                            
                            #end if                         
                        if config_params["CHILDREN_TARGET"] == 1:                        
                            if len(arChildren) > 0:
                                result = mongodb_conn.insert_multiple(arChildren, store_name=config_params["CHILDREN_STORE"])
                            
                            #end if 
                        if config_params["FAMILY_TARGET"] == 1:                        
                        
                            if len(arFamilies) > 0:
                                result = mongodb_conn.insert_multiple(arFamilies, store_name=config_params["FAMILY_STORE"])

                            #end if 
                        
                    if 2 in config_params["TARGETS"]:     # We're storing something into PostgreSQL
                        if config_params["ADULTS_TARGET"] == 2:                        
                            if len(arAdults) > 0:
                                result = postgresql_conn.insert_multiple(arAdults, store_name=config_params["ADULTS_STORE"], extract_nationalId=True)
                            
                            #end if                         
                        if config_params["CHILDREN_TARGET"] == 2:                        
                            if len(arChildren) > 0:
                                result = postgresql_conn.insert_multiple(arChildren, store_name=config_params["CHILDREN_STORE"], extract_nationalId=True)
                            
                            #end if 
                        if config_params["FAMILY_TARGET"] == 2:                        
                            if len(arFamilies) > 0:
                                result = postgresql_conn.insert_multiple(arFamilies, store_name=config_params["FAMILY_STORE"], extract_nationalId=False)

                            #end if 

                    if 3 in config_params["TARGETS"]:     # We're storing something into Redis
                        if config_params["ADULTS_TARGET"] == 3:                        
                            if len(arAdults) > 0:
                                result = redis_conn.insert_multiple(arAdults, store_name=config_params["ADULTS_STORE"], key_field="nationalid")
                            
                            #end if                         
                        if config_params["CHILDREN_TARGET"] == 3:                        
                            if len(arChildren) > 0:
                                result = redis_conn.insert_multiple(arChildren, store_name=config_params["CHILDREN_STORE"], key_field="nationalid")
                            
                            #end if 
                        if config_params["FAMILY_TARGET"] == 3:                        
                            if len(arFamilies) > 0:
                                result = redis_conn.insert_multiple(arFamilies, store_name=config_params["FAMILY_STORE"], key_field="_id")

                            #end if 

                    if 4 in config_params["TARGETS"]:     # We're storing something into Kafka
                        if config_params["ADULTS_TARGET"] == 4:                        
                            if len(arAdults) > 0:
                                result = kafka_conn.insert_multiple(arAdults, store_name=config_params["ADULTS_STORE"], key="nationalid")
                            
                            #end if                         
                        if config_params["CHILDREN_TARGET"] == 4:                        
                            if len(arChildren) > 0:
                                result = kafka_conn.insert_multiple(arChildren, store_name=config_params["CHILDREN_STORE"], key="nationalid")
                            
                            #end if 
                        if config_params["FAMILY_TARGET"] == 4:                        
                            if len(arFamilies) > 0:
                                result = kafka_conn.insert_multiple(arFamilies, store_name=config_params["FAMILY_STORE"], key_field="_id")

                            #end if 
    
                except DatabaseOperationError as err:
                    mylogger.error("Database operation failed during flush: - {err}".format(
                        err  = err
                    ))
                    continue

                #end try

                cntAdultsBlock      += cntAdultsDay
                cntChildrenBlock    += cntChildrenDay
                cntFamiliesBlock    += cntFamiliesDay
                cntTotalBlock       += cntDay

                cntTotalAdults      += cntAdultsDay
                cntTotalChildren    += cntChildrenDay
                cntTotalFamilies    += cntFamiliesDay      
                cntTotal            += cntDay
                    
                step3endtime        = datetime.now()
                step3end            = perf_counter()
                step3time           = round((step3end - step3start),2)
                    
                mylogger.info("Record Flushed - St:{start} Et:{end} Rt:{runtime} for {day}: Adults {cntAdultsDay}, Children {cntChildrenDay}, Families {cntFamiliesDay}, Total {cntDay}".format(
                    start           = str(step3starttime.strftime("%Y-%m-%d %H:%M:%S")),
                    end             = str(step3endtime.strftime("%Y-%m-%d %H:%M:%S")),
                    runtime         = str(step3time),
                    day             = dob,
                    cntAdultsDay    = cntAdultsDay,                    
                    cntChildrenDay  = cntChildrenDay,
                    cntFamiliesDay  = cntFamiliesDay,
                    cntDay          = cntDay
                ))

            #end for - Do next day's loops

            step2endtime            = datetime.now()
            step2end                = perf_counter()
            step2time               = round((step2end - step2start),2)
            
            mylogger.info("Record Flushed - St:{start} Et:{end} Rt:{runtime} for Age Bracket {start_age} - {end_age}: Adults {cntAdultsBlock}, Children {cntChildrenBlock}, Families {cntFamiliesBlock}, Total {cntTotalBlock}".format(
                start               = str(step2starttime.strftime("%Y-%m-%d %H:%M:%S")),
                end                 = str(step2endtime.strftime("%Y-%m-%d %H:%M:%S")),
                runtime             = str(step2time),
                start_age           = start_age,
                end_age             = end_age,
                cntAdultsBlock      = cntAdultsBlock,                      
                cntChildrenBlock    = cntChildrenBlock,
                cntFamiliesBlock    = cntFamiliesBlock,
                cntTotalBlock       = cntTotalBlock
            ))
            
        #end for
        
        # Cleanup database connection
        try:

            if 1 in config_params["TARGETS"]:     # We're storing something into Mongo
                mongodb_conn.disconnect()
                
            if 2 in config_params["TARGETS"]:     # We're storing something into PostgreSql
                postgresql_conn.disconnect()

            if 3 in config_params["TARGETS"]:     # We're storing something into Redis
                redis_conn.disconnect()

            if 4 in config_params["TARGETS"]:     # We're storing something into Kafka
                kafka_conn.disconnect()
                            

        except Exception as err:
            mylogger.error("Error disconnecting from database: {err}".format(
                err  = err
            ))
        #end try
        
        # Print the Numbers
        step0endtime    = datetime.now()
        step0end        = perf_counter()
        step0time       = round((step0end - step0start),2)
        currate         = round(cntTotal/step0time, 2)

        print("")
        
        mylogger.info("Population DB Connect  - St:{start} Et:{end} Rt:{runtime}".format(
            start               = str(step1starttime.strftime("%Y-%m-%d %H:%M:%S")),
            end                 = str(step1endtime.strftime("%Y-%m-%d %H:%M:%S")),
            runtime             = str(step1time)
        ))
        
        mylogger.info("Population Generate    - St:{start} Et:{end} Rt:{runtime} Adults: {cntTotalAdults} Children: {cntTotalChildren} Families:{cntTotalFamilies} Recs:{cntTotal} Rate:{currate} rec/sec".format(
            start               = str(step0starttime.strftime("%Y-%m-%d %H:%M:%S")),
            end                 = str(step0endtime.strftime("%Y-%m-%d %H:%M:%S")),
            runtime             = str(step0time),
            cntTotalAdults      = str(cntTotalAdults),          # Number of Adults
            cntTotalChildren    = str(cntTotalChildren),        # Number of Children
            cntTotalFamilies    = str(cntTotalFamilies),        # Number of Families
            cntTotal            = str(cntTotal),                # Total # of records created
            currate             = str(currate)
        ))
        
    except Exception as err:
        mylogger.err("Undefined Error: {err}".format(
            err = err
        ))  
#end generate_population()


if __name__ == '__main__':
    
    try:
        config_params   = getConfigs()
        logger_instance = mylogger(config_params["LOGGINGFILE"], config_params["CONSOLE_DEBUGLEVEL"], config_params["FILE_DEBUGLEVEL"])
        echo_config(config_params, logger_instance)
        
        generate_population(config_params, logger_instance)
    
    except KeyboardInterrupt:
        print("\nKeyboardInterrupt caught! Exiting gracefully.")

    # except Exception as err:
    #     print(f"Undefined Error: {err}")
        
    finally:
        print("Cleanup operations (if any) can go here.")
    #end try
#end __name__