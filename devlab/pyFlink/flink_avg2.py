#######################################################################################################################
#
#
#   Project             :   Factory IoT document flow.
#
#                       :   A different approach vs a traditional connector method.
#
#   File                :   flink_avg2.py
#
#   Description         :   building on avg1, we now adding a stability_factor column which we calculate via the udf
#               
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
#        -py /path/to/flink_avg2.py \
#        -pyfs /pyapp/stability_udf.py \
#        -j /opt/flink/lib/flink/flink-sql-connector-kafka-3.3.0-1.20.jar  \
#        -j /opt/flink/opt/flink-python-1.20.1.jar \
#        --siteId 102 \
#        --source factory_iot_south
#
# 101/104 - North
# 102/105 - south
# 103/106 - east
# 
# ########################################################################################################################
__author__      = "George Leonard"
__email__       = "georgelza@gmail.com"
__version__     = "1.0.0"
__copyright__   = "Copyright 2025, - G Leonard"

 
from pyflink.table import TableEnvironment, EnvironmentSettings
from pyflink.common import Configuration
import sys, argparse

from stability_udf import *

DEFAULT_BOOTSTRAP = 'broker:29092'


def main(site_id_filter: int, input_kafka_topic: str, bootstrap_servers: str):
    
    
    pipeline_name = f"Flink_avg2-{input_kafka_topic}-{site_id_filter}"

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
    flink_python_jar    = "file:///opt/flink/opt/flink-python-1.20.1.jar" # <--- ENSURE THIS PATH AND FILENAME ARE EXACT
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
            'properties.group.id'           = 'avg1_{site_id_filter}',
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
        "calculate_stability_score",    # Name for the scalar UDF in SQL
        calculate_stability_score       # Reference the imported function directly
    )
    
    # --------------------------------------------------------------------------
    # We accepting that the target output table has been pre created
    # --------------------------------------------------------------------------
    
    
    # --------------------------------------------------------------------------
    # Run Tumbling select on source Input stream and output to Fluss
    # --------------------------------------------------------------------------
    aggregation_sql = f"""
        INSERT INTO fluss_catalog.fluss.factory_iot_stab
            (siteId, deviceId, sensorId, partition_month, stability_factor, measurement_count, min_measurement, avg_measurement, max_measurement, window_start, window_end)
            SELECT
                 metadata.siteId                                                                 AS siteId
                ,metadata.deviceId                                                               AS deviceId
                ,metadata.sensorId                                                               AS sensorId
                ,DATE_FORMAT(ts_wm, 'yyyyMM')                                                    AS partition_month
                ,calculate_stability_score(MIN(measurement), AVG(measurement), MAX(measurement)) AS stability_factor -- Apply UDF here
                ,COUNT(measurement)                                                              AS measurement_count
                ,MIN(measurement)                                                                AS min_measurement
                ,AVG(measurement)                                                                AS avg_measurement
                ,MAX(measurement)                                                                AS max_measurement
                ,window_start                                                                    AS window_start
                ,window_end                                                                      AS window_end
            FROM TABLE(
                TUMBLE(TABLE kafka_source, DESCRIPTOR(ts_wm), INTERVAL '1' MINUTES)
                )
            WHERE metadata.siteId = {site_id_filter}
            GROUP BY
                 metadata.siteId
                ,metadata.deviceId
                ,metadata.sensorId
                ,DATE_FORMAT(ts_wm, 'yyyyMM')
                ,window_start
                ,window_end;
    """
    statement_set.add_insert_sql(aggregation_sql)

    statement_set.execute().wait()
    print(f"PyFlink job finished for siteId: {site_id_filter}, flatten and calculate avg & stability factor from topic: {input_kafka_topic}, outputting to fluss")

#end main


if __name__ == "__main__":
    
    try:
        parser = argparse.ArgumentParser(description="PyFlink IoT Data Processing Job")
        
        parser.add_argument("--siteId", 
                            type    = int, 
                            required= True,
                            help    = "The site ID to filter data for.")
        
        parser.add_argument("--source", 
                            type    = str, 
                            required= True,
                            help    = "The Kafka input topic name.")

        args = parser.parse_args()

    except Exception as err:    
        print("Usage: python flink_job1.py siteId=<site_id> source=<source_topic>")

        print(f"Must provide input parameters: {err}")

        sys.exit(1)
            
    #end try
    
    
    if len(sys.argv) > 0:
                
        siteId = args.siteId
        source = args.source
        
    try:
        main(siteId, source, DEFAULT_BOOTSTRAP)
        
    except Exception as err:
        print(f"An unexpected error occurred: {err}")
        sys.exit(1)
        
    #end try
#end __main__