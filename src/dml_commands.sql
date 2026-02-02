/* ===============================
   DML SCRIPT – DATA
   =============================== */

USE data_engineering;
GO

-- 1. Insert into Departments
INSERT INTO Departments (DeptId, DeptName)
VALUES
(101, 'HR'),
(102, 'IT'),
(103, 'Finance');

-- 2. Insert into Employees
INSERT INTO Employees (EmployeeName, Email, Salary, DeptId, JoiningDate)
VALUES
('Ravi Kumar', 'ravi@gmail.com', 35000, 101, '2023-06-01'),
('Anita Sharma', 'anita@gmail.com', 42000, 102, '2022-08-15'),
('Karthik', 'karthik@gmail.com', 30000, 101, '2024-01-10'),
('Meena', 'meena@gmail.com', 38000, 103, '2023-03-20');

-- 3. Select all data
SELECT * FROM Employees;

-- 4. Select with condition
SELECT EmployeeName, Salary
FROM Employees
WHERE Salary > 35000;

-- 5. Update salary
UPDATE Employees
SET Salary = Salary + 5000
WHERE DeptId = 101;

-- 6. Delete one record
DELETE FROM Employees
WHERE EmployeeName = 'Karthik';

-- 7. Transaction example
BEGIN TRANSACTION;

UPDATE Employees
SET Salary = Salary - 3000
WHERE EmployeeName = 'Ravi Kumar';

-- Check before commit
SELECT * FROM Employees;

-- Rollback change
ROLLBACK;
-- COMMIT;
