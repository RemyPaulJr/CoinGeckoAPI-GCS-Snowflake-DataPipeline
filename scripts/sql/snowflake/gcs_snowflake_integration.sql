  /* This script is used to create the integration between GCS and Snowflake.
 Pre-requisites:
		- Google Cloud Account with the free trial
		- GCS Bucket Create
		- Snowflake Account with the free trial
		- Snowflake SQL worksheet 
*/		

-- =====================================================
-- Step 1: Create a Cloud Storage Integration in Snowflake
-- =====================================================

CREATE STORAGE INTEGRATION silver_crypto_data
    TYPE = EXTERNAL_STAGE
    STORAGE_PROVIDER = 'GCS'
    ENABLED = TRUE
    STORAGE_ALLOWED_LOCATIONS = (
	        'gcs://crypto-raw/silver',
		        'gcs://crypto-raw/bronze',
			        'gcs://crypto-raw/gold'
				    );

				-- Optional: To update allowed locations later
/*
ALTER STORAGE INTEGRATION silver_crypto_data
SET STORAGE_ALLOWED_LOCATIONS = (
    'gcs://crypto-raw/silver',
    'gcs://crypto-raw/bronze',
    'gcs://crypto-raw/gold'
);
*/

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

-- =====================================================
-- Step 4: Create Role and Grant Permissions
-- =====================================================

-- Create a custom role
CREATE ROLE gcs_data_role;

-- Grant access to relevant database and schemas
GRANT USAGE ON DATABASE coingecko TO ROLE gcs_data_role;
GRANT USAGE ON SCHEMA coingecko.bronze TO ROLE gcs_data_role;
GRANT USAGE ON SCHEMA coingecko.silver TO ROLE gcs_data_role;
GRANT USAGE ON SCHEMA coingecko.gold TO ROLE gcs_data_role;

-- Grant stage creation permissions
GRANT CREATE STAGE ON SCHEMA coingecko.bronze TO ROLE gcs_data_role;
GRANT CREATE STAGE ON SCHEMA coingecko.silver TO ROLE gcs_data_role;
GRANT CREATE STAGE ON SCHEMA coingecko.gold TO ROLE gcs_data_role;

-- Grant usage on the integration itself
GRANT USAGE ON INTEGRATION silver_crypto_data TO ROLE gcs_data_role;