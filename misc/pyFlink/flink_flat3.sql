
SET 'sql-client.execution.result-mode' = 'tableau';
SET 'parallelism.default' = '2';
SET 'sql-client.verbose' = 'true';
SET 'execution.runtime-mode' = 'streaming';

select ts, siteId, deviceId, sensorId, complex, unit, measurement from fluss_catalog.fluss.factory_iot_complex;