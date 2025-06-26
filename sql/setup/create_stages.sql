-- =====================================================
-- Step 2: Retrieve the GCS Service Account from Snowflake
-- =====================================================

DESC STORAGE INTEGRATION silver_crypto_data;

-- =====================================================
-- Step 3: Create External Stages for Each Layer
-- =====================================================

-- Bronze Stage
USE SCHEMA bronze;

CREATE OR REPLACE STAGE bronze_stage
    URL = 'gcs://crypto-raw/bronze/'
    STORAGE_INTEGRATION = silver_crypto_data
    FILE_FORMAT = (TYPE = 'PARQUET');

-- Silver Stage
USE SCHEMA silver;

CREATE OR REPLACE STAGE silver_stage
    URL = 'gcs://crypto-raw/silver/'
    STORAGE_INTEGRATION = silver_crypto_data
    FILE_FORMAT = (TYPE = 'PARQUET');

-- Gold Stage
USE SCHEMA gold;

CREATE OR REPLACE STAGE gold_stage
    URL = 'gcs://crypto-raw/gold/'
    STORAGE_INTEGRATION = silver_crypto_data
    FILE_FORMAT = (TYPE = 'PARQUET');

-- Optional: Drop stages if a mistake was made
/*
DROP STAGE IF EXISTS bronze.bronze_stage;
DROP STAGE IF EXISTS silver.silver_stage;
DROP STAGE IF EXISTS gold.gold_stage;
*/

