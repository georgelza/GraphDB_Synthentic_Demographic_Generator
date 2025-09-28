
-- https://paimon.apache.org/docs/0.7/how-to/creating-catalogs/#creating-a-catalog-with-filesystem-metastore


USE CATALOG default_catalog;

-- Kafka Catalog
CREATE CATALOG kafka_catalog WITH 
    ('type'='generic_in_memory'); 

-- Inbound from Kafka as consumer
CREATE DATABASE IF NOT EXISTS kafka_catalog.inbound;  

-- For pushing back to Kafka as producer
CREATE DATABASE IF NOT EXISTS kafka_catalog.outbound;  


-- Inbound from PostgreSQL via CDC Process
CREATE CATALOG postgres_catalog WITH 
    ('type'='generic_in_memory'); 

CREATE DATABASE IF NOT EXISTS postgres_catalog.inbound;  
-- Will hold intermediate modified from base CDC payload


-- Primarily outbound only...
-- Paimon catalog housed in JDBC based Catalog stored inside PostgreSQL database, inside paimon_catalog schema
CREATE CATALOG c_paimon WITH (
     'type'                          = 'paimon'
    ,'metastore'                     = 'jdbc'                       -- JDBC Based Catalog
    ,'catalog-key'                   = 'jdbc'
    -- JDBC connection to PostgreSQL for persistence
    ,'uri'                           = 'jdbc:postgresql://postgrescat:5432/flink_catalog?currentSchema=paimon'
    ,'jdbc.user'                     = 'dbadmin'
    ,'jdbc.password'                 = 'dbpassword'
    ,'jdbc.driver'                   = 'org.postgresql.Driver'
    -- MinIO S3 configuration with SSL/TLS (if needed)
    ,'warehouse'                     = 's3://warehouse/paimon'      -- bucket / datastore
    ,'s3.endpoint'                   = 'http://minio:9000'          -- MinIO endpoint
    ,'s3.access-key'                 = 'mnadmin'
    ,'s3.secret-key'                 = 'mnpassword'
    ,'s3.path-style-access'          = 'true'                       -- Required for MinIO
    -- Default table properties
    ,'table-default.file.format'     = 'parquet'
);

CREATE DATABASE IF NOT EXISTS c_paimon.outbound;

use c_paimon.outbound;

SHOW DATABASES;

-- now see 1.2.creCdc.sql
