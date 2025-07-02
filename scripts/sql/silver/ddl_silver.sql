USE schema silver;

-- consistent, meaningful, well-labeled data column names for silver table
CREATE OR REPLACE TABLE coin_market_data (
    asset_name STRING,
    asset_symbol STRING,
    price_usd FLOAT,
    market_cap_usd NUMBER,
    market_rank INT,
    fully_diluted_valuation NUMBER,
    volume_24h_usd NUMBER,
    high_24h_usd FLOAT,
    low_24h_usd FLOAT,
    price_change_24h_usd FLOAT,
    price_change_pct_24h FLOAT,
    market_cap_change_24h_usd NUMBER,
    market_cap_change_pct_24h FLOAT,
    supply_circulating NUMBER,
    supply_total NUMBER,
    supply_max NUMBER,
    all_time_high_usd FLOAT,
    ath_change_pct FLOAT,
    ath_date TIMESTAMP_TZ,
    all_time_low_usd FLOAT,
    atl_change_pct FLOAT,
    atl_date TIMESTAMP_TZ,
    ingestion_timestamp STRING
);