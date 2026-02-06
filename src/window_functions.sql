


SELECT EmpName, DeptId, Salary,
       ROW_NUMBER() OVER (PARTITION BY DeptId ORDER BY Salary DESC) AS rn
FROM Employees;


SELECT EmpName, DeptId, Salary,
       SUM(Salary) OVER (PARTITION BY DeptId) AS DeptTotal
FROM Employees;


SELECT EmpName, Salary,
       Lag(Salary) OVER (ORDER BY Salary) AS PrevSalary
FROM Employees;


SELECT EmpName, Salary,
       LEAD(Salary) OVER (ORDER BY Salary) AS NextSalary
FROM Employees;

SELECT EmpName, DeptId, Salary,
       FIRST_VALUE (Salary)
       OVER (PARTITION BY DeptId ORDER BY Salary DESC) AS HighestSalary
FROM Employees;


SELECT EmpName, Salary,
       PERCENT_RANK() OVER (ORDER BY Salary) AS pct_rank
FROM Employees;

SELECT EmpName, Salary,
       CUME_DIST() OVER (ORDER BY Salary) AS cum_dist
FROM Employees