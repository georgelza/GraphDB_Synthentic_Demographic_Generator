#######################################################################################################################
#
#
#   Project             :   Factory IoT document flow.
#
#                       :   A different approach vs a traditional connector method.
##
#   File                :   flink_flat0.py
#
#   Description         :   Building sort of the following. Source IoT documents from a Python data generator, publish these to Kafka topic, 
#                       :   Source from Kafka into flink using a kafka connector, 
#                       :   Flatten these using a User Defined Python Job running on the flink cluster, outputting the record to a
#                       :   new Kafka Topic. This version uses a Create Temporary table as the source.
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
#        -py /path/to/flink_flat0.py \
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


from pyflink.table import TableEnvironment, EnvironmentSettings
from pyflink.common import Configuration
import sys, argparse


DEFAULT_BOOTSTRAP = 'broker:29092'

# --------------------------------------------------------------------------
# Source, Flatten and output to Kafka topic
# --------------------------------------------------------------------------
def main(site_id_filter: int, input_kafka_topic: str, bootstrap_servers: str):
    
    output_kafka_topic = f"{input_kafka_topic}_{site_id_filter}"
    
    pipeline_name = f"Flink_flat0-{input_kafka_topic}-{site_id_filter}"

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

    t_env  = TableEnvironment.create(env_settings)


    # --------------------------------------------------------------------------
    # Add Kafka connector JARs
    # --------------------------------------------------------------------------
    kafka_connector_jar = "file:///opt/flink/lib/flink/flink-sql-connector-kafka-3.3.0-1.20.jar" # Adjust version and path
    t_env.get_config().set("pipeline.jars", kafka_connector_jar)


    # --------------------------------------------------------------------------
    # Create the source Kafka table dynamically using kafka_source as a generic name.
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
            'properties.group.id'           = 'flat0_{site_id_filter}',
            'scan.startup.mode'             = 'earliest-offset',
            'format'                        = 'json',
            'json.fail-on-missing-field'    = 'false',
            'json.ignore-parse-errors'      = 'true'
        );
    """
    t_env.execute_sql(source_table_creation_sql)


    # --------------------------------------------------------------------------
    # Define the output table for flattened data as a Kafka sink, as this is a temporary 
    # table and the scope is only local this only allows us to use a generic name like 
    # kafka_target for the table name, simplifying the code.
    #
    # The topic name is important though...
    # --------------------------------------------------------------------------
    output_table_creation_sql = f"""
        CREATE OR REPLACE TEMPORARY TABLE kafka_target (
             ts                     BIGINT
            ,siteId                 INTEGER
            ,deviceId               INTEGER
            ,sensorId               INTEGER
            ,unit                   STRING
            ,ts_human               STRING
            ,latitude               DOUBLE
            ,longitude              DOUBLE
            ,deviceType             STRING
            ,measurement            DOUBLE
            ,ts_wm                  TIMESTAMP_LTZ(3)
        ) WITH (
            'connector'                     = 'kafka',
            'topic'                         = '{output_kafka_topic}',
            'properties.bootstrap.servers'  = '{bootstrap_servers}',
            'format'                        = 'json',
            'json.fail-on-missing-field'    = 'false',
            'json.ignore-parse-errors'      = 'true'
        );
    """
    t_env.execute_sql(output_table_creation_sql)

    statement_set = t_env.create_statement_set()
    
    
    # --------------------------------------------------------------------------
    # Perform minute-level aggregation by directly accessing nested fields
    # --------------------------------------------------------------------------
    aggregation_sql = f"""
        INSERT INTO kafka_target
        SELECT
             ts                               AS ts
            ,metadata.siteId                  AS siteId
            ,metadata.deviceId                AS deviceId
            ,metadata.sensorId                AS sensorId
            ,metadata.unit                    AS unit
            ,metadata.ts_human                AS ts_human
            ,metadata.location.latitude       AS latitude
            ,metadata.location.longitude      AS longitude
            ,metadata.deviceType              AS deviceType
            ,measurement                      AS measurement
            ,ts_wm                            AS ts_wm
        FROM kafka_source
        WHERE metadata.siteId = {site_id_filter};
    """
    statement_set.add_insert_sql(aggregation_sql)

    statement_set.execute().wait()
    print(f"PyFlink job finished for siteId: {site_id_filter}, flatten from topic: {input_kafka_topic}, outputting to {output_kafka_topic}")

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