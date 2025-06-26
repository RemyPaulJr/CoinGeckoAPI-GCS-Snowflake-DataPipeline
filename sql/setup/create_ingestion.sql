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
