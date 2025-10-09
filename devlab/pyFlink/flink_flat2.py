#######################################################################################################################
#
#
#   Project             :   Factory IoT document flow.
#
#                       :   A different approach vs a traditional connector method.
#
#   File                :   flink_flat2.py
#
#   Description         :   Building sort of the following. Source IoT documents from a Python data generator, publish these to Kafka topic, 
#                       :   Source from Kafka into flink using a kafka connector, 
#                       :   Flatten the nested structure inside a User Defined Python Job, outputting the records to a
#                       :   Fluss table. This version uses a Create Temporary table as the source.
#               
#                       :   https://quix.io/blog/pyflink-deep-dive
#                       :   and some (more than some) assistance from https://gemini.google.com
#
#   Created             :   19 May 2025
#
#   Misc Reading        :   https://www.kdnuggets.com/2025/05/confluent/a-data-scientists-guide-to-data-streaming
#                       :   https://www.youtube.com/watch?v=Tn4n9xKE1ug
#                       :   https://www.decodable.co/blog/a-hands-on-introduction-to-pyflink
#
#
#   in Jobmanager i.e.
#
#   /opt/flink/bin/flink run \
#        -m jobmanager:8081 \
#        -py /path/to/flink_flat2.py \
#        -pyfs /pyapp/upper_udf.py \
#        -j /opt/flink/lib/flink/flink-sql-connector-kafka-3.3.0-1.20.jar \
#         --siteId 101 \
#         --source factory_iot_north
#
#       101/104 - North
#       102/105 - South
#       103/106 - East
#
########################################################################################################################
__author__      = "George Leonard"
__email__       = "georgelza@gmail.com"
__version__     = "1.0.0"
__copyright__   = "Copyright 2025, - G Leonard"


from pyflink.table.udf import ScalarFunction # Changed from TableFunction
from pyflink.table import TableEnvironment, EnvironmentSettings
from pyflink.table.expressions import call
from pyflink.common import Configuration
import sys, argparse

# Import the new function-based UDF
from upper_udf import uppercase_string_udf

DEFAULT_BOOTSTRAP = 'broker:29092'


# --------------------------------------------------------------------------
# In this version we going to implement a very simply inline User Defined Function that will upper case out unit value.
# This is purely to show the scafolding required. As once we know that the UDF can be used to do anything, call AI/ML engines.
# Do lookups out of a in memory datastore like Fluss itself, do any API if some conditions are met...
# --------------------------------------------------------------------------
def main(site_id_filter: int, input_kafka_topic: str, bootstrap_servers: str):
        
        
    pipeline_name = f"Flink_flat2-{input_kafka_topic}-{site_id_filter}"

    print(f"Starting {pipeline_name}.py")
    
    # --------------------------------------------------------------------------
    # Some environment settings and a nice Jobname/description "pipeline.name" for flink console
    # --------------------------------------------------------------------------
    config = Configuration()
    config.set_string("table.exec.source.idle-timeout", "1s")
    config.set_string(f"pipeline.name", pipeline_name)
    env_settings = EnvironmentSettings \
        .new_instance() \
        .in_streaming_mode() \
        .with_configuration(config) \
        .build()

    t_env = TableEnvironment.create(env_settings)


    # --------------------------------------------------------------------------
    # Add Kafka connector JARs
    # --------------------------------------------------------------------------
    kafka_connector_jar = "file:///opt/flink/lib/flink/flink-sql-connector-kafka-3.3.0-1.20.jar" # Adjust version and path
    flink_python_jar    = "file:///opt/flink/opt/flink-python-1.20.1.jar" 
    t_env.get_config().set("pipeline.jars", f"{kafka_connector_jar};{flink_python_jar}")


    # --------------------------------------------------------------------------
    # Register Fluss output Catalog
    # --------------------------------------------------------------------------
    t_env.execute_sql("""
        CREATE CATALOG fluss_catalog WITH (
            'type'              = 'fluss',
            'bootstrap.servers' = 'coordinator-server:9123'
        );
    """)  


    # --------------------------------------------------------------------------
    # Create the source Kafka table dynamically named after the input topic, and the siteId
    # We do this as each "region" has 2 factories, and we want to only "extract" one of the 
    # factories for the demo
    # The structure remains the same as it correctly defines the nested fields.
    #
    # As we're creating a temporary table this allows us to use a generic name like kafka_source
    # as the scope is local to this job only.
    # --------------------------------------------------------------------------
    source_table_creation_sql = f"""
        CREATE OR REPLACE TEMPORARY TABLE kafka_source (
             ts              BIGINT
            ,metadata        ROW<
                 siteId          INTEGER
                ,deviceId        INTEGER
                ,sensorId        INTEGER
                ,unit            STRING
                ,ts_human        STRING
                ,location        ROW<
                     latitude        DOUBLE
                    ,longitude       DOUBLE
                >
                ,deviceType      STRING
            >
            ,measurement         DOUBLE
            ,ts_wm               AS TO_TIMESTAMP_LTZ(ts, 3)
            ,WATERMARK           FOR ts_wm AS ts_wm - INTERVAL '1' MINUTE
        ) WITH (
            'connector'                     = 'kafka',
            'topic'                         = '{input_kafka_topic}',
            'properties.bootstrap.servers'  = '{bootstrap_servers}',
            'properties.group.id'           = 'flat2_{site_id_filter}',
            'scan.startup.mode'             = 'earliest-offset',
            'format'                        = 'json',
            'json.fail-on-missing-field'    = 'false',
            'json.ignore-parse-errors'      = 'true'
        );
    """
    t_env.execute_sql(source_table_creation_sql)

    statement_set = t_env.create_statement_set()
    
    
    # --------------------------------------------------------------------------
    # Register the new ScalarFunction
    # --------------------------------------------------------------------------
    t_env.create_temporary_system_function(
        "uppercase_unit_udf", # Name for the scalar UDF in SQL
        uppercase_string_udf  # Reference the imported function directly
    )
 

    # --------------------------------------------------------------------------
    # We accepting that the target output table has been pre created
    # Normally we would create a output table, We're not, we're just going to insert
    # into a pre existing table.
    # --------------------------------------------------------------------------
    
    
    
    # --------------------------------------------------------------------------
    # Flatten Input stream and output to Fluss, we also call our UDF on the unit column.
    # as example, this could have been the measurement column, returning a action or status 
    # code.
    # --------------------------------------------------------------------------
    if site_id_filter == 101 or site_id_filter == 104:              # North
        flat_sql = f"""
            INSERT INTO fluss_catalog.fluss.factory_iot_unnested
            (ts, siteId, deviceId, sensorId, unit, ts_human, latitude, longitude, deviceType, measurement, partition_month)
                SELECT
                     ts                                             AS ts
                    ,metadata.siteId                                AS siteId
                    ,metadata.deviceId                              AS deviceId
                    ,metadata.sensorId                              AS sensorId
                    ,uppercase_unit_udf(metadata.unit)              AS unit -- Apply UDF here
                    ,cast(NULL as STRING)                           AS ts_human
                    ,cast(NULL as DOUBLE)                           AS latitude
                    ,cast(NULL as DOUBLE)                           AS longitude
                    ,cast(NULL as STRING)                           AS deviceType
                    ,measurement                                    AS measurement
                    ,DATE_FORMAT(TO_TIMESTAMP_LTZ(ts, 3), 'yyyyMM') AS partition_month
                FROM kafka_source
                WHERE metadata.siteId = {site_id_filter}; 
        """
           
    elif site_id_filter == 102 or site_id_filter == 105:            # South
        flat_sql = f"""
            INSERT INTO fluss_catalog.fluss.factory_iot_unnested
            (ts, siteId, deviceId, sensorId, unit, ts_human, latitude, longitude, deviceType, measurement, partition_month)
                SELECT
                    ts                                             AS ts
                    ,metadata.siteId                                AS siteId
                    ,metadata.deviceId                              AS deviceId
                    ,metadata.sensorId                              AS sensorId
                    ,uppercase_unit_udf(metadata.unit)              AS unit -- Apply UDF here
                    ,metadata.ts_human                              AS ts_human
                    ,metadata.location.latitude                     AS latitude
                    ,metadata.location.longitude                    AS longitude
                    ,cast(NULL as STRING)                           AS deviceType
                    ,measurement                                    AS measurement
                    ,DATE_FORMAT(TO_TIMESTAMP_LTZ(ts, 3), 'yyyyMM') AS partition_month
                FROM kafka_source
                WHERE metadata.siteId = {site_id_filter}; 
         """
         
    elif site_id_filter == 103 or site_id_filter ==106:             # East
        flat_sql = f"""
            INSERT INTO fluss_catalog.fluss.factory_iot_unnested
            (ts, siteId, deviceId, sensorId, unit, ts_human, latitude, longitude, deviceType, measurement, partition_month)
                SELECT
                    ts                                             AS ts
                    ,metadata.siteId                                AS siteId
                    ,metadata.deviceId                              AS deviceId
                    ,metadata.sensorId                              AS sensorId
                    ,uppercase_unit_udf(metadata.unit)              AS unit -- Apply UDF here
                    ,metadata.ts_human                              AS ts_human
                    ,metadata.location.latitude                     AS latitude
                    ,metadata.location.longitude                    AS longitude
                    ,metadata.deviceType                            AS deviceType
                    ,measurement                                    AS measurement
                    ,DATE_FORMAT(TO_TIMESTAMP_LTZ(ts, 3), 'yyyyMM') AS partition_month
                FROM kafka_source
                WHERE metadata.siteId = {site_id_filter}; 
        """
    #end if
        
        
    statement_set.add_insert_sql(flat_sql)

    statement_set.execute().wait()
    print(f"PyFlink job finished for siteId: {site_id_filter}, flatten from topic: {input_kafka_topic}, outputting to fluss")

#end main


if __name__ == "__main__":
    
    try:
        parser = argparse.ArgumentParser(description="PyFlink IoT Data Processing Job")
        
        parser.add_argument("--siteId", 
                            type=int, 
                            required=True,
                            help="The site ID to filter data for.")
        
        parser.add_argument("--source", 
                            type=str, 
                            required=True,
                            help="The Kafka input topic name.")

        args = parser.parse_args()

    except Exception as e:    
        print("Usage: python flink_job1.py siteId=<site_id> source=<source_topic>")

        print(f"Must provide input parameters: {e}")

        sys.exit(1)
            
    #end try
    
    
    if len(sys.argv) > 0:
                
        siteId = args.siteId
        source = args.source
        
    try:
        main(siteId, source, DEFAULT_BOOTSTRAP)
        
    except Exception as e:
        print(f"An unexpected error occurred: {e}")
        sys.exit(1)
        
    #end try
        
#end __main__