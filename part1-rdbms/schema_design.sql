Create TABLE Customer_Master (
  customer_id varchar(10) PRIMARY KEY,
  customer_name varchar(100) NOT NULL,
  customer_email varchar(50) NOT NULL UNIQUE,	
  customer_city varchar(50) NOT NULL
);

Create TABLE Product_Master (
  product_id varchar(10) PRIMARY KEY,
  product_name varchar(100) NOT NULL,
  category varchar(50) NOT NULL,	
  unit_price decimal(10,2) NOT NULL
);

CREATE TABLE Sales_Rep (
    sales_rep_id VARCHAR(10) PRIMARY KEY,
    sales_rep_name VARCHAR(100) NOT NULL,
    sales_rep_email VARCHAR(100) NOT NULL UNIQUE,
    office_address VARCHAR(200) NOT NULL
);

CREATE TABLE Orders (
    order_id VARCHAR(10) PRIMARY KEY,
    customer_id VARCHAR(10) NOT NULL,
    sales_rep_id VARCHAR(10) NOT NULL,
    order_date DATE NOT NULL,

    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (sales_rep_id) REFERENCES Sales_Reps(sales_rep_id)
);

--handling many-to-many relationship between Orders and Products
CREATE TABLE Order_Line (
    order_item_id INT PRIMARY KEY,
    order_id VARCHAR(10) NOT NULL,
    product_id VARCHAR(10) NOT NULL,
    quantity INT NOT NULL,

    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);


INSERT INTO Customer_Master VALUES
('C001','Rohan Mehta','rohan.mehta@email.com','Mumbai'),
('C005','Vikram Singh','vikram@gmail.com','Mumbai'),
('C003','Amit Verma','amit@gmail.com','Bangalore'),
('C004','Sneha Iyer','sneha.iyer@email.com','Chennai'),
('C002','Priya Sharma','priya@gmail.com','Delhi');

INSERT INTO Product_Master VALUES
('P001','Mouse','Electronics',800),
('P002','Standing Desk','Furniture',22000),
('P003','Desk Chair','Furniture',8500),
('P004','Headphones','Electronics',3200),
('P005','Pen Set','Stationery',250);

INSERT INTO Sales_Rep VALUES
('SR01','Deepak Joshi','deepak@corp.com','Mumbai HQ, Nariman Point, Mumbai - 400021'),
('SR02','Anita Desai','anita@corp.com','Delhi Office, Connaught Place, New Delhi - 110001'),
('SR03','Ravi Kumar','ravi@corp.com','South Zone, MG Road, Bangalore - 560001'),
('SR04','Neha Kapoor','neha@corp.com','Pune Chakan'),
('SR05','Arjun Singh','arjun@corp.com','Hyderabad Airport');


INSERT INTO Orders VALUES
('ORD1114','C001','SR01','06-08-2023'),
('ORD1037','C002','SR03','06-03-2023'),
('ORD1132','C003','SR02','07-03-2023'),
('ORD1043','C004','SR01','04-01-2023'),
('ORD1075','C005','SR03','18-04-2023');


INSERT INTO Order_Line VALUES
(1,'ORD1114','P007',2),
(2,'ORD1037','P007',2),
(3,'ORD1132','P007',5),
(4,'ORD1043','P005',1),
(5,'ORD1075','P003',3);