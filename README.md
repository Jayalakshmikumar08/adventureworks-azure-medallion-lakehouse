# AdventureWorks Azure Medallion Lakehouse

Portfolio project by Jayalakshmi Kumar.

## Scope

This project demonstrates a batch data engineering pipeline on Azure using the AdventureWorks sample dataset.

The goal is to show a clear medallion architecture:

1. Azure Data Factory ingests source CSV files into Azure Data Lake Gen2 bronze storage.
2. Databricks reads bronze CSV files, applies transformations and writes curated Parquet to silver storage.
3. Azure Synapse exposes the silver Parquet data through gold views and optional external tables.
4. The resulting gold layer is ready for BI/reporting tools such as Power BI.

## Architecture

```text
Sample CSV data
  -> Azure Data Factory ingestion
  -> ADLS Gen2 bronze layer
  -> Databricks PySpark transformations
  -> ADLS Gen2 silver Parquet layer
  -> Synapse gold views / external tables
  -> Power BI-ready model
```

## Repository Structure

```text
adf/metadata/file_manifest.json      Source-to-bronze ingestion manifest
databricks/silver_layer.py           PySpark bronze-to-silver transformations
synapse/create_gold_views.sql        Serverless SQL views over silver Parquet
synapse/create_external_tables.sql   Optional materialized external tables
data/sample/                         AdventureWorks sample CSV files
docs/data-dictionary.md              Dataset and transformation notes
```

## Transformations Implemented

- Adds month/year attributes to calendar data.
- Builds a clean customer display name.
- Normalizes product SKU and product-name fields.
- Converts sales stock dates to timestamps.
- Standardizes order numbers.
- Calculates total sales quantity from order line and order quantity.
- Stores curated outputs as Parquet for efficient analytical querying.

## Best Practices Demonstrated

- Separates bronze, silver and gold responsibilities.
- Uses a manifest-driven ingestion pattern for repeatable ADF pipelines.
- Stores curated data in Parquet instead of CSV.
- Uses Synapse external views to avoid unnecessary data movement.
- Keeps secrets and storage account names parameterized.
- Documents the dataset and transformation intent.

## Project Outcomes

- Organised raw AdventureWorks CSV files into a bronze-silver-gold lakehouse flow.
- Used a metadata manifest to make source-to-bronze ingestion repeatable.
- Applied PySpark transformations that clean customer, calendar, product and sales data.
- Stored curated silver data as Parquet for more efficient analytical querying.
- Exposed gold-layer Synapse views and external tables that can support BI/reporting use cases.
