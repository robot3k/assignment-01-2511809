# Part 1 — Relational Databases: Normalization

## Anomaly Analysis

The orders_flat.csv file stores everything in a single table — customer details, product info, sales rep data, and order records all mixed into one row. This design leads to three types of data anomalies.

---

### Insert Anomaly

An insert anomaly happens when you cannot add new information to the database without also adding something unrelated.

In this file, every row is tied to an order. If the company brings on a new sales rep before they handle any orders, there is nowhere to store that rep's details — no order means no row. The same problem applies to new products. The Webcam (P008) only shows up because of one order, ORD1185. If that order did not exist, the product would have no place in the table at all.

Affected columns: sales_rep_id, sales_rep_name, sales_rep_email, office_address, product_id, product_name, category, unit_price

---

### Update Anomaly

An update anomaly happens when the same piece of information is repeated across many rows, so changing it requires updating every single one of those rows. If even one is missed, the data becomes inconsistent.

This has already happened in the dataset. Deepak Joshi's office address is stored as "Mumbai HQ, Nariman Point, Mumbai - 400021" in most rows, but in several others (ORD1180, ORD1174, ORD1171, ORD1175, ORD1176, ORD1179) it appears as "Mumbai HQ, Nariman Pt, Mumbai - 400021". That is a real inconsistency in the current data, not a hypothetical one. If his office address ever needed to be updated, every one of his order rows would have to be changed manually.

Affected columns: office_address, and by the same logic, sales_rep_name, product_name, and unit_price

---

### Delete Anomaly

A delete anomaly happens when removing a row to get rid of one piece of information also destroys other unrelated information.

The Webcam (P008) appears in exactly one order — ORD1185, placed by Amit Verma on 2023-06-15. If that order gets deleted for any reason, such as a cancellation or correction, all record of the Webcam product disappears with it. The product name, category, and price of 2100 rupees are gone because there is no other row keeping that information alive.

Affected row: ORD1185, columns product_id, product_name, category, unit_price

---

## Normalization Justification

The argument that keeping everything in one table is simpler and that normalization is overkill is worth taking seriously. For a very small, static dataset that nobody ever updates, there is some truth to it. But this dataset is not that.

The proof is already in the file. Deepak Joshi's office address is stored two different ways across the same dataset. That happened because the flat file offers no protection against it. When the same fact is copied into dozens of rows, someone eventually types it differently, and there is no mechanism to catch or prevent that. In a normalized design, the address lives in one row of a SalesReps table. You change it once, and every order connected to that rep reflects the correct value automatically.

The same issue applies to pricing. If the Laptop price changes from 55,000 rupees, every single order row containing a Laptop would need to be updated by hand. With a Products table, that is one update. Without it, it is dozens, and there is no guarantee they all get done.

The single-table approach also creates a practical problem on the way in. You cannot add a new product to the catalog or register a new sales rep until an actual order exists for them. That forces people to either create fake placeholder orders or simply leave the information out until it becomes relevant. Neither is acceptable for a system meant to track real business data.

The four-table structure proposed here — Customers, Products, SalesReps, and Orders — fixes all of these problems. Queries need joins instead of a simple select, but that is a small and one-time trade-off. The alternative is a file that is already showing cracks after fewer than 200 rows. As the business grows, the cost of maintaining a flat file grows with it, while a normalized schema stays clean regardless of volume.

Keeping everything in one table is not simpler. It just moves the complexity out of the schema and into the data, where it causes silent errors instead of obvious ones.
