-- Customers
CREATE TABLE Customers (
    customer_id   VARCHAR(10)  PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    customer_email VARCHAR(150) NOT NULL UNIQUE,
    customer_city VARCHAR(50)  NOT NULL
);

INSERT INTO Customers VALUES ('C001', 'Rohan Mehta',  'rohan@gmail.com',  'Mumbai');
INSERT INTO Customers VALUES ('C002', 'Priya Sharma', 'priya@gmail.com',  'Delhi');
INSERT INTO Customers VALUES ('C003', 'Amit Verma',   'amit@gmail.com',   'Bangalore');
INSERT INTO Customers VALUES ('C004', 'Sneha Iyer',   'sneha@gmail.com',  'Chennai');
INSERT INTO Customers VALUES ('C005', 'Vikram Singh', 'vikram@gmail.com', 'Mumbai');
INSERT INTO Customers VALUES ('C006', 'Neha Gupta',   'neha@gmail.com',   'Delhi');
INSERT INTO Customers VALUES ('C007', 'Arjun Nair',   'arjun@gmail.com',  'Bangalore');
INSERT INTO Customers VALUES ('C008', 'Kavya Rao',    'kavya@gmail.com',  'Hyderabad');


-- Products
CREATE TABLE Products (
    product_id   VARCHAR(10)   PRIMARY KEY,
    product_name VARCHAR(100)  NOT NULL,
    category     VARCHAR(50)   NOT NULL,
    unit_price   DECIMAL(10,2) NOT NULL CHECK (unit_price > 0)
);

INSERT INTO Products VALUES ('P001', 'Laptop',        'Electronics', 55000.00);
INSERT INTO Products VALUES ('P002', 'Mouse',         'Electronics',   800.00);
INSERT INTO Products VALUES ('P003', 'Desk Chair',    'Furniture',    8500.00);
INSERT INTO Products VALUES ('P004', 'Notebook',      'Stationery',    120.00);
INSERT INTO Products VALUES ('P005', 'Headphones',    'Electronics',  3200.00);
INSERT INTO Products VALUES ('P006', 'Standing Desk', 'Furniture',   22000.00);
INSERT INTO Products VALUES ('P007', 'Pen Set',       'Stationery',    250.00);
INSERT INTO Products VALUES ('P008', 'Webcam',        'Electronics',  2100.00);


-- SalesReps
CREATE TABLE SalesReps (
    sales_rep_id   VARCHAR(10)  PRIMARY KEY,
    sales_rep_name VARCHAR(100) NOT NULL,
    sales_rep_email VARCHAR(150) NOT NULL UNIQUE,
    office_address  VARCHAR(255) NOT NULL
);

INSERT INTO SalesReps VALUES ('SR01', 'Deepak Joshi', 'deepak@corp.com', 'Mumbai HQ, Nariman Point, Mumbai - 400021');
INSERT INTO SalesReps VALUES ('SR02', 'Anita Desai',  'anita@corp.com',  'Delhi Office, Connaught Place, New Delhi - 110001');
INSERT INTO SalesReps VALUES ('SR03', 'Ravi Kumar',   'ravi@corp.com',   'South Zone, MG Road, Bangalore - 560001');


-- Orders
CREATE TABLE Orders (
    order_id     VARCHAR(10)  PRIMARY KEY,
    customer_id  VARCHAR(10)  NOT NULL,
    product_id   VARCHAR(10)  NOT NULL,
    sales_rep_id VARCHAR(10)  NOT NULL,
    quantity     INT          NOT NULL CHECK (quantity > 0),
    order_date   DATE         NOT NULL,

    FOREIGN KEY (customer_id)  REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id)   REFERENCES Products(product_id),
    FOREIGN KEY (sales_rep_id) REFERENCES SalesReps(sales_rep_id)
);

INSERT INTO Orders VALUES ('ORD1027', 'C002', 'P004', 'SR02', 4,  '2023-11-02');
INSERT INTO Orders VALUES ('ORD1114', 'C001', 'P007', 'SR01', 2,  '2023-08-06');
INSERT INTO Orders VALUES ('ORD1153', 'C006', 'P007', 'SR01', 3,  '2023-02-14');
INSERT INTO Orders VALUES ('ORD1002', 'C002', 'P005', 'SR02', 1,  '2023-01-17');
INSERT INTO Orders VALUES ('ORD1118', 'C006', 'P007', 'SR02', 5,  '2023-11-10');
INSERT INTO Orders VALUES ('ORD1132', 'C003', 'P007', 'SR02', 5,  '2023-03-07');
INSERT INTO Orders VALUES ('ORD1075', 'C005', 'P003', 'SR03', 3,  '2023-04-18');
INSERT INTO Orders VALUES ('ORD1091', 'C001', 'P006', 'SR01', 3,  '2023-07-24');
INSERT INTO Orders VALUES ('ORD1185', 'C003', 'P008', 'SR03', 1,  '2023-06-15');
INSERT INTO Orders VALUES ('ORD1076', 'C004', 'P006', 'SR03', 5,  '2023-05-16');
