
# in devlab0 directory execute:

make jm

# now copy and paste the below into the prompt of the jobmanager.

******** Flatten Example  -> Out to fluss_catalog.fluss.factory_iot_unnested

/opt/flink/bin/flink run \
    -m jobmanager:8081 \
    -py /pyapp/flink_flat1.py \
    --siteId 101 \
    --source factory_iot_north 


/opt/flink/bin/flink run \
    -m jobmanager:8081 \
    -py /pyapp/flink_flat1.py \
    --siteId 102 \
    --source factory_iot_south

/opt/flink/bin/flink run \
    -m jobmanager:8081 \
    -py /pyapp/flink_flat1.py \
    --siteId 103 \
    --source factory_iot_east