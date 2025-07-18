COPY INTO @gold_stage/top_10_ath_drop_pct/
FROM (
    SELECT * FROM gold.top_10_ath_drop_pct
)
FILE_FORMAT = ( 
    TYPE = 'PARQUET'
)
OVERWRITE = TRUE;

COPY INTO @gold_stage/top_10_atl_recovery_pct/
FROM (
    SELECT * FROM gold.top_10_atl_recovery_pct
)
FILE_FORMAT = ( 
    TYPE = 'PARQUET'
)
OVERWRITE = TRUE;

COPY INTO @gold_stage/top_10_market_cap/
FROM (
    SELECT * FROM gold.top_10_market_cap
)
FILE_FORMAT = ( 
    TYPE = 'PARQUET'
)
OVERWRITE = TRUE;

COPY INTO @gold_stage/top_10_market_cap_change_pct/
FROM (
    SELECT * FROM gold.top_10_market_cap_change_pct
)
FILE_FORMAT = ( 
    TYPE = 'PARQUET'
)
OVERWRITE = TRUE;

COPY INTO @gold_stage/top_10_market_cap_change_usd/
FROM (
    SELECT * FROM gold.top_10_market_cap_change_usd
)
FILE_FORMAT = ( 
    TYPE = 'PARQUET'
)
OVERWRITE = TRUE;

COPY INTO @gold_stage/top_10_price_change_pct/
FROM (
    SELECT * FROM gold.top_10_price_change_pct
)
FILE_FORMAT = ( 
    TYPE = 'PARQUET'
)
OVERWRITE = TRUE;

COPY INTO @gold_stage/top_10_price_change_usd/
FROM (
    SELECT * FROM gold.top_10_price_change_usd
)
FILE_FORMAT = ( 
    TYPE = 'PARQUET'
)
OVERWRITE = TRUE;

COPY INTO @gold_stage/top_10_price_swing/
FROM (
    SELECT * FROM gold.top_10_price_swing
)
FILE_FORMAT = ( 
    TYPE = 'PARQUET'
)
OVERWRITE = TRUE;

COPY INTO @gold_stage/top_10_uncapped_supply/
FROM (
    SELECT * FROM gold.top_10_uncapped_supply
)
FILE_FORMAT = ( 
    TYPE = 'PARQUET'
)
OVERWRITE = TRUE;

LIST @gold_stage