## ETL Decisions

### Decision 1 — Date Transformation

# Problem:
The raw dataset didn't contain any NULL or non uniform form. They were consistent `DD-MM-YYYY` format, however, they were stored as a single field. This structure is not optimal for analytical queries that require grouping by month, quarter, or year.

A date like `15-01-2025` cannot be efficiently used for aggregations such as:

* Monthly sales
* Yearly trends
  without additional parsing during query execution.

# Resolution:
The date field was transformed into a dedicated `dim_date` table with separate attributes:

* day
* month
* year

A surrogate key (`date_id`) was introduced and used in the `fact_sales` table. This improves query performance and simplifies time-based analysis.


### Decision 2 — Derived Measures & Data Consistency

# Problem:
The raw dataset did not contain a consistent **total transaction value** field. Revenue needed to be derived from `quantity` and `unit_price`, which is not recommended for analytical queries.

Rows contained:

* `quantity = 5`, `unit_price = 120`
  but no `total_amount` field

# Resolution:
A new measure `total_amount` was calculated during ETL using:
`total_amount = quantity × unit_price`

This derived value was stored in the `fact_sales` table to enable faster queries.


### Decision 3 — Category Normalization

**Problem:**
Product categories in the raw dataset had inconsistent casing (e.g., `electronics`, `ELECTRONICS`, `Electronics`, `Grocery`, `Groceries`), which could lead to duplicate groupings during aggregation.

**Resolution:**
All category values were standardized into a consistent format (e.g., `Electronics`, `Furniture`, `Stationery`) before loading into the `dim_product` table, ensuring accurate grouping and reporting.
