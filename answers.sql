-- Question 1: Achieving 1NF
-- Original table ProductDetail had repeating groups in the Products column.
-- Transform into 1NF by splitting multiple products into separate rows.

CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(50)
);

INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product) VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');


-- Question 2: Achieving 2NF
-- OrderDetails is in 1NF but has partial dependency: CustomerName depends only on OrderID.
-- Solution: Split into two tables:
--   1. Orders (OrderID, CustomerName)  
--   2. OrderItems (OrderID, Product, Quantity)

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(50),
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert data into Orders
INSERT INTO Orders (OrderID, CustomerName) VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- Insert data into OrderItems
INSERT INTO OrderItems (OrderID, Product, Quantity) VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);


-- Question 3: Achieving 3NF
-- Suppose we extend Orders with CustomerAddress (which depends on CustomerName, not directly on OrderID).
-- This creates a transitive dependency that violates 3NF.
-- Solution: Separate Customers into its own table.

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    CustomerAddress VARCHAR(150)
);

-- Update Orders to reference Customers instead of storing CustomerName directly
CREATE TABLE Orders_3NF (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Insert data into Customers
INSERT INTO Customers (CustomerID, CustomerName, CustomerAddress) VALUES
(1, 'John Doe', '123 Main St'),
(2, 'Jane Smith', '456 Oak Ave'),
(3, 'Emily Clark', '789 Pine Rd');

-- Insert data into Orders_3NF
INSERT INTO Orders_3NF (OrderID, CustomerID) VALUES
(101, 1),
(102, 2),
(103, 3);
