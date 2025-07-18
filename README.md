# CoinGeckoAPI-GCS-BigQuery-DataPipeline

> **Note**: This project originally used Snowflake as the data warehouse but transitioned to BigQuery due to free trial limitations. Both implementations are documented for learning purposes.

## 🚀 Project Overview

This project demonstrates a complete **end-to-end data pipeline** that collects cryptocurrency market data from the CoinGecko API, processes it through a **Medallion Architecture** (Bronze → Silver → Gold), and stores it in a cloud data warehouse for analysis. Originally built with Snowflake, the project evolved to use BigQuery as the primary data warehouse.

**Perfect for**: Data Engineers, Students, and anyone interested in modern data engineering practices.

## 🏗️ Architecture Overview

### Medallion Architecture (Bronze → Silver → Gold)

```
📊 CoinGecko API → 🐍 Python → 🏪 GCS → 🏢 Data Warehouse → 📈 Analytics
                              ↓
                    Bronze (Raw Data)
                              ↓
                    Silver (Cleaned Data)
                              ↓
                    Gold (Business Metrics)
```

- **Bronze Layer**: Raw API data stored as Parquet files
- **Silver Layer**: Cleaned, standardized data with meaningful column names
- **Gold Layer**: Business-ready views and aggregations for analytics

### Technology Evolution

| Component | Original | Current | Reason |
|-----------|----------|---------|--------|
| Data Warehouse | Snowflake | BigQuery | Free trial ended |
| Storage | GCS | GCS | ✅ Consistent |
| Orchestration | Airflow | Airflow | ✅ Consistent |
| Processing | Python | Python | ✅ Consistent |

## 🛠️ Tech Stack

- **Data Collection**: Python, CoinGecko API
- **Storage**: Google Cloud Storage (Parquet format)
- **Data Warehouse**: BigQuery (originally Snowflake)
- **Orchestration**: Apache Airflow
- **Data Format**: Parquet for efficient storage and querying

## 📁 Project Structure

```
├── api-data/                    # Sample Parquet files
├── scripts/
│   ├── python/                  # Data collection scripts
│   └── sql/                     # Database schemas and 
│       ├── bronze/              # Raw data layer
│       ├── silver/              # Cleaned data layer
│       ├── gold/                # Business metrics layer
│       └── snowflake/           # Original Snowflake integration
├── docs/                        # Documentation
├── airflow/                     # Airflow configuration
└── requirements.txt             # Python dependencies
```

## 🚀 Quick Start

### Prerequisites
- Python 3.8+
- Google Cloud Platform account
- CoinGecko API key (free tier available)
- Basic understanding of SQL and cloud services

### Setup Instructions

1. **Clone the Repository**
   ```bash
   git clone https://github.com/yourusername/CoinGeckoAPI-GCS-BigQuery-DataPipeline.git
   cd CoinGeckoAPI-GCS-BigQuery-DataPipeline
   ```

2. **Install Dependencies**
   ```bash
   pip install -r requirements.txt
   ```

3. **Configure Environment Variables**
   Create a `.env` file:
   ```bash
   API_KEY=your_coingecko_api_key
   GOOGLE_APPLICATION_CREDENTIALS=/path/to/your/service-account.json
   GCP_PROJECT_ID=your_gcp_project_id
   ```

4. **Set up Google Cloud Resources**
   - Create a GCS bucket for data storage
   - Set up BigQuery datasets: `bronze`, `silver`, `gold`
   - Configure IAM permissions for your service account

5. **Run the Pipeline**
   ```bash
   python scripts/python/coin-gecko-data-pipeline.py
   ```

6. **Set up Airflow (Optional)**
   ```bash
   airflow db init
   airflow dags trigger crypto_data_pipeline
   ```

## 📊 Data Flow

### 1. Data Collection
- Fetch cryptocurrency market data from CoinGecko API
- Process and clean the JSON response
- Save as Parquet files locally and upload to GCS

### 2. Bronze Layer (Raw Data)
- Store raw API data with minimal transformation
- Preserve original data structure for auditing
- Include ingestion timestamps

### 3. Silver Layer (Cleaned Data)
- Standardize column names (e.g., `name` → `asset_name`)
- Apply data type conversions
- Handle null values and data quality issues

### 4. Gold Layer (Business Metrics)
- Create analytical views for business insights:
  - Top 10 cryptocurrencies by market cap
  - Biggest price movers (24h)
  - Historical performance metrics
  - Supply analysis

## 🔄 Migration: Snowflake → BigQuery

### Why the Switch?
- **Snowflake**: Excellent for learning, but free trial has time limits
- **BigQuery**: Pay-per-query model, better for long-term learning projects
- **Compatibility**: Both support similar SQL syntax and Parquet integration

### Migration Benefits
- **Cost Efficiency**: No monthly charges, pay only for queries
- **GCS Integration**: Native integration with Google Cloud Storage
- **Scalability**: Automatic scaling without cluster management
- **Airflow Support**: Excellent Apache Airflow operators available

## 🎯 Learning Outcomes

After completing this project, you'll understand:
- **API Integration**: Working with REST APIs and handling JSON data
- **Data Formats**: Benefits of Parquet for analytics workloads
- **Cloud Storage**: Google Cloud Storage best practices
- **Data Warehousing**: Medallion Architecture implementation
- **Workflow Orchestration**: Apache Airflow for automation
- **SQL Analytics**: Writing business intelligence queries
- **Migration Strategies**: Moving between cloud data platforms

## 🤝 Contributing

Contributions are welcome! Whether you're:
- **Students**: Learning data engineering
- **Professionals**: Sharing best practices
- **Recruiters**: Understanding modern data stacks

Feel free to:
- Open issues for questions or improvements
- Submit pull requests with enhancements
- Share feedback on the architecture

## 📚 Additional Resources

- [Detailed Setup Guide](docs/setup-guide.md) *(Coming Soon)*
- [Snowflake Implementation](scripts/sql/snowflake/) *(Legacy)*
- [BigQuery Migration Guide](docs/migration-guide.md) *(Coming Soon)*
- [Airflow DAG Examples](docs/airflow-orchestration.md)

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

**Built with ❤️ for the data community**

*This project showcases real-world data engineering challenges and solutions, making it perfect for portfolio demonstrations and technical interviews.*
