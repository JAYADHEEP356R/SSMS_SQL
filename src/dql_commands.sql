/* ===============================
   DQL SCRIPT – DATA QUERY LANGUAGE
   =============================== */

USE data_engineering;
GO

-- 1. Select all columns
SELECT * FROM dbo.Employees;

-- 2. Select specific columns
SELECT EmployeeName, Salary
FROM dbo.Employees;

-- 3. WHERE clause
SELECT *
FROM dbo.Employees
WHERE Salary > 35000;

-- 4. AND / OR
SELECT *
FROM dbo.Employees
WHERE Salary > 30000 AND DeptId = 101;

-- 5. IN
SELECT *
FROM dbo.Employees
WHERE DeptId IN (101, 103);

-- 6. BETWEEN
SELECT *
FROM dbo.Employees
WHERE Salary BETWEEN 30000 AND 45000;

-- 7. LIKE (pattern)
SELECT *
FROM dbo.Employees
WHERE EmployeeName LIKE 'A%';

-- 8. DISTINCT
SELECT DISTINCT DeptId
FROM dbo.Employees;

-- 9. ORDER BY
SELECT *
FROM dbo.Employees
ORDER BY Salary DESC;

-- 10. TOP
SELECT TOP 2 *
FROM dbo.Employees
ORDER BY Salary DESC;

-- 11. Aggregate functions
SELECT 
    COUNT(*) AS TotalEmployees,
    AVG(Salary) AS AvgSalary,
    MIN(Salary) AS MinSalary,
    MAX(Salary) AS MaxSalary
FROM dbo.Employees;

-- 12. GROUP BY
SELECT DeptId, COUNT(*) AS EmpCount
FROM dbo.Employees
GROUP BY DeptId;

-- 13. HAVING
SELECT DeptId, AVG(Salary) AS AvgSalary
FROM dbo.Employees
GROUP BY DeptId
HAVING AVG(Salary) > 35000;
