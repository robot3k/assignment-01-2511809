## Storage Systems

For this architecture, multiple storage systems are used to support different requirements.

A relational database (MySQL/PostgreSQL) is used as the OLTP system to store structured patient records, billing data, and transactional updates. This ensures strong consistency and reliability for critical healthcare data.

A Data Lake is used to store raw data such as ICU device streams, logs, and unstructured doctor notes. This allows flexibility in handling large volumes of diverse data formats.

A Data Warehouse is used for analytics and reporting. Cleaned and transformed data from the data lake is loaded into the warehouse to generate reports such as bed occupancy and department-wise costs.

For AI-based predictions, processed data is used to train machine learning models that predict patient readmission risk.

---

## OLTP vs OLAP Boundary

The OLTP system handles real-time transactional operations such as patient admissions, updates, and billing. This system prioritizes consistency and fast writes.

The OLAP system begins once data is extracted from the OLTP system and moved into the data lake and data warehouse. Here, data is processed, cleaned, and aggregated for analytics and reporting.

This separation ensures that analytical queries do not impact the performance of transactional systems.

---

## Trade-offs

One major trade-off in this architecture is the increased complexity due to multiple systems (OLTP, Data Lake, Data Warehouse, and ML pipelines).

While this improves scalability and flexibility, it also increases maintenance overhead and integration challenges.

To mitigate this, a well-defined data pipeline and orchestration tools can be used to automate data flow. Additionally, monitoring systems can be implemented to ensure data consistency and reliability across components.
