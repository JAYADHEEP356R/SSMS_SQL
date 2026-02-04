select AccountId from Accounts where Balance > (select avg(Balance) from Accounts)



--select DeptId,sum(Salary) as total_salary from Employees group by DeptId having sum(Salary) = (select max(list_sal) from (select sum(Salary) as list_sal from Employees group by DeptId) t )


SELECT DeptId,
       SUM(Salary) AS total_salary
FROM Employees
GROUP BY DeptId
HAVING SUM(Salary) = (
    SELECT MAX(list_sal)
    FROM (
        SELECT SUM(Salary) AS list_sal
        FROM Employees
        GROUP BY DeptId
    ) t
);


select max(list_sal) from (select sum(Salary) as list_sal from Employees group by DeptId) t ; -- cheking the subquery first



select * from Employees;