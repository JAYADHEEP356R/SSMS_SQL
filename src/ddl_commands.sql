/* ===============================
   DDL SCRIPT – STRUCTURE
   =============================== */

-- create database data_engineering
--go

-- 2. Use Database
USE data_engineering
GO

-- 3. Create Department table
CREATE TABLE Departments (
    DeptId INT PRIMARY KEY,
    DeptName VARCHAR(50) NOT NULL
);

-- 4. Create Employees table with constraints
CREATE TABLE Employees (
    EmpId INT IDENTITY(1,1) PRIMARY KEY,
    EmpName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Salary INT CHECK (Salary > 0),
    DeptId INT,
    Status VARCHAR(20) DEFAULT 'Active',

    CONSTRAINT fk_dept
    FOREIGN KEY (DeptId)
    REFERENCES Departments(DeptId)
);

-- 5. Alter table - add column
ALTER TABLE Employees
ADD JoiningDate DATE;

-- 6. Alter table - modify column
ALTER TABLE Employees
ALTER COLUMN EmpName VARCHAR(100);

-- 7. Rename column
EXEC sp_rename 'Employees.EmpName', 'EmployeeName', 'COLUMN';

-- 8. Truncate table (structure remains)
-- TRUNCATE TABLE Employees;

-- 9. Drop table (structure + data removed)
-- DROP TABLE Employees;

-- 10. Drop database
-- DROP DATABASE data_engineering;
