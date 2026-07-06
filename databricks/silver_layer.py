from pyspark.sql import DataFrame
from pyspark.sql.functions import col, concat_ws, month, regexp_replace, split, to_timestamp, year

storage_account = "<storage-account-name>"
bronze_container = "bronze"
silver_container = "silver"


def bronze_path(folder: str) -> str:
    return f"abfss://{bronze_container}@{storage_account}.dfs.core.windows.net/{folder}"


def silver_path(folder: str) -> str:
    return f"abfss://{silver_container}@{storage_account}.dfs.core.windows.net/{folder}"


def read_bronze_csv(folder: str) -> DataFrame:
    return (
        spark.read.format("csv")
        .option("header", True)
        .option("inferSchema", True)
        .load(bronze_path(folder))
    )


def write_silver_parquet(df: DataFrame, folder: str) -> None:
    df.write.format("parquet").mode("overwrite").save(silver_path(folder))


calendar = read_bronze_csv("AdventureWorks_Calendar").withColumn("Month", month(col("Date"))).withColumn(
    "Year", year(col("Date"))
)
write_silver_parquet(calendar, "Calendar")

customers = read_bronze_csv("AdventureWorks_Customers").withColumn(
    "CustomerName", concat_ws(" ", col("Prefix"), col("FirstName"), col("LastName"))
)
write_silver_parquet(customers, "Customers")

products = read_bronze_csv("AdventureWorks_Products").withColumn(
    "ProductSKU", split(col("ProductSKU"), "-").getItem(0)
).withColumn("ProductNameShort", split(col("ProductName"), " ").getItem(0))
write_silver_parquet(products, "Products")

sales = read_bronze_csv("AdventureWorks_Sales*").withColumn(
    "StockDate", to_timestamp("StockDate")
).withColumn("OrderNumber", regexp_replace(col("OrderNumber"), "S", "T")).withColumn(
    "TotalQuantity", col("OrderLineItem") * col("OrderQuantity")
)
write_silver_parquet(sales, "Sales")

write_silver_parquet(read_bronze_csv("AdventureWorks_Product_Categories"), "Product_Categories")
write_silver_parquet(read_bronze_csv("AdventureWorks_Product_Subcategories"), "Product_Subcategories")
write_silver_parquet(read_bronze_csv("AdventureWorks_Returns"), "Returns")
write_silver_parquet(read_bronze_csv("AdventureWorks_Territories"), "Territories")

