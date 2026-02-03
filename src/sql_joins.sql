/* =========================================================
   STEP 1: DROP TABLES IF THEY ALREADY EXIST
   ========================================================= */
IF OBJECT_ID('Orders', 'U') IS NOT NULL DROP TABLE Orders;
IF OBJECT_ID('Customers', 'U') IS NOT NULL DROP TABLE Customers;


/* =========================================================
   STEP 2: CREATE CUSTOMER TABLE
   ========================================================= */
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);


/* =========================================================
   STEP 3: CREATE ORDERS TABLE
   ========================================================= */
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_amount DECIMAL(10,2),
    order_date DATE
);


/* =========================================================
   STEP 4: INSERT SAMPLE DATA INTO CUSTOMERS
   ========================================================= */
INSERT INTO Customers VALUES
(1, 'Ravi',  'Chennai'),
(2, 'Anita', 'Bangalore'),
(3, 'John',  'Mumbai'),
(4, 'Meena', 'Delhi'),
(5, 'Arun',  'Hyderabad');


/* =========================================================
   STEP 5: INSERT SAMPLE DATA INTO ORDERS
   ========================================================= */
INSERT INTO Orders VALUES
(101, 1, 500.00, '2024-01-10'),
(102, 1, 300.00, '2024-01-12'),
(103, 2, 700.00, '2024-01-15'),
(104, 4, 450.00, '2024-01-18'),
(105, NULL, 900.00, '2024-01-20');  -- orphan order (no customer)

SELECT * FROM Customers;
SELECT * FROM Orders;


/* =========================================================
   STEP 6: INNER JOIN
   (Only matching records)
   ========================================================= */
SELECT
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.order_amount
FROM Customers c
INNER JOIN Orders o
ON c.customer_id = o.customer_id;


/* =========================================================
   STEP 7: LEFT JOIN
   (All customers, even without orders)
   ========================================================= */
SELECT
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.order_amount
FROM Customers c
LEFT JOIN Orders o
ON c.customer_id = o.customer_id;


/* =========================================================
   STEP 8: RIGHT JOIN
   (All orders, even without customers)
   ========================================================= */
SELECT
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.order_amount
FROM Customers c
RIGHT JOIN Orders o
ON c.customer_id = o.customer_id;


/* =========================================================
   STEP 9: FULL OUTER JOIN
   (All records from both tables)
   ========================================================= */
SELECT
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.order_amount
FROM Customers c
FULL OUTER JOIN Orders o
ON c.customer_id = o.customer_id;  --union of left join and right join


/* =========================================================
   STEP 10: CROSS JOIN
   (Cartesian product)
   ========================================================= */
SELECT
    c.customer_name,
    o.order_id
FROM Customers c
CROSS JOIN Orders o; --- dont have on clause....what it does is cartesian product ....its process is like a nested for loop (i stays in one pos , j traverse full list, after i moves to second and j same)


/* =========================================================
   STEP 11: SELF JOIN
   (Customers from same city)
   ========================================================= */
SELECT
    c1.customer_name AS Customer1,
    c2.customer_name AS Customer2,
    c1.city
FROM Customers c1
JOIN Customers c2
ON c1.city = c2.city 
AND c1.customer_id <> c2.customer_id;


/* =========================================================
   STEP 12: SEMI JOIN (EXISTS)
   Customers who have placed orders
   ========================================================= */
SELECT *
FROM Customers c
WHERE EXISTS (
    SELECT 1
    FROM Orders o
    WHERE o.customer_id = c.customer_id
);


/* =========================================================
   STEP 13: SEMI JOIN (IN)
   ========================================================= */
SELECT *
FROM Customers
WHERE customer_id IN (
    SELECT customer_id
    FROM Orders
    WHERE customer_id IS NOT NULL
);


/* =========================================================
   STEP 14: ANTI JOIN (NOT EXISTS)
   Customers with NO orders
   ========================================================= */
SELECT *
FROM Customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM Orders o
    WHERE o.customer_id = c.customer_id
);


/* =========================================================
   STEP 15: ANTI JOIN (LEFT JOIN + IS NULL)
   ========================================================= */
SELECT c.*
FROM Customers c
LEFT JOIN Orders o
ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;


SELECT  DISTINCT c.*
FROM Customers c
JOIN Orders o
ON o.customer_id = c.customer_id;
 