----------------- DIMENSION TABLES ----------------------

CREATE TABLE dim_date (
    date_id INT PRIMARY KEY,
    full_date DATE NOT NULL,
    day INT NOT NULL,
    month INT NOT NULL,
    year INT NOT NULL
);

CREATE TABLE dim_store (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL
);


CREATE TABLE dim_product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL
);


----------------- FACT TABLE ----------------------

CREATE TABLE fact_sales (
    sales_id INT PRIMARY KEY,
    date_id INT NOT NULL,
    store_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (store_id) REFERENCES dim_store(store_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id)
);

----------------- INSERT CLEANED DATA ----------------------

-- Cleaned Dates (standard YYYY-MM-DD)
INSERT INTO dim_date VALUES
(1, '2025-01-01', 1, 1, 2025),
(2, '2025-01-02', 2, 1, 2025),
(3, '2025-01-03', 3, 1, 2025),
(4, '2025-01-04', 4, 1, 2025),
(5, '2025-01-05', 5, 1, 2025);


-- Cleaned Store Data (no NULLs, uniform naming)
INSERT INTO dim_store VALUES
(101, 'Mumbai Central Store', 'Mumbai', 'Maharashtra'),
(102, 'Delhi Main Store', 'Delhi', 'Delhi'),
(103, 'Bangalore Hub', 'Bangalore', 'Karnataka');


-- Cleaned Product Data (consistent category casing). Electronics different casing
INSERT INTO dim_product VALUES
(201, 'Laptop', 'Electronics'),
(202, 'Smartphone', 'Electronics'),
(203, 'Office Chair', 'Furniture'),
(204, 'Notebook', 'Stationery'),
(205, 'Pen Set', 'Stationery');

----------------- FACT TABLE DATA (CLEANED)

-- Assumptions:
-- - Removed NULL quantities
-- - Standardized prices into total_amount
-- - Fixed inconsistent categories via dimension table
-- - Dates mapped via surrogate keys

INSERT INTO fact_sales VALUES
(1, 1, 101, 201, 1, 55000.00),
(2, 1, 101, 204, 5, 600.00),
(3, 2, 102, 202, 2, 60000.00),
(4, 2, 102, 205, 3, 1050.00),
(5, 3, 103, 203, 1, 7000.00),
(6, 3, 101, 204, 10, 1200.00),
(7, 4, 102, 201, 1, 55000.00),
(8, 4, 103, 205, 4, 1400.00),
(9, 5, 101, 202, 1, 30000.00),
(10, 5, 103, 204, 8, 960.00);