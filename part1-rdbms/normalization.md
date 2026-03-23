## Anomaly Analysis

1. An Insert Anomaly - Can’t add data independently

Row 1 (Basically applicable to any row), Columns product_id, product_name, category, unit_price

2. Update Anomaly - Same info repeated everywhere

P004 – Notebook appears in 34 rows in the dataset. Columns product_id, product_name, category, unit_price

3. Delete Anomaly — Deleting one row deletes history

Row 3 (Same Customer appears in 19 other rows), Columns customer_id, customer_name, customer_email, customer_city


## Normalization Justification

Keeping everything in the one table creates data maintenance issues in below 3 different ways and hence should be avoided:

Insert Anamoly:
This issue happens when we need to insert some data but we cannot do so withoiut inserting other data.

Example from Dataset:
Consider 1st Row in the dataset. If the organization needs to add a new Product before an order can be placed for it, they cannot do so without inserting below details:
order_id
customer_id
sales_rep_id
quantity
order_date

Since we cannot place an order transaction for a Product which hsan't been introduced yet, this created an insert Anamoly

Update Anomaly:
This issue happens when same information is repeated in the dataset and it needs to be updated.

Example from Dataset:
In Row 1, Product P04 has been ordered multiple Times in the dataset. Consider below columns:
product_id
product_name
unit_price

If the Price changes from 120 to 150 all the rows with this Product ID must be updated to have consistend Data.

Similarly consider Row 2, SR01 Sales Rep. If a Sales rep moved from one Office to Another, similar inconsistency will follow.

Delete Anamoly:
This issue happens when deleting one piece of information will lead to deletion of other important data.

In Row 4 for P007, if this order needs to be deleted due to wrong entry or any other reason, then the Product data might be lost if that's the only transaction for this Product.
