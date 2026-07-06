# Data Dictionary

## Source Tables

- `AdventureWorks_Calendar.csv`: calendar dimension source with date fields.
- `AdventureWorks_Customers.csv`: customer attributes used for customer dimension modelling.
- `AdventureWorks_Products.csv`: product attributes and product identifiers.
- `AdventureWorks_Product_Categories.csv`: product category reference data.
- `AdventureWorks_Product_Subcategories.csv`: product subcategory reference data.
- `AdventureWorks_Returns.csv`: returned product transactions.
- `AdventureWorks_Sales_2015.csv`, `AdventureWorks_Sales_2016.csv`, `AdventureWorks_Sales_2017.csv`: sales transactions.
- `AdventureWorks_Territories.csv`: territory and geography reference data.

## Transformation Examples

- Calendar: derives `Month` and `Year`.
- Customers: creates `CustomerName` from prefix, first name and last name.
- Products: normalizes SKU and derives a short product name.
- Sales: converts `StockDate` to timestamp, standardizes order numbers and calculates `TotalQuantity`.
