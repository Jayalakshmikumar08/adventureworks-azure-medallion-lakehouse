IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'gold')
    EXEC('CREATE SCHEMA gold');
GO

CREATE MASTER KEY ENCRYPTION BY PASSWORD = '<strong-password>';
GO

CREATE DATABASE SCOPED CREDENTIAL lakehouse_managed_identity
WITH IDENTITY = 'Managed Identity';
GO

CREATE EXTERNAL DATA SOURCE silver_data_lake
WITH (
    LOCATION = 'https://<storage-account-name>.dfs.core.windows.net/silver',
    CREDENTIAL = lakehouse_managed_identity
);
GO

CREATE EXTERNAL FILE FORMAT parquet_snappy
WITH (
    FORMAT_TYPE = PARQUET,
    DATA_COMPRESSION = 'org.apache.hadoop.io.compress.SnappyCodec'
);
GO

CREATE OR ALTER VIEW gold.calendar AS
SELECT *
FROM OPENROWSET(
    BULK 'Calendar',
    DATA_SOURCE = 'silver_data_lake',
    FORMAT = 'PARQUET'
) AS rows;
GO

CREATE OR ALTER VIEW gold.customers AS
SELECT *
FROM OPENROWSET(
    BULK 'Customers',
    DATA_SOURCE = 'silver_data_lake',
    FORMAT = 'PARQUET'
) AS rows;
GO

CREATE OR ALTER VIEW gold.products AS
SELECT *
FROM OPENROWSET(
    BULK 'Products',
    DATA_SOURCE = 'silver_data_lake',
    FORMAT = 'PARQUET'
) AS rows;
GO

CREATE OR ALTER VIEW gold.sales AS
SELECT *
FROM OPENROWSET(
    BULK 'Sales',
    DATA_SOURCE = 'silver_data_lake',
    FORMAT = 'PARQUET'
) AS rows;
GO

CREATE OR ALTER VIEW gold.returns AS
SELECT *
FROM OPENROWSET(
    BULK 'Returns',
    DATA_SOURCE = 'silver_data_lake',
    FORMAT = 'PARQUET'
) AS rows;
GO

CREATE OR ALTER VIEW gold.territories AS
SELECT *
FROM OPENROWSET(
    BULK 'Territories',
    DATA_SOURCE = 'silver_data_lake',
    FORMAT = 'PARQUET'
) AS rows;
GO

