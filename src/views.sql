/* =========================================================
   1. SIMPLE VIEW (Basic SELECT)
   ========================================================= */
CREATE VIEW vw_AllEmployees
AS
SELECT *
FROM Employees;
GO


/* =========================================================
   2. COLUMN-SPECIFIC VIEW
   (Hides sensitive columns like Salary)
   ========================================================= */
CREATE VIEW vw_EmployeeBasicInfo
AS
SELECT EmpId, EmployeeName, Email, DeptId, Status
FROM Employees;
GO


/* =========================================================
   3. FILTERED VIEW (WHERE clause)
   ========================================================= */
CREATE VIEW vw_ActiveEmployees
AS
SELECT *
FROM Employees
WHERE Status = 'Active';
GO


/* =========================================================
   4. AGGREGATE VIEW (GROUP BY)
   ========================================================= */
CREATE VIEW vw_DepartmentSalaryTotal
AS
SELECT DeptId, SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY DeptId;
GO


/* =========================================================
   5. VIEW WITH HAVING CLAUSE
   ========================================================= */
CREATE VIEW vw_DepartmentsWithHighSalary
AS
SELECT DeptId, SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY DeptId
HAVING SUM(Salary) > 80000;
GO


/* =========================================================
   6. VIEW USING SUBQUERY
   (Employees earning above dept average)
   ========================================================= */
CREATE VIEW vw_AboveDeptAverageSalary
AS
SELECT e.*
FROM Employees e
WHERE Salary >
(
    SELECT AVG(Salary)
    FROM Employees
    WHERE DeptId = e.DeptId
);
GO


/* =========================================================
   7. VIEW WITH CALCULATED COLUMN
   ========================================================= */
CREATE VIEW vw_SalaryCategory
AS
SELECT 
    EmpId,
    EmployeeName,
    Salary,
    CASE
        WHEN Salary >= 50000 THEN 'High'
        WHEN Salary BETWEEN 40000 AND 49999 THEN 'Medium'
        ELSE 'Low'
    END AS SalaryCategory
FROM Employees;
GO


/* =========================================================
   8. VIEW WITH DATE FUNCTION
   ========================================================= */
CREATE VIEW vw_EmployeeExperience
AS
SELECT 
    EmpId,
    EmployeeName,
    JoiningDate,
    DATEDIFF(YEAR, JoiningDate, GETDATE()) AS ExperienceYears
FROM Employees;
GO


/* =========================================================
   9. SCHEMABINDING VIEW
   (Prevents table structure changes)
   ========================================================= */
CREATE VIEW vw_SchemaBoundEmployees
WITH SCHEMABINDING
AS
SELECT EmpId, EmployeeName, Salary, DeptId
FROM dbo.Employees;
GO


/* =========================================================
   10. UPDATABLE VIEW
   (Can INSERT / UPDATE through view)
   ========================================================= */
CREATE VIEW vw_UpdatableEmployees
AS
SELECT EmpId, EmployeeName, Email, Salary
FROM Employees;
GO


/* =========================================================
   11. READ-ONLY VIEW (WITH CHECK OPTION)
   ========================================================= */
CREATE VIEW vw_OnlyActiveEmployees
AS
SELECT *
FROM Employees
WHERE Status = 'Active'
WITH CHECK OPTION;
GO



/* =========================================================
   1. SIMPLE VIEW – ALL EMPLOYEES
   ========================================================= */
SELECT *
FROM vw_AllEmployees;
GO


/* =========================================================
   2. COLUMN-SPECIFIC VIEW – BASIC EMPLOYEE INFO
   ========================================================= */
SELECT *
FROM vw_EmployeeBasicInfo;
GO


/* =========================================================
   3. FILTERED VIEW – ONLY ACTIVE EMPLOYEES
   ========================================================= */
SELECT *
FROM vw_ActiveEmployees;
GO


/* =========================================================
   4. AGGREGATE VIEW – TOTAL SALARY PER DEPARTMENT
   ========================================================= */
SELECT *
FROM vw_DepartmentSalaryTotal;
GO


/* =========================================================
   5. HAVING VIEW – DEPARTMENTS WITH HIGH TOTAL SALARY
   ========================================================= */
SELECT *
FROM vw_DepartmentsWithHighSalary;
GO


/* =========================================================
   6. SUBQUERY VIEW – EMPLOYEES ABOVE DEPT AVERAGE SALARY
   ========================================================= */
SELECT *
FROM vw_AboveDeptAverageSalary;
GO


/* =========================================================
   7. CALCULATED COLUMN VIEW – SALARY CATEGORY
   ========================================================= */
SELECT *
FROM vw_SalaryCategory;
GO
