
# in devlab0 directory execute:

make jm

# now copy and paste the below into the prompt of the jobmanager.

# Note the "-pyfs /pyapp/complex_udf.py" extra line that pulls in our dependency file.

******** Flatten, combine siteId and deviceId  -> Out to fluss_catalog.fluss.factory_iot_complex

/opt/flink/bin/flink run \
    -m jobmanager:8081 \
    -py /pyapp/flink_flat3.py \
    -pyfs /pyapp/complex_udf.py \
    --siteId 101 \
    --source factory_iot_north 


/opt/flink/bin/flink run \
    -m jobmanager:8081 \
    -py /pyapp/flink_flat3.py \
    -pyfs /pyapp/complex_udf.py \
    --siteId 102 \
    --source factory_iot_south


/opt/flink/bin/flink run \
    -m jobmanager:8081 \
    -py /pyapp/flink_flat3.py \
    -pyfs /pyapp/complex_udf.py \
    --siteId 103 \
    --source factory_iot_east