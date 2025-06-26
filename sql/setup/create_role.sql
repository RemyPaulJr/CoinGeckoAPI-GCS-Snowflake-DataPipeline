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
