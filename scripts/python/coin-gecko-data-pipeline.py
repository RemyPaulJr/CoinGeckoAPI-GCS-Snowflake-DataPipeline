import os
import requests
import pandas as pd
from datetime import datetime, date, timezone
import pyarrow
from google.cloud import storage

# Capture timestamp for ingestion and today's date for filename
timestamp = datetime.now(timezone.utc)
today = date.today()

# HTTP API Request
api_key = 'CG-8WyLFY96RG7oAkLc8Z6AVm3L' 

url = f"https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&x_cg_demo_api_key={api_key}"
headers = {"accept": "application/json"}
response = requests.get(url, headers=headers)

# Convert response in json format and store as a dataframe
data = response.json()
df = pd.DataFrame(data)

# Specify which columns I need/want
column_names = ['name','symbol','current_price', 'market_cap', 'market_cap_rank',
                'fully_diluted_valuation','total_volume','high_24h','low_24h','price_change_24h',
                'price_change_percentage_24h','market_cap_change_24h','market_cap_change_percentage_24h',
                'circulating_supply','total_supply','max_supply','ath','ath_change_percentage','ath_date',
                'atl','atl_change_percentage','atl_date']

filtered_df = df[column_names]

# Create a column for the time the data is ingested.
filtered_df.loc[:,'ingestion_timestamp'] = timestamp
# filtered_df_10 = filtered_df.head(10)
# Save the top 10 cryto data frame to a parquet file
file_name = f'{today}_CoinGeckoMarketList.parquet' # Name file
save_path = '/root/dev/python/dev/coingecko-data-pipeline/api-data' # Store path to save file in a variable
filtered_df.to_parquet(os.path.join(save_path, file_name), engine='pyarrow', index=False) # Save file at that path

# Initialize the client
client = storage.Client()

# Specify the bucket name
bucket_name = 'crypto-raw'
bucket = client.get_bucket(bucket_name)

# Specify the file name in your local system and the destination path in the bucket
source_file_name = f'/root/dev/python/dev/coingecko-data-pipeline/api-data/{today}_CoinGeckoMarketList.parquet'  # Parquet file path on your system
destination_blob_name = f'bronze/{today}_CoinGeckoMarketList.parquet'  # Path in the GCP bucket

# Upload the file
blob = bucket.blob(destination_blob_name)
blob.upload_from_filename(source_file_name)

print(f"File {source_file_name} uploaded to {destination_blob_name}.")

