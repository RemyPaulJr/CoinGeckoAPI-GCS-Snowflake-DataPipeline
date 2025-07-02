CREATE OR REPLACE PROCEDURE load_silver()
RETURNS STRING
LANGUAGE SQL
AS
$$
BEGIN
    -- Truncate table if it exists before ingestion data.
    TRUNCATE TABLE IF EXISTS silver.coin_market_data;
    
    INSERT INTO silver.coin_market_data (
        asset_name,
        asset_symbol,
        price_usd,
        market_cap_usd,
        market_rank,
        fully_diluted_valuation,
        volume_24h_usd,
        high_24h_usd,
        low_24h_usd,
        price_change_24h_usd,
        price_change_pct_24h,
        market_cap_change_24h_usd,
        market_cap_change_pct_24h,
        supply_circulating,
        supply_total,
        supply_max,
        all_time_high_usd,
        ath_change_pct,
        ath_date,
        all_time_low_usd,
        atl_change_pct,
        atl_date,
        ingestion_timestamp
    )
    
    SELECT
        name AS asset_name,
        UPPER(symbol) AS asset_symbol,
        current_price AS price_usd,
        market_cap AS market_cap_usd,
        market_cap_rank AS market_rank,
        fully_diluted_valuation AS fully_diluted_valuation,
        total_volume AS volume_24h_usd,
        high_24h AS high_24h_usd,
        low_24h AS low_24h_usd,
        price_change_24h AS price_change_24h_usd,
        CAST(price_change_percentage_24h*100 AS DECIMAL(30,2)) AS price_change_pct_24h,
        market_cap_change_24h AS market_cap_change_24h_usd,
        CAST(market_cap_change_percentage_24h*100 AS DECIMAL(30,2)) AS market_cap_change_pct_24h,
        circulating_supply AS supply_circulating,
        total_supply AS supply_total,
        NULLIF(max_supply,0) AS supply_max,
        ath AS all_time_high_usd,
        CAST(ath_change_percentage*100 AS DECIMAL(30,2)) AS ath_change_pct,
        ath_date,
        atl AS all_time_low_usd,
        CAST(atl_change_percentage*100 AS DECIMAL(30,2)) AS atl_change_pct,
        atl_date,
        CURRENT_TIMESTAMP()
    FROM bronze.coin_market_data;

    RETURN 'Silver layer loaded successfully.';
END;
$$;