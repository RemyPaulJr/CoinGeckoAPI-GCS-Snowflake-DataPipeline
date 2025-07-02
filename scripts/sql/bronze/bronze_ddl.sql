USE SCHEMA bronze;

CREATE OR REPLACE TABLE coin_market_data (
    name STRING,
    symbol STRING,
    current_price FLOAT,
    market_cap NUMBER,
    market_cap_rank INT,
    fully_diluted_valuation NUMBER,
    total_volume NUMBER,
    high_24h FLOAT,
    low_24h FLOAT,
    price_change_24h FLOAT,
    price_change_percentage_24h FLOAT,
    market_cap_change_24h NUMBER,
    market_cap_change_percentage_24h FLOAT,
    circulating_supply NUMBER,
    total_supply NUMBER,
    max_supply NUMBER,
    ath FLOAT,
    ath_change_percentage FLOAT,
    ath_date TIMESTAMP_TZ,
    atl FLOAT,
    atl_change_percentage FLOAT,
    atl_date TIMESTAMP_TZ,
    ingestion_timestamp TIMESTAMP_TZ
    );