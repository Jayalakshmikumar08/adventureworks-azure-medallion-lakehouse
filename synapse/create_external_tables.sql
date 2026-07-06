IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'gold')
    EXEC('CREATE SCHEMA gold');
GO

CREATE EXTERNAL DATA SOURCE gold_data_lake
WITH (
    LOCATION = 'https://<storage-account-name>.dfs.core.windows.net/gold',
    CREDENTIAL = lakehouse_managed_identity
);
GO

CREATE EXTERNAL TABLE gold.tbl_sales
WITH (
    LOCATION = 'sales',
    DATA_SOURCE = gold_data_lake,
    FILE_FORMAT = parquet_snappy
)
AS SELECT * FROM gold.sales;
GO

CREATE EXTERNAL TABLE gold.tbl_customers
WITH (
    LOCATION = 'customers',
    DATA_SOURCE = gold_data_lake,
    FILE_FORMAT = parquet_snappy
)
AS SELECT * FROM gold.customers;
GO

CREATE EXTERNAL TABLE gold.tbl_products
WITH (
    LOCATION = 'products',
    DATA_SOURCE = gold_data_lake,
    FILE_FORMAT = parquet_snappy
)
AS SELECT * FROM gold.products;
GO

