 
# in devlab0 directory execute:

make jm

# now copy and paste the below into the prompt of the jobmanager.

******** Avg Example - Output to fluss_catalog.fluss.factory_iot_stab

/opt/flink/bin/flink run \
    -m jobmanager:8081 \
    -py /pyapp/flink_avg2.py \
    -pyfs /pyapp/stability_udf.py \
    --siteId 101 \
    --source factory_iot_north 


/opt/flink/bin/flink run \
    -m jobmanager:8081 \
    -py /pyapp/flink_avg2.py \
    -pyfs /pyapp/stability_udf.py \
    --siteId 102 \
    --source factory_iot_south


/opt/flink/bin/flink run \
    -m jobmanager:8081 \
    -py /pyapp/flink_avg2.py \
    -pyfs /pyapp/stability_udf.py \
    --siteId 103 \
    --source factory_iot_east
