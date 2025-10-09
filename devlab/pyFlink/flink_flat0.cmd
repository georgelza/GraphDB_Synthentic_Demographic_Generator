
# in devlab0 directory execute:

make jm

# now copy and paste the below into the prompt of the jobmanager.

******** Flatten Example  -> Out to Kafka Topics

/opt/flink/bin/flink run \
    -m jobmanager:8081 \
    -py /pyapp/flink_flat0.py \
    --siteId 101 \
    --source factory_iot_north 


/opt/flink/bin/flink run \
    -m jobmanager:8081 \
    -py /pyapp/flink_flat0.py \
    --siteId 102 \
    --source factory_iot_south


/opt/flink/bin/flink run \
    -m jobmanager:8081 \
    -py /pyapp/flink_flat0.py \
    --siteId 103 \
    --source factory_iot_east


# Does not make a difference using -j, the jar's needed to be added to the python file, see line 78/79/80
/opt/flink/bin/flink run \
    -m jobmanager:8081 \
    -py /pyapp/flink_flat0.py \
    -j /opt/flink/lib/flink/flink-sql-connector-kafka-3.3.0-1.20.jar  \
    --siteId 103 \
    --source factory_iot_east
