ETL Decisions
This document describes the specific transformation decisions made while cleaning the raw data before loading it into the data warehouse.
ETL Decisions
Decision 1 – Date Format Standardization
Problem: The raw transaction data contained three different date formats across the 300 records:
`YYYY-MM-DD` format (112 rows, e.g., 2023-02-05)
`DD/MM/YYYY` format (105 rows, e.g., 29/08/2023)
`DD-MM-YYYY` format (83 rows, e.g., 12-12-2023)
This inconsistency would cause significant problems for time-based analytical queries, as SQL date functions and comparisons would fail or produce incorrect results when processing mixed formats. Additionally, sorting and grouping by date would not work correctly, rendering month-over-month trend analysis impossible.
Resolution: All date values were converted to the ISO 8601 standard format (`YYYY-MM-DD`) during the ETL process. A parsing function was implemented to detect the source format based on pattern matching (using regular expressions) and then transform each date accordingly. For example:
`29/08/2023` (DD/MM/YYYY) → `2023-08-29`
`12-12-2023` (DD-MM-YYYY) → `2023-12-12`
`2023-02-05` (YYYY-MM-DD) → remained as `2023-02-05`
This standardization ensures that all date-based queries, joins with the dim_date dimension table, and time-series analyses work consistently and correctly.
Decision 2 – Missing Store City Imputation
Problem: The raw data contained 19 records (approximately 6.3% of the dataset) with missing `store_city` values (NULL/empty). Examples include:
TXN5033: Mumbai Central with NULL city
TXN5044: Chennai Anna with NULL city
TXN5082: Delhi South with NULL city
These missing values would break foreign key relationships with the dim_store dimension table and result in incomplete or incorrect location-based analytics. A store without a city cannot be properly attributed to a geographic region for regional sales analysis.
Resolution: The missing city values were inferred from the store names using a lookup mapping established from records with complete data. The mapping was derived by analyzing records where both store_name and store_city were present:
Chennai Anna → Chennai
Delhi South → Delhi
Bangalore MG → Bangalore
Pune FC Road → Pune
Mumbai Central → Mumbai
This deterministic imputation approach was appropriate because each store_name in the dataset maps to exactly one city, making the inference reliable and accurate. The alternative of excluding these 19 records would have resulted in loss of valuable transaction data and potential bias in revenue calculations.
Decision 3 – Category Name Standardization and Consolidation
Problem: The raw data contained inconsistent category naming conventions that would fragment analysis:
Case inconsistency: 'electronics' (lowercase) vs 'Electronics' (capitalized) - appearing in 77 and 83 records respectively
Semantic inconsistency: 'Grocery' vs 'Groceries' - appearing in 127 and 52 records respectively
These inconsistencies would result in fragmented category-based analysis. For example, a query to sum revenue by 'Electronics' category would miss all records labeled 'electronics', leading to incomplete and misleading results. The presence of both 'Grocery' and 'Groceries' suggests they represent the same product category but would be treated as separate categories in aggregations.
Resolution: A category standardization and consolidation mapping was applied:
Case Standardization: All category values were converted to title case (first letter capitalized)
'electronics' → 'Electronics'
Semantic Consolidation: The variants were merged into a single canonical category name
'Groceries' → 'Grocery' (merged into the more standard singular form)
The final standardized categories are:
Electronics (combining 'electronics' and 'Electronics')
Grocery (combining 'Grocery' and 'Groceries')
Clothing (already consistent)
This transformation ensures that all product category analytics produce accurate, consolidated results without artificial fragmentation, enabling meaningful comparisons across all three major product lines.
