SELECT DISTINCT TOP 3 DeptId, COUNT(*) AS TotalEmployees
FROM Employees
WHERE Salary > 20000
GROUP BY DeptId
HAVING COUNT(*) > 2
ORDER BY TotalEmployees DESC;

