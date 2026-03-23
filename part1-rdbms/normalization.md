## Anomaly Analysis

**Insert Anomaly**
In the current dataset, we cannot add a new product unless it is part of an order. This means if a new product is introduced but hasn’t been ordered yet, there is no way to store it properly. We would have to create a fake order, which is not ideal.

**Update Anomaly**
Customer details like city are repeated in multiple rows. If a customer’s city changes, we need to update it everywhere. If we miss even one row, the data becomes inconsistent.

**Delete Anomaly**
If we delete an order, we might also lose important information about a product or a customer. For example, if a product appears in only one order and that order is deleted, the product is completely removed from the dataset.

---

## Normalization Justification

At first glance, keeping everything in one table feels easier because all the data is in one place. However, while working with the dataset, it became clear that this created multiple problems like repeated data and some inconsistencies.

By dividing the data into separate tables such as customers, products, orders, and sales representatives, we removed duplication issues. Each piece of information was stored only once, which made updates much easier and safer.

For example, if a customer’s city changes, we only required to update it in one place. Similarly, products can exist independently without needing an order.

Overall, normalization makes the database more organized, reduces errors, and makes it easier to manage as the data grows. So even though it may seem like extra work initially, it is actually a better and more reliable approach.
