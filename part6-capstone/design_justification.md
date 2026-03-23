## Storage Systems

For this architecture, I selected a combination of a Data Lake, Data Warehouse, and a Vector Database to address the four goals effectively. A Data Lake is used to store raw and semi-structured data such as ICU vitals, patient notes, and historical treatment logs. This is essential for scalability and for supporting machine learning use cases like predicting patient readmission risk. A Data Warehouse is used for structured, cleaned data such as billing, patient summaries, and hospital operations data. This enables efficient reporting for management, including metrics like bed occupancy and department-wise costs.

For enabling natural language queries by doctors, a Vector Database is introduced. Patient records and medical history are converted into embeddings and stored in the vector database, allowing semantic search. This enables accurate retrieval even when queries are phrased differently from stored records.

For real-time ICU data, a streaming platform (such as Kafka) feeds data into the Data Lake, ensuring both real-time processing and long-term storage.

## OLTP vs OLAP Boundary

The OLTP layer consists of systems like EHR and billing platforms, where transactional operations such as patient updates, prescriptions, and payments occur. These systems prioritize consistency and low latency.

The OLAP layer begins once data is ingested into the Data Lake and Data Warehouse. At this point, data is transformed, aggregated, and used for analytics, reporting, and machine learning. The boundary lies at the ingestion layer, where transactional data is extracted and moved into analytical systems. This separation ensures that operational systems are not impacted by heavy analytical workloads.

## Trade-offs

A key trade-off in this design is increased system complexity due to the use of multiple storage systems (Data Lake, Data Warehouse, and Vector Database). While this enables flexibility and supports diverse use cases, it also increases maintenance overhead and requires careful data synchronization.

To mitigate this, a unified data orchestration layer (such as Airflow) can be implemented to manage data pipelines and ensure consistency across systems. Additionally, adopting a Lakehouse approach in the future could reduce complexity by consolidating storage and analytics into a single platform while retaining performance and flexibility.
