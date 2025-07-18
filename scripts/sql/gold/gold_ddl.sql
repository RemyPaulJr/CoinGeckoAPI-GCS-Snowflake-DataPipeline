
/*
===============================================================================
DDL Script: Create Gold Views
===============================================================================
Script Purpose:
    This script creates views for the Gold layer in the data warehouse. 
    The Gold layer represents the final dimension and fact tables (Star Schema)

    Each view performs transformations and combines data from the Silver layer 
    to produce a clean, enriched, and business-ready dataset.

Usage:
    - These views can be queried directly for analytics and reporting.
===============================================================================
*/

-- =============================================================================
-- Create Dimension: gold.dim_customers
-- =============================================================================
CREATE OR REPLACE VIEW gold.top_10_market_cap AS
SELECT
    market_rank,
    asset_name,
    asset_symbol,
    market_cap_usd
FROM silver.coin_market_data
WHERE market_rank <= 10
ORDER BY market_rank;

-- =============================================================================
-- View: gold.top_10_market_cap_change_usd
-- Purpose: Shows assets with the largest absolute market cap gain in 24h.
-- =============================================================================
CREATE OR REPLACE VIEW gold.top_10_market_cap_change_usd AS
SELECT
    market_rank,
    asset_name,
    asset_symbol,
    market_cap_usd,
    market_cap_change_24h_usd,
    market_cap_change_pct_24h
FROM silver.coin_market_data
ORDER BY market_cap_change_24h_usd DESC
LIMIT 10;

-- =============================================================================
-- View: gold.top_10_market_cap_change_pct
-- Purpose: Shows assets with the highest market cap percentage growth in 24h.
-- =============================================================================
CREATE OR REPLACE VIEW gold.top_10_market_cap_change_pct AS
SELECT
    market_rank,
    asset_name,
    asset_symbol,
    market_cap_usd,
    market_cap_change_24h_usd,
    market_cap_change_pct_24h
FROM silver.coin_market_data
ORDER BY market_cap_change_pct_24h DESC
LIMIT 10;

-- =============================================================================
-- View: gold.top_10_price_change_usd
-- Purpose: Shows assets with the largest absolute price increase in 24h.
-- =============================================================================
CREATE OR REPLACE VIEW gold.top_10_price_change_usd AS
SELECT
    market_rank,
    asset_name,
    asset_symbol,
    price_usd,
    price_change_24h_usd,
    price_change_pct_24h
FROM silver.coin_market_data
ORDER BY price_change_24h_usd DESC
LIMIT 10;

-- =============================================================================
-- View: gold.top_10_price_change_pct
-- Purpose: Shows assets with the largest percentage price increase in 24h.
-- =============================================================================
CREATE OR REPLACE VIEW gold.top_10_price_change_pct AS
SELECT
    market_rank,
    asset_name,
    asset_symbol,
    price_usd,
    price_change_24h_usd,
    price_change_pct_24h
FROM silver.coin_market_data
ORDER BY price_change_pct_24h DESC
LIMIT 10;

-- =============================================================================
-- View: gold.top_10_price_swing
-- Purpose: Shows assets with the largest high-low price swings in 24h.
-- =============================================================================
CREATE OR REPLACE VIEW gold.top_10_price_swing AS
SELECT
    market_rank,
    asset_name,
    asset_symbol,
    price_usd,
    high_24h_usd,
    low_24h_usd,
    (high_24h_usd - low_24h_usd) AS price_swing
FROM silver.coin_market_data
ORDER BY price_swing DESC
LIMIT 10;

-- =============================================================================
-- View: gold.top_10_ath_drop_pct
-- Purpose: Shows assets with the highest percentage drop from all-time highs.
-- =============================================================================
CREATE OR REPLACE VIEW gold.top_10_ath_drop_pct AS
SELECT
    market_rank,
    asset_name,
    asset_symbol,
    price_usd,
    all_time_high_usd,
    ROUND(((all_time_high_usd - price_usd) / all_time_high_usd) * 100, 2) AS historical_ath_drop_pct
FROM silver.coin_market_data
ORDER BY historical_ath_drop_pct
LIMIT 10;

-- =============================================================================
-- View: gold.top_10_atl_inc_pct
-- Purpose: Shows assets with the highest rebound from all-time lows.
-- =============================================================================
COINGECKO.GOLD.TOP_10_ATH_DROP_PCT

-- =============================================================================
-- View: gold.top_10_uncapped_supply
-- Purpose: Shows top 10 market rank assets with no defined maximum supply.
-- =============================================================================
CREATE OR REPLACE VIEW gold.top_10_uncapped_supply AS
SELECT
    market_rank,
    asset_name,
    asset_symbol,
    market_cap_usd,
    COALESCE(CAST(supply_max AS STRING), 'Theoretically uncapped') AS supply_max
FROM silver.coin_market_data
WHERE supply_max IS NULL
    OR supply_max = 0
LIMIT 10;