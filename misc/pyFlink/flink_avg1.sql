
SET 'sql-client.execution.result-mode' = 'tableau';
SET 'parallelism.default' = '2';
SET 'sql-client.verbose' = 'true';
SET 'execution.runtime-mode' = 'streaming';

select siteId, deviceId, sensorId, measurement_count, avg_measurement, min_measurement, max_measurement, window_start, window_end from fluss_catalog.fluss.factory_iot_avg;