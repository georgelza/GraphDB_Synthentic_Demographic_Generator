
SET 'sql-client.execution.result-mode' = 'tableau';
SET 'parallelism.default' = '2';
SET 'sql-client.verbose' = 'true';
SET 'execution.runtime-mode' = 'streaming';

select siteId, deviceId, sensorId, stability_factor, min_measurement, avg_measurement, max_measurement, window_start, window_end from fluss_catalog.fluss.factory_iot_stab;